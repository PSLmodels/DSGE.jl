"""
```
solve(m::AbstractDSGEModel)
```

Driver to compute the model solution and augment transition matrices.

### Inputs

- `m`: the model object

## Keyword Arguments

- `regime_switching::Bool`: true if the state space system features regime switching
- `regimes::Union{Int, Vector{Int}, UnitRange{Int}}`: specifies the specific regime to solve for.

### Outputs
 - TTT, RRR, and CCC matrices of the state transition equation:
```
S_t = TTT*S_{t-1} + RRR*ϵ_t + CCC
```
"""
function solve(m::AbstractDSGEModel{T}; regime_switching::Bool = false,
               gensys_regimes::Vector{UnitRange{Int64}} = UnitRange{Int64}[1:1],
               gensys2_regimes::Vector{UnitRange{Int64}} = Vector{UnitRange{Int}}(undef, 0),
               regimes::Vector{Int} = Int[1],
               verbose::Symbol = :high) where {T <: Real}

    uncertain_altpolicy = haskey(get_settings(m), :uncertain_altpolicy) && get_setting(m, :uncertain_altpolicy)
    if regime_switching
        return solve_regime_switching(m; gensys_regimes = gensys_regimes,
                                      gensys2_regimes = gensys2_regimes, regimes = regimes,
                                      uncertain_altpolicy = uncertain_altpolicy,
                                      verbose = verbose)
    else
        # do NOT delete this Boolean for apply_altpolicy; it is needed for
        # the scenarios code, which continues to use :alternative_policy as a Setting,
        # AND for implementing imperfect awareness via uncertain_altpolicy
        apply_altpolicy = haskey(get_settings(m), :alternative_policy) && get_setting(m, :alternative_policy).solve != solve
        if get_setting(m, :solution_method) == :gensys
            if !apply_altpolicy

                # Get equilibrium condition matrices
                Γ0, Γ1, C, Ψ, Π = eqcond(m)

                # Solve model
                TTT_gensys, CCC_gensys, RRR_gensys, eu = gensys(Γ0, Γ1, C, Ψ, Π, 1+1e-6, verbose = verbose)

                # Check for LAPACK exception, existence and uniqueness
                if eu[1] != 1 || eu[2] != 1
                    throw(GensysError())
                end

                TTT_gensys = real(TTT_gensys)
                RRR_gensys = real(RRR_gensys)
                CCC_gensys = real(CCC_gensys)

                # Augment states
                TTT, RRR, CCC = augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys)
            else
                # do NOT delete this else block; it is needed for
                # the scenarios code, which continues to use :alternative_policy as a Setting
                # and the original method for implementing alternative policies
                # (when DSGE.jl was created in 2015)
                # AND for implementing imperfect awareness via uncertain_altpolicy

                # Change the policy rule
                TTT, RRR, CCC = get_setting(m, :alternative_policy).solve(m)
            end

            if uncertain_altpolicy && apply_altpolicy
                weights = get_setting(m, :regime_eqcond_info)[1].weights
                altpols = get_setting(m, :alternative_policies)

                TTT_gensys, RRR_gensys, CCC_gensys =
                    gensys_uncertain_altpol(m, weights, altpols; TTT = TTT[inds, inds])

                # Augment states
                TTT, RRR, CCC = augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys)
            end
        elseif get_setting(m, :solution_method) == :klein
            TTT_jump, TTT_state = klein(m)

            # Transition
            TTT, RRR = klein_transition_matrices(m, TTT_state, TTT_jump)
            CCC = zeros(n_model_states(m))
        end

        return TTT, RRR, CCC
    end
end

"""
solve(m::PoolModel)
```

Driver to compute the model solution when using the PoolModel type

### Inputs

- `m`: the PoolModel object

### Outputs
- Φ: transition function
- F_ϵ: distribution of structural shock
- F_λ: prior on the initial λ_0

"""
function solve(m::PoolModel)
    return transition(m)
end

"""
```
GensysError <: Exception
```
A `GensysError` is thrown when:

1. Gensys does not give existence and uniqueness, or
2. A LAPACK error was thrown while computing the Schur decomposition of Γ0 and Γ1

If a `GensysError`is thrown during Metropolis-Hastings, it is caught by
`posterior`.  `posterior` then returns a value of `-Inf`, which
Metropolis-Hastings always rejects.

### Fields

* `msg::String`: Info message. Default = \"Error in Gensys\"
"""
mutable struct GensysError <: Exception
    msg::String
end
GensysError() = GensysError("Error in Gensys")
Base.showerror(io::IO, ex::GensysError) = print(io, ex.msg)

"""
```
KleinError <: Exception
```
A `KleinError` is thrown when:
1. A LAPACK error was thrown while computing the pseudo-inverse of U22*U22'

If a `KleinError`is thrown during Metropolis-Hastings, it is caught by
`posterior`.  `posterior` then returns a value of `-Inf`, which
Metropolis-Hastings always rejects.

### Fields

* `msg::String`: Info message. Default = \"Error in Klein\"
"""
mutable struct KleinError <: Exception
    msg::String
end
KleinError() = KleinError("Error in Klein")
Base.showerror(io::IO, ex::KleinError) = print(io, ex.msg)

"""
```
solve_regime_switching(m::AbstractDSGEModel)

solve_one_regime(m::AbstractDSGEModel)

solve_non_gensys2_regimes!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ01::Vector{Matrix{S}},
    Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}};
    TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}};
    regimes::Vector{Int} = Int[1], uncertain_altpolicy::Bool = false,
    altpolicy_solve::Function = solve, verbose::Symbol = :high)

solve_gensys2!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ01::Vector{Matrix{S}},
    Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
    TTT_gensys_final::AbstractMatrix{S}, RRR_gensys_final::AbstractMatrix{S},
    CCC_gensys_final::AbstractMatrix{S},
    TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}};
    fcast_gensys2_regimes::Vector{Int} = Int[1], verbose::Symbol = :high)
```

calculates the reduced form state transition matrices in the case of regime switching.
These functions are intended to be internal functions hidden from the user but are separate
from the definition of the main `solve` function to ensure the main function is
comprehensible.
"""
function solve_regime_switching(m::AbstractDSGEModel{T};
                                uncertain_altpolicy::Bool = false,
                                gensys_regimes::Vector{UnitRange{Int64}} = UnitRange{Int64}[1:1],
                                gensys2_regimes::Vector{UnitRange{Int64}} = Vector{UnitRange{Int64}}(undef, 0),
                                regimes::Vector{Int} = Int[1],
                                verbose::Symbol = :high) where {T <: Real}

    altpolicy_solve = alternative_policy(m).solve
    gensys2 = haskey(get_settings(m), :gensys2) && get_setting(m, :gensys2)
    uncertain_temporary_altpolicy = haskey(get_settings(m), :uncertain_temporary_altpolicy) && get_setting(m, :uncertain_temporary_altpolicy)
    replace_eqcond = haskey(get_settings(m), :replace_eqcond) && get_setting(m, :replace_eqcond)

    if get_setting(m, :solution_method) == :gensys
        if length(regimes) == 1 # Calculate the solution to a specific regime
            return solve_one_regime(m; regime = regimes[1],
                                    uncertain_altpolicy = uncertain_altpolicy, verbose = verbose)
        else # Calculate the reduced-form state space matrices for all regimes
            Γ0s = Vector{Matrix{Float64}}(undef, length(regimes))
            Γ1s = Vector{Matrix{Float64}}(undef, length(regimes))
            Cs = Vector{Vector{Float64}}(undef, length(regimes))
            Ψs = Vector{Matrix{Float64}}(undef, length(regimes))
            Πs = Vector{Matrix{Float64}}(undef, length(regimes))

            do_replace_eqcond = haskey(get_settings(m), :replace_eqcond) && get_setting(m, :replace_eqcond) &&
                haskey(get_settings(m), :regime_eqcond_info)
            has_eqcond_reg_map = haskey(get_settings(m), :identical_eqcond_regimes)
            for reg in regimes
                if has_eqcond_reg_map && haskey(get_setting(m, :identical_eqcond_regimes), reg)
                    reg_to_copy = get_setting(m, :identical_eqcond_regimes)[reg]
                    Γ0s[reg] = copy(Γ0s[reg_to_copy])
                    Γ1s[reg] = copy(Γ1s[reg_to_copy])
                    Cs[reg]  = copy( Cs[reg_to_copy])
                    Ψs[reg]  = copy( Ψs[reg_to_copy])
                    Πs[reg]  = copy( Πs[reg_to_copy])
                else
                    Γ0s[reg], Γ1s[reg], Cs[reg], Ψs[reg], Πs[reg] = do_replace_eqcond && haskey(get_setting(m, :regime_eqcond_info), reg) ?
                        get_setting(m, :regime_eqcond_info)[reg].alternative_policy.eqcond(m, reg) : eqcond(m, reg)
                end
            end

            TTTs = Vector{Matrix{Float64}}(undef, length(regimes))
            RRRs = Vector{Matrix{Float64}}(undef, length(regimes))
            CCCs = Vector{Vector{Float64}}(undef, length(regimes))

            # Solve model for gensys regimes
            for reg_range in gensys_regimes
                solve_non_gensys2_regimes!(m, Γ0s, Γ1s, Cs, Ψs, Πs, TTTs, RRRs, CCCs;
                                           regimes = collect(reg_range),
                                           uncertain_altpolicy = uncertain_altpolicy,
                                           verbose = verbose)
            end

            # Solve for gensys2 regimes
            if gensys2
                for reg_range in gensys2_regimes
                    solve_gensys2!(m, Γ0s, Γ1s, Cs, Ψs, Πs,
                                   TTTs, RRRs, CCCs; gensys2_regimes = collect(reg_range),
                                   uncertain_altpolicy = uncertain_altpolicy,
                                   uncertain_temporary_altpolicy = uncertain_temporary_altpolicy,
                                   verbose = verbose)
                end
            end

            return TTTs, RRRs, CCCs
        end
    else
        error("Regime switching has not been implemented for other solution methods.")
    end
end

function solve_one_regime(m::AbstractDSGEModel{T}; regime::Int = 1, uncertain_altpolicy::Bool = false,
                          verbose::Symbol = :high) where {T <: Real}

    # do NOT delete the second part of the Boolean for apply_altpolicy; it is needed for
    # the scenarios code, which continues to use :alternative_policy as a Setting
    apply_altpolicy = haskey(get_settings(m), :regime_eqcond_info) ||
        (haskey(get_settings(m), :alternative_policy) && get_setting(m, :alternative_policy).key != :historical)
    altpolicy_solve = alternative_policy(m).solve

    if altpolicy_solve == solve || !apply_altpolicy

        # Get equilibrium condition matrices
        Γ0, Γ1, C, Ψ, Π  = eqcond(m, regime)

        # Solve model
        TTT_gensys, CCC_gensys, RRR_gensys, eu = gensys(Γ0, Γ1, C, Ψ, Π, 1+1e-6, verbose = verbose)

        # Check for LAPACK exception, existence and uniqueness
        if eu[1] != 1 || eu[2] != 1
            throw(GensysError())
        end

        TTT_gensys = real(TTT_gensys)
        RRR_gensys = real(RRR_gensys)
        CCC_gensys = real(CCC_gensys)

        # Augment states
        TTT, RRR, CCC = augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys; regime_switching = true,
                                       reg = regime)
    else
        TTT, RRR, CCC = altpolicy_solve(m; regime_switching = true, regimes = Int[regime])
    end

    if uncertain_altpolicy && apply_altpolicy
        # Since we only have one regime in solve_one_regime, no time-varying credibility
        weights = get_setting(m, :regime_eqcond_info)[regime].weights
        altpols = get_setting(m, :alternative_policies)
        inds = 1:n_states(m)
        TTT_gensys, RRR_gensys, CCC_gensys = gensys_uncertain_altpol(m, weights, altpols; TTT = TTT[inds, inds],
                                                                     regimes = Int[regime])

        # Augment states
        TTT, RRR, CCC = augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys; regime_switching = true,
                                       reg = regime)
    end

    return TTT, RRR, CCC
end

function solve_non_gensys2_regimes!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ1s::Vector{Matrix{S}},
                                    Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
                                    TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}};
                                    regimes::Vector{Int} = Int[1], uncertain_altpolicy::Bool = false,
                                    verbose::Symbol = :high) where {S <: Real}

    # TODO: the commented step below should be unnecessary?
    # uncertain_altpol = haskey(get_settings(m), :uncertain_altpolicy) && get_setting(m, :uncertain_altpolicy)
    uncertain_altpol = uncertain_altpolicy
    has_perf_cred_same_reg = haskey(get_settings(m), :perfect_credibility_identical_transitions)
    if has_perf_cred_same_reg
        perf_cred_same_reg = get_setting(m, :perfect_credibility_identical_transitions)
    end
    if uncertain_altpol
        altpols = get_setting(m, :alternative_policies)
    end

    for reg in regimes
        # Check if, in the case of perfect credibility, whether or not the current regime's gensys solution
        # is identical to another regime's that has already been computed
        if !uncertain_altpol && has_perf_cred_same_reg && haskey(perf_cred_same_reg, reg) && perf_cred_same_reg[reg] != reg
            TTTs[reg] = TTTs[perf_cred_same_reg[reg]]
            RRRs[reg] = RRRs[perf_cred_same_reg[reg]]
            CCCs[reg] = CCCs[perf_cred_same_reg[reg]]

            continue # if so, skip the remainder of this loop
        end

        TTT_gensys, CCC_gensys, RRR_gensys, eu =
            gensys(Γ0s[reg], Γ1s[reg], Cs[reg], Ψs[reg], Πs[reg],
                   1+1e-6, verbose = verbose)

        # Check for LAPACK exception, existence and uniqueness
        if eu[1] != 1 || eu[2] != 1
            throw(GensysError("Error in Gensys, Regime $reg"))
        end

        if uncertain_altpolicy && haskey(get_settings(m), :regime_eqcond_info) && haskey(get_setting(m, :regime_eqcond_info), reg)
            weights = get_setting(m, :regime_eqcond_info)[reg].weights
            if !isempty(weights)
                # Time-varying credibility weights for the regime reg
                altpols = get_setting(m, :alternative_policies)
                TTT_gensys, RRR_gensys, CCC_gensys =
                    gensys_uncertain_altpol(m, weights, altpols; TTT = TTT_gensys,
                                            regime_switching = true, regimes = Int[reg])
            end
        end

        TTT_gensys = real(TTT_gensys)
        RRR_gensys = real(RRR_gensys)
        CCC_gensys = real(CCC_gensys)

        # Populate the TTTs, etc., for regime `reg`
        TTTs[reg], RRRs[reg], CCCs[reg] =
            augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys, reg = reg)
    end

    return TTTs, RRRs, CCCs
end

function solve_gensys2!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ1s::Vector{Matrix{S}},
                        Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
                        TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}};
                        gensys2_regimes::Vector{Int} = Vector{Int}(undef, 0),
                        uncertain_altpolicy::Bool = false, uncertain_temporary_altpolicy::Bool = false,
                        verbose::Symbol = :high) where {S <: Real}

    # Solve for the final regime of the alternative rule
    altpolicy_solve = alternative_policy(m).solve
    TTT_final, RRR_final, CCC_final = altpolicy_solve(m; regime_switching = true,
                                                      regimes = Int[last(gensys2_regimes)])

    n_endo = length(m.endogenous_states)
    TTT_final = TTT_final[1:n_endo, 1:n_endo] # make sure the non-augmented version
    RRR_final = RRR_final[1:n_endo, :]        # is returned
    CCC_final = CCC_final[1:n_endo]

    TTT_final = real(TTT_final)
    RRR_final = real(RRR_final)
    CCC_final = real(CCC_final)

    # if we're using an uncertain alternative policy, we have to compute the
    # weighted final transition matrix
    if uncertain_altpolicy
        weights = get_setting(m, :regime_eqcond_info)[last(gensys2_regimes)].weights
        altpols = get_setting(m, :alternative_policies)

        TTT_final_weighted, RRR_final_weighted, CCC_final_weighted =
            gensys_uncertain_altpol(m, weights, altpols; TTT = TTT_final,
                                    regimes = Int[last(gensys2_regimes)])

        TTT_final_weighted = real(TTT_final_weighted) # need to define this as different
        RRR_final_weighted = real(RRR_final_weighted) # from TTT_final, which is intended to
        CCC_final_weighted = real(CCC_final_weighted) # be the perfect credibility version
    end

    # Populate TTTs, RRRs, CCCs matrices
    if uncertain_temporary_altpolicy

        # Setup
        ffreg = first(gensys2_regimes) + 1
        altpols = get_setting(m, :alternative_policies)
        weights = Vector{Vector{Float64}}(undef, length(gensys2_regimes) - 1)
        for (i, reg) in enumerate(gensys2_regimes[2]:gensys2_regimes[end])
            weights[i] = get_setting(m, :regime_eqcond_info)[reg].weights
        end
        if length(altpols) == 1
            if altpols[1].solve == solve && haskey(get_settings(m), :uncertain_altpolicy) && get_setting(m, :uncertain_altpolicy)
                revert_unc_altpol = true # Need to make sure uncertain_altpolicy is off if we're using the default solve function
                m <= Setting(:uncertain_altpolicy, false) # since this altpols[1].solve should solve for a perfectly credible policy
            else
                revert_unc_altpol = false
            end
            Talt, _, Calt = altpols[1].solve(m)
            Talt = Talt[1:n_endo,1:n_endo]
            Calt = Calt[1:n_endo]
            if revert_unc_altpol
                m <= Setting(:uncertain_altpolicy, true)
            end
        else
            @assert isa.(altpols, AltPolicy) "All policies in `get_setting(m, :alternative_policies)` should have type AltPolicy."

            Talt = Vector{Matrix{Float64}}(undef, length(altpols)) # can call a faster version
            Calt = Vector{Vector{Float64}}(undef, length(altpols))

            if altpols[1].solve == solve && haskey(get_settings(m), :uncertain_altpolicy) && get_setting(m, :uncertain_altpolicy)
                revert_unc_altpol = true # Need to make sure uncertain_altpolicy is off if we're using the default solve function
                m <= Setting(:uncertain_altpolicy, false) # since this altpols[1].solve should solve for a perfectly credible policy
            else
                revert_unc_altpol = false
            end

            for i in 1:length(altpols)
                Talt[i], _, Calt[i] = altpols[i].solve(m)
                Talt[i] = Talt[i][1:n_endo,1:n_endo]
                Calt[i] = Calt[i][1:n_endo]
            end

            if revert_unc_altpol
                m <= Setting(:uncertain_altpolicy, true)
            end
        end

        # Calculate gensys2 matrices under belief that the desired lift-off policy will occur
        # TODO: generalize to having multiple distinct sets of regimes which are gensys2 regimes
        Tcal, Rcal, Ccal = gensys2(m, Γ0s[gensys2_regimes], Γ1s[gensys2_regimes],
                                   Cs[gensys2_regimes], Ψs[gensys2_regimes], Πs[gensys2_regimes],
                                   TTT_final, RRR_final, CCC_final,
                                   length(gensys2_regimes) - 1)
        Tcal[end] = TTT_final
        Rcal[end] = RRR_final
        Ccal[end] = CCC_final

        # Now calculate transition matrices under an uncertain ZLB
        # Γ0_til, etc., are eqcond matrices implementing ZLB, i.e. zero_rate_rule
        # It is assumed that there is no time variation in the equilibrium conditions
        # for the ZLB, so we can just use ffreg to identify the correct set of
        # equilibrium conditions.
        Γ0_til, Γ1_til, Γ2_til, C_til, Ψ_til =
            gensys_to_predictable_form(Γ0s[ffreg], Γ1s[ffreg], Cs[ffreg], Ψs[ffreg], Πs[ffreg];
                                       use_sparse = (haskey(get_settings(m), :gensys2_sparse_matrices) &&
                                                     get_setting(m, :gensys2_sparse_matrices)))

        ng2  = length(Tcal) - 1 # number of gensys2 regimes
        nzlb = haskey(get_settings(m), :temporary_altpolicy_length) ? get_setting(m, :temporary_altpolicy_length) : ng2

        # Use Tcal, Rcal, & Ccal from 2 as inputs b/c use t + 1 matrix, not t
        # Then, if nzlb = 1, Tcal should have length 2, and you only need the lift-off matrix
        Tcal[1:(1 + nzlb)], Rcal[1:(1 + nzlb)], Ccal[1:(1 + nzlb)] =
            gensys2_uncertain_altpol(weights, Talt, Calt,
                                     Tcal[2:(1 + nzlb)], Rcal[2:(1 + nzlb)], Ccal[2:(1 + nzlb)],
                                     Γ0_til, Γ1_til, Γ2_til, C_til, Ψ_til)

        if uncertain_altpolicy
            Tcal[end] = TTT_final_weighted
            Rcal[end] = RRR_final_weighted
            Ccal[end] = CCC_final_weighted
        else
            Tcal[end] = TTT_final
            Rcal[end] = RRR_final
            Ccal[end] = CCC_final
        end

    else
        Tcal, Rcal, Ccal = gensys2(m, Γ0s[gensys2_regimes], Γ1s[gensys2_regimes],
                                   Cs[gensys2_regimes], Ψs[gensys2_regimes], Πs[gensys2_regimes],
                                   TTT_final, RRR_final, CCC_final,
                                   length(gensys2_regimes) - 1)

        if uncertain_altpolicy
            Tcal[end] = TTT_final_weighted
            Rcal[end] = RRR_final_weighted
            Ccal[end] = CCC_final_weighted
        else
            Tcal[end] = TTT_final
            Rcal[end] = RRR_final
            Ccal[end] = CCC_final
        end
    end

    # only need to populate regimes during which a temporary altpolicy holds
    populate_reg = gensys2_regimes[2:end]
    for (i, reg) in enumerate(populate_reg)
        TTTs[reg], RRRs[reg], CCCs[reg] = augment_states(m, Tcal[i], Rcal[i], Ccal[i], reg = reg)
    end

    return TTTs, RRRs, CCCs
end

"""
```
solve_uncertain_altpolicy(m::AbstractDSGEModel{T},
                          system_perfect_cred_totpolicies::Vector{Union{System, RegimeSwitchingSystem}},
                          is_altpol::Vector{Bool};
                          gensys_regimes::Vector{UnitRange{Int64}} = UnitRange{Int64}[1:1],
                          gensys2_regimes::Vector{UnitRange{Int64}} = Vector{UnitRange{Int}}(undef, 0),
                          regimes::Vector{Int} = Int[1], verbose::Symbol = :high) where {T <: Real}
```

computes the regime-switching state space transition matrices when agents have imperfect awareness
about the policy being implemented and some of these policies may be temporary policies
(and thus would be specified as a `MultiPeriodAltPolicy`).
"""
function solve_uncertain_altpolicy(m::AbstractDSGEModel{T},
                                   system_perfect_cred_totpolicies::Vector{Union{System, RegimeSwitchingSystem}},
                                   is_altpol::Vector{Bool};
                                   gensys_regimes::Vector{UnitRange{Int64}} = UnitRange{Int64}[1:1],
                                   gensys2_regimes::Vector{UnitRange{Int64}} = Vector{UnitRange{Int}}(undef, 0),
                                   regimes::Vector{Int} = Int[1], verbose::Symbol = :high) where {T <: Real}

    Γ0s = Vector{Matrix{Float64}}(undef, length(regimes))
    Γ1s = Vector{Matrix{Float64}}(undef, length(regimes))
    Cs = Vector{Vector{Float64}}(undef, length(regimes))
    Ψs = Vector{Matrix{Float64}}(undef, length(regimes))
    Πs = Vector{Matrix{Float64}}(undef, length(regimes))

    @assert haskey(get_settings(m), :regime_eqcond_info) "The setting :regime_eqcond_info must exist"

    has_eqcond_reg_map = haskey(get_settings(m), :identical_eqcond_regimes)
    for reg in regimes
        if has_eqcond_reg_map && haskey(get_setting(m, :identical_eqcond_regimes), reg)
            reg_to_copy = get_setting(m, :identical_eqcond_regimes)[reg]
            Γ0s[reg] = copy(Γ0s[reg_to_copy])
            Γ1s[reg] = copy(Γ1s[reg_to_copy])
            Cs[reg]  = copy( Cs[reg_to_copy])
            Ψs[reg]  = copy( Ψs[reg_to_copy])
            Πs[reg]  = copy( Πs[reg_to_copy])
        else
            Γ0s[reg], Γ1s[reg], Cs[reg], Ψs[reg], Πs[reg] = haskey(get_setting(m, :regime_eqcond_info), reg) ?
                get_setting(m, :regime_eqcond_info)[reg].alternative_policy.eqcond(m, reg) : eqcond(m, reg)
        end
    end

    TTTs = Vector{Matrix{Float64}}(undef, length(regimes))
    RRRs = Vector{Matrix{Float64}}(undef, length(regimes))
    CCCs = Vector{Vector{Float64}}(undef, length(regimes))

    for reg_range in gensys_regimes
        solve_non_gensys2_regimes!(m, Γ0s, Γ1s, Cs, Ψs, Πs, TTTs, RRRs, CCCs,
                                   system_perfect_cred_totpolicies, is_altpol;
                                   regimes = collect(reg_range),
                                   verbose = verbose)
    end

    for reg_range in gensys2_regimes
        solve_gensys2!(m, Γ0s, Γ1s, Cs, Ψs, Πs,
                       TTTs, RRRs, CCCs, system_perfect_cred_totpolicies, is_altpol;
                       gensys2_regimes = collect(reg_range),
                       verbose = verbose)
    end

    return TTTs, RRRs, CCCs
end

function solve_non_gensys2_regimes!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ1s::Vector{Matrix{S}},
                                    Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
                                    TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}},
                                    system_perfect_cred_totpolicies::Vector{Union{System, RegimeSwitchingSystem}},
                                    is_altpol::Vector{Bool}; regimes::Vector{Int} = Int[1],
                                    verbose::Symbol = :high) where {S <: Real}

    for reg in regimes
        if haskey(get_settings(m), :regime_eqcond_info) && haskey(get_setting(m, :regime_eqcond_info), reg) &&
            !isempty(get_setting(m, :regime_eqcond_info)[reg].weights)

            weights = get_setting(m, :regime_eqcond_info)[reg].weights

            # Time-varying credibility weights for the regime reg
            TTT_gensys, RRR_gensys, CCC_gensys =
                gensys_uncertain_altpol(m, weights, reg, system_perfect_cred_totpolicies, is_altpol)
        else
            TTT_gensys, CCC_gensys, RRR_gensys, eu =
                gensys(Γ0s[reg], Γ1s[reg], Cs[reg], Ψs[reg], Πs[reg],
                       1+1e-6, verbose = verbose)

            # Check for LAPACK exception, existence and uniqueness
            if eu[1] != 1 || eu[2] != 1
                throw(GensysError("Error in Gensys, Regime $reg"))
            end
        end

        TTT_gensys = real(TTT_gensys)
        RRR_gensys = real(RRR_gensys)
        CCC_gensys = real(CCC_gensys)

        # Populate the TTTs, etc., for regime `reg`
        TTTs[reg], RRRs[reg], CCCs[reg] =
            augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys, reg = reg)
    end

    return TTTs, RRRs, CCCs
end

function solve_gensys2!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ1s::Vector{Matrix{S}},
                        Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
                        TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}},
                        system_perfect_cred_totpolicies::Vector{Union{System, RegimeSwitchingSystem}},
                        is_altpol::Vector{Bool};
                        gensys2_regimes::Vector{Int} = Vector{Int}(undef, 0),
                        verbose::Symbol = :high) where {S <: Real}

    # Solve for the final regime of the alternative rule
    TTT_final = system_perfect_cred_totpolicies[1][gensys2_regimes[end], :TTT] # policy 1 is the perfectly credible version of the implemented policy
    RRR_final = system_perfect_cred_totpolicies[1][gensys2_regimes[end], :RRR]
    CCC_final = system_perfect_cred_totpolicies[1][gensys2_regimes[end], :CCC]

    # if we're using an uncertain alternative policy, we have to compute the
    # weighted final transition matrix
    weights = get_setting(m, :regime_eqcond_info)[last(gensys2_regimes)].weights
    TTT_final_weighted, RRR_final_weighted, CCC_final_weighted =
        gensys_uncertain_altpol(m, weights, last(gensys2_regimes), system_perfect_cred_totpolicies, is_altpol)

    TTT_final_weighted = real(TTT_final_weighted) # need to define this as different
    RRR_final_weighted = real(RRR_final_weighted) # from TTT_final, which is intended to
    CCC_final_weighted = real(CCC_final_weighted) # be the perfect credibility version

    # Now calculate transition matrices under an uncertain ZLB
    # Γ0_til, etc., are eqcond matrices implementing ZLB, i.e. zero_rate_rule
    # It is assumed that there is no time variation in the equilibrium conditions
    # for the ZLB, so we can just use ffreg to identify the correct set of
    # equilibrium conditions.
    ffreg = first(gensys2_regimes) + 1
    Γ0_til, Γ1_til, Γ2_til, C_til, Ψ_til =
        gensys_to_predictable_form(Γ0s[ffreg], Γ1s[ffreg], Cs[ffreg], Ψs[ffreg], Πs[ffreg];
                                   use_sparse = (haskey(get_settings(m), :gensys2_sparse_matrices) &&
                                                 get_setting(m, :gensys2_sparse_matrices)))

    # Use Tcal, Rcal, & Ccal from 2 as inputs b/c use t + 1 matrix, not t
    # Then, if nzlb = 1, Tcal should have length 2, and you only need the lift-off matrix
    weights = Vector{Vector{Float64}}(undef, length(gensys2_regimes) - 1) # prep time varying weights
    for (i, reg) in enumerate(gensys2_regimes[2]:gensys2_regimes[end])
        weights[i] = get_setting(m, :regime_eqcond_info)[reg].weights
    end
    Tcal, Rcal, Ccal =
        gensys2_uncertain_altpol(weights, gensys2_regimes, 1:n_states(m), system_perfect_cred_totpolicies, is_altpol,
                                 Γ0_til, Γ1_til, Γ2_til, C_til, Ψ_til)

    ng2  = length(Tcal) - 1 # number of gensys2 regimes
    nzlb = haskey(get_settings(m), :temporary_altpolicy_length) ? get_setting(m, :temporary_altpolicy_length) : ng2

    @assert nzlb == ng2 "The setting :temporary_altpolicy_length does not match the number of gensys2 regimes."

    Tcal[end] = TTT_final_weighted
    Rcal[end] = RRR_final_weighted
    Ccal[end] = CCC_final_weighted

    # only need to populate regimes during which a temporary altpolicy holds
    populate_reg = gensys2_regimes[2:end]
    for (i, reg) in enumerate(populate_reg)
        TTTs[reg], RRRs[reg], CCCs[reg] = augment_states(m, Tcal[i], Rcal[i], Ccal[i], reg = reg)
    end

    return TTTs, RRRs, CCCs
end

function solve_non_gensys2_regimes!(m::AbstractDSGEModel, Γ0s::Vector{Matrix{S}}, Γ1s::Vector{Matrix{S}},
                                    Cs::Vector{Vector{S}}, Ψs::Vector{Matrix{S}}, Πs::Vector{Matrix{S}},
                                    TTTs::Vector{Matrix{S}}, RRRs::Vector{Matrix{S}}, CCCs::Vector{Vector{S}},
                                    system_perfect_cred_totpolicies::Vector{Union{System, RegimeSwitchingSystem}};
                                    regimes::Vector{Int} = Int[1], verbose::Symbol = :high) where {S <: Real}

    for reg in regimes
        if haskey(get_settings(m), :regime_eqcond_info) && haskey(get_setting(m, :regime_eqcond_info), reg) &&
            !isempty(get_setting(m, :regime_eqcond_info)[reg].weights)

            weights = get_setting(m, :regime_eqcond_info)[reg].weights

            # Time-varying credibility weights for the regime reg
            TTT_gensys, RRR_gensys, CCC_gensys =
                gensys_uncertain_altpol(m, weights, reg, system_perfect_cred_totpolicies, trues(length(weights) - 1))
        else
            TTT_gensys, CCC_gensys, RRR_gensys, eu =
                gensys(Γ0s[reg], Γ1s[reg], Cs[reg], Ψs[reg], Πs[reg],
                       1+1e-6, verbose = verbose)

            # Check for LAPACK exception, existence and uniqueness
            if eu[1] != 1 || eu[2] != 1
                throw(GensysError("Error in Gensys, Regime $reg"))
            end
        end

        TTT_gensys = real(TTT_gensys)
        RRR_gensys = real(RRR_gensys)
        CCC_gensys = real(CCC_gensys)

        # Populate the TTTs, etc., for regime `reg`
        TTTs[reg], RRRs[reg], CCCs[reg] =
            augment_states(m, TTT_gensys, RRR_gensys, CCC_gensys, reg = reg)
    end

    return TTTs, RRRs, CCCs
end
