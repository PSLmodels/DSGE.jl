"""
SmetsWouters{T} <: AbstractRepModel{T}

The `SmetsWouters` type defines the structure of the New York Fed DSGE
model.

### Fields

#### Parameters and Steady-States
* `parameters::Vector{AbstractParameter}`: Vector of all time-invariant model
  parameters.

* `steady_state::Vector{AbstractParameter}`: Model steady-state values, computed
  as a function of elements of `parameters`.

* `keys::OrderedDict{Symbol,Int}`: Maps human-readable names for all model
  parameters and steady-states to their indices in `parameters` and
  `steady_state`.

#### Inputs to Measurement and Equilibrium Condition Equations

The following fields are dictionaries that map human-readable names to row and
column indices in the matrix representations of of the measurement equation and
equilibrium conditions.

* `endogenous_states::OrderedDict{Symbol,Int}`: Maps each state to a column in
  the measurement and equilibrium condition matrices.

* `exogenous_shocks::OrderedDict{Symbol,Int}`: Maps each shock to a column in
  the measurement and equilibrium condition matrices.

* `expected_shocks::OrderedDict{Symbol,Int}`: Maps each expected shock to a
  column in the measurement and equilibrium condition matrices.

* `equilibrium_conditions::OrderedDict{Symbol,Int}`: Maps each equlibrium
  condition to a row in the model's equilibrium condition matrices.

* `endogenous_states_augmented::OrderedDict{Symbol,Int}`: Maps lagged states to
  their columns in the measurement and equilibrium condition equations. These
  are added after `gensys` solves the model.

* `observables::OrderedDict{Symbol,Int}`: Maps each observable to a row in the
  model's measurement equation matrices.

* `pseudo_observables::OrderedDict{Symbol,Int}`: Maps each pseudo-observable to
  a row in the model's pseudo-measurement equation matrices.

#### Model Specifications and Settings

* `spec::String`: The model specification identifier, \"smets_wouters\",
cached here for filepath computation.

* `subspec::String`: The model subspecification number,
indicating that some parameters from the original model spec (\"ss0\")
are initialized differently. Cached here for filepath computation.

* `settings::Dict{Symbol,Setting}`: Settings/flags that affect
computation without changing the economic or mathematical setup of
the model.

* `test_settings::Dict{Symbol,Setting}`: Settings/flags for testing mode

#### Other Fields

* `rng::MersenneTwister`: Random number generator. Can be is seeded to ensure
  reproducibility in algorithms that involve randomness (such as
  Metropolis-Hastings).

* `testing::Bool`: Indicates whether the model is in testing mode. If `true`,
  settings from `m.test_settings` are used in place of those in `m.settings`.

* `observable_mappings::OrderedDict{Symbol,Observable}`: A dictionary that
  stores data sources, series mnemonics, and transformations to/from model
  units. DSGE.jl will fetch data from the Federal Reserve Bank of St. Louis's
  FRED database; all other data must be downloaded by the user. See `load_data`
  and `Observable` for further details.

* `pseudo_observable_mappings::OrderedDict{Symbol,PseudoObservable}`: A
  dictionary that stores names and transformations to/from model units. See
  `PseudoObservable` for further details.
"""
mutable struct SmetsWouters{T} <: AbstractRepModel{T}
    parameters::ParameterVector{T}                         # vector of all time-invariant model parameters
    steady_state::ParameterVector{T}                       # model steady-state values
    keys::OrderedDict{Symbol,Int}                          # human-readable names for all the model
                                                           # parameters and steady-states

    endogenous_states::OrderedDict{Symbol,Int}             # these fields used to create matrices in the
    exogenous_shocks::OrderedDict{Symbol,Int}              # measurement and equilibrium condition equations.
    expected_shocks::OrderedDict{Symbol,Int}               #
    equilibrium_conditions::OrderedDict{Symbol,Int}        #
    endogenous_states_augmented::OrderedDict{Symbol,Int}   #
    observables::OrderedDict{Symbol,Int}                   #
    pseudo_observables::OrderedDict{Symbol,Int}            #

    spec::String                                           # Model specification number (eg "m990")
    subspec::String                                        # Model subspecification (eg "ss0")
    settings::Dict{Symbol,Setting}                         # Settings/flags for computation
    test_settings::Dict{Symbol,Setting}                    # Settings/flags for testing mode
    rng::MersenneTwister                                   # Random number generator
    testing::Bool                                          # Whether we are in testing mode or not

    observable_mappings::OrderedDict{Symbol, Observable}
    pseudo_observable_mappings::OrderedDict{Symbol, PseudoObservable}
end

description(m::SmetsWouters) = "Smets-Wouters Model"

"""
`init_model_indices!(m::SmetsWouters)`

Arguments:
`m:: SmetsWouters`: a model object

Description:
Initializes indices for all of `m`'s states, shocks, and equilibrium conditions.
"""
function init_model_indices!(m::SmetsWouters)
    # Endogenous states
    endogenous_states = [[
        :y_t, :c_t, :i_t, :qk_t, :k_t, :kbar_t, :u_t, :rk_t, :mc_t,
        :??_t, :??_??_t, :w_t, :L_t, :R_t, :g_t, :b_t, :??_t, :z_t,
        :??_f_t, :??_f_t1, :??_w_t, :??_w_t1, :rm_t, :Ec_t, :Eqk_t, :Ei_t,
        :E??_t, :EL_t, :Erk_t, :Ew_t, :y_f_t, :c_f_t,
        :i_f_t, :qk_f_t, :k_f_t, :kbar_f_t, :u_f_t, :rk_f_t, :w_f_t,
        :L_f_t, :r_f_t, :Ec_f_t, :Eqk_f_t, :Ei_f_t, :EL_f_t, :Erk_f_t, :ztil_t];
        [Symbol("rm_tl$i") for i = 1:n_anticipated_shocks(m)]]

    # Exogenous shocks
    exogenous_shocks = [[
        :g_sh, :b_sh, :??_sh, :z_sh, :??_f_sh, :??_w_sh, :rm_sh];
        [Symbol("rm_shl$i") for i = 1:n_anticipated_shocks(m)]]

    # Expectations shocks
    expected_shocks = [
        :Ec_sh, :Eqk_sh, :Ei_sh, :E??_sh, :EL_sh, :Erk_sh, :Ew_sh, :Ec_f_sh,
        :Eqk_f_sh, :Ei_f_sh, :EL_f_sh, :Erk_f_sh]

    # Equilibrium conditions
    equilibrium_conditions = [[
        :eq_euler, :eq_inv, :eq_capval, :eq_output, :eq_caputl, :eq_capsrv, :eq_capev,
        :eq_mkupp, :eq_phlps, :eq_caprnt, :eq_msub, :eq_wage, :eq_mp, :eq_res, :eq_g, :eq_b, :eq_??, :eq_z,
        :eq_??_f, :eq_??_w, :eq_rm, :eq_??_f1, :eq_??_w1, :eq_Ec,
        :eq_Eqk, :eq_Ei, :eq_E??, :eq_EL, :eq_Erk, :eq_Ew, :eq_euler_f, :eq_inv_f,
        :eq_capval_f, :eq_output_f, :eq_caputl_f, :eq_capsrv_f, :eq_capev_f, :eq_mkupp_f, :eq_caprnt_f, :eq_msub_f,
        :eq_res_f, :eq_Ec_f, :eq_Eqk_f, :eq_Ei_f, :eq_EL_f, :eq_Erk_f, :eq_ztil];
        [Symbol("eq_rml$i") for i=1:n_anticipated_shocks(m)]]

    # Additional states added after solving model
    # Lagged states and observables measurement error
    endogenous_states_augmented = [
        :y_t1, :c_t1, :i_t1, :w_t1, :??_t1, :L_t1, :Et_??_t]

    # Observables
    observables = keys(m.observable_mappings)

    # Pseudo-observables
    pseudo_observables = keys(m.pseudo_observable_mappings)

    for (i,k) in enumerate(endogenous_states);           m.endogenous_states[k]           = i end
    for (i,k) in enumerate(exogenous_shocks);            m.exogenous_shocks[k]            = i end
    for (i,k) in enumerate(expected_shocks);             m.expected_shocks[k]             = i end
    for (i,k) in enumerate(equilibrium_conditions);      m.equilibrium_conditions[k]      = i end
    for (i,k) in enumerate(endogenous_states);           m.endogenous_states[k]           = i end
    for (i,k) in enumerate(endogenous_states_augmented); m.endogenous_states_augmented[k] = i+length(endogenous_states) end
    for (i,k) in enumerate(observables);                 m.observables[k]                 = i end
    for (i,k) in enumerate(pseudo_observables);          m.pseudo_observables[k]          = i end
end


function SmetsWouters(subspec::String="ss0";
                      custom_settings::Dict{Symbol, Setting} = Dict{Symbol, Setting}(),
                      testing = false)

    # Model-specific specifications
    spec               = split(basename(@__FILE__),'.')[1]
    subspec            = subspec
    settings           = Dict{Symbol,Setting}()
    test_settings      = Dict{Symbol,Setting}()
    rng                = MersenneTwister(0)

    # initialize empty model
    m = SmetsWouters{Float64}(
            # model parameters and steady state values
            Vector{AbstractParameter{Float64}}(), Vector{Float64}(), OrderedDict{Symbol,Int}(),

            # model indices
            OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(), OrderedDict{Symbol,Int}(),

            spec,
            subspec,
            settings,
            test_settings,
            rng,
            testing,
            OrderedDict{Symbol,Observable}(),
            OrderedDict{Symbol,PseudoObservable}())

    # Set settings
    model_settings!(m)
    default_test_settings!(m)
    for custom_setting in values(custom_settings)
        m <= custom_setting
    end

    # Set observable and pseudo-observable transformations
    init_observable_mappings!(m)

    # Initialize parameters
    init_parameters!(m)

    init_model_indices!(m)
    init_subspec!(m)
    steadystate!(m)

    return m
end

"""
```
init_parameters!(m::SmetsWouters)
```

Initializes the model's parameters, as well as empty values for the steady-state
parameters (in preparation for `steadystate!(m)` being called to initialize
those).
"""
function init_parameters!(m::SmetsWouters)
    m <= parameter(:??, 0.24, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Normal(0.30, 0.05), fixed=false,
                   description="??: Capital elasticity in the intermediate goods sector's Cobb-Douglas production function.",
                   tex_label="\\alpha")

    m <= parameter(:??_p, 0.7813, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.1), fixed=false,
                   description="??_p: The Calvo parameter. In every period, intermediate goods producers optimize prices with probability (1-??_p). With probability ??_p, prices are adjusted according to a weighted average of the previous period's inflation (??_t1) and steady-state inflation (??_star).",
                   tex_label="\\zeta_p")

    m <= parameter(:??_p, 0.3291, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="??_p: The weight attributed to last period's inflation in price indexation. (1-??_p) is the weight attributed to steady-state inflation.",
                   tex_label="\\iota_p")

    m <= parameter(:??, 0.025, fixed=true,
                   description="??: The capital depreciation rate.",
                   tex_label="\\delta" )

    m <= parameter(:Upsilon, 1.000, (0., 10.), (1e-5, 0.), ModelConstructors.Exponential(), GammaAlt(1., 0.5), fixed=true,
                   description="??: The trend evolution of the price of investment goods relative to consumption goods. Set equal to 1.",
                   tex_label="\\Upsilon")

    m <= parameter(:??, 1.4672, (1., 10.), (1.00, 10.00), ModelConstructors.Exponential(), Normal(1.25, 0.12), fixed=false,
                   description="??: Fixed costs.",
                   tex_label="\\Phi")

    m <= parameter(:S??????, 6.3325, (-15., 15.), (-15., 15.), ModelConstructors.Untransformed(), Normal(4., 1.5), fixed=false,
                   description="S'': The second derivative of households' cost of adjusting investment.",
                   tex_label="S''")

    m <= parameter(:h, 0.7205, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.7, 0.1), fixed=false,
                   description="h: Consumption habit persistence.",
                   tex_label="h")

    m <= parameter(:ppsi, 0.2648, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="ppsi: Utilization costs.",
                   tex_label="\\psi")

    m <= parameter(:??_l, 2.8401, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(2, 0.75), fixed=false,
                   description="??_l: The coefficient of relative risk aversion on the labor term of households' utility function.", tex_label="\\nu_l")

    m <= parameter(:??_w, 0.7937, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.1), fixed=false,
                   description="??_w: (1-??_w) is the probability with which households can freely choose wages in each period. With probability ??_w, wages increase at a geometrically weighted average of the steady state rate of wage increases and last period's productivity times last period's inflation.",
                   tex_label="\\zeta_w")

    m <= parameter(:??_w, 0.4425, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="??_w: The weight attributed to last period's wage in wage indexation. (1-??_w) is the weight attributed to steady-state wages.",
                   tex_label="\\iota_w")

    m <= parameter(:??_w, 1.5000, fixed=true,
                   description="??_w: The wage markup, which affects the elasticity of substitution between differentiated labor services.",
                   tex_label="\\lambda_w")

    m <= parameter(:??, 0.7420, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.25, 0.1), fixed=false, scaling = x -> 1/(1 + x/100),
                   description="??: Discount rate.",
                   tex_label="\\beta ")

    m <= parameter(:??1, 1.7985, (1e-5, 10.), (1e-5, 10.00), ModelConstructors.Exponential(), Normal(1.5, 0.25), fixed=false,
                   description="?????: Weight on inflation gap in monetary policy rule.",
                   tex_label="\\psi_1")

    m <= parameter(:??2, 0.0893, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.05), fixed=false,
                   description="?????: Weight on output gap in monetary policy rule.",
                   tex_label="\\psi_2")

    m <= parameter(:??3, 0.2239, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.05), fixed=false,
                   description="?????: Weight on rate of change of output gap in the monetary policy rule.",
                   tex_label="\\psi_3")

    m <= parameter(:??_star, 0.7000, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.62, 0.1), fixed=false, scaling = x -> 1 + x/100,
                   description="??_star: The steady-state rate of inflation.",
                   tex_label="\\pi_*")

    m <= parameter(:??_c, 1.2312, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(1.5, 0.37), fixed=false,
                   tex_label="\\sigma_{c}")

    m <= parameter(:??, .8258, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.10), fixed=false,
                   description="??: The degree of inertia in the monetary policy rule.",
                   tex_label="\\rho_R")

    m <= parameter(:??_p, 10.000, fixed=true,
                   description="??_p: Curvature parameter in the Kimball aggregator for prices.",
                   tex_label="\\epsilon_{p}")

    m <= parameter(:??_w, 10.000, fixed=true,
                   description="??_w: Curvature parameter in the Kimball aggregator for wages.",
                   tex_label="\\epsilon_{w}")

    # exogenous processes - level
    m <= parameter(:??, 0.3982, (-5.0, 5.0), (-5., 5.), ModelConstructors.Untransformed(), Normal(0.4, 0.1), fixed=false, scaling = x -> x/100,
                   description="??: The log of the steady-state growth rate of technology.",
                   tex_label="\\gamma")

    m <= parameter(:Lmean, -45., (-1000., 1000.), (-1e3, 1e3), ModelConstructors.Untransformed(), Normal(-45, 5), fixed=false,
                   description="Lmean: Mean level of hours.",
                   tex_label="\\bar{L}")

    m <= parameter(:g_star, 0.1800, fixed=true,
                   description="g_star: 1 - (c_star + i_star)/y_star.",
                   tex_label="g_*")

    # exogenous processes - autocorrelation
    m <= parameter(:??_g, 0.9930, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_g: AR(1) coefficient in the government spending process.",
                   tex_label="\\rho_g")

    m <= parameter(:??_b, 0.2703, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_b: AR(1) coefficient in the intertemporal preference shifter process.",
                   tex_label="\\rho_b")

    m <= parameter(:??_??, 0.5724, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??: AR(1) coefficient in capital adjustment cost process.",
                   tex_label="\\rho_{\\mu}")

    m <= parameter(:??_z, 0.9676, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_z: AR(1) coefficient in the technology process.",
                   tex_label="\\rho_z")

    m <= parameter(:??_??_f, 0.8692, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??_f: AR(1) coefficient in the price mark-up shock process.",
                   tex_label="\\rho_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.9546, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??_w: AR(1) coefficient in the wage mark-up shock process.", # CHECK THIS
                   tex_label="\\rho_{\\lambda_w}")

    # monetary policy shock - see eqcond
    m <= parameter(:??_rm, 0.3000, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_rm: AR(1) coefficient in the monetary policy shock process.", # CHECK THIS
                   tex_label="\\rho_{r^m}")

    # exogenous processes - standard deviation
    m <= parameter(:??_g, 0.6090, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b, 0.1818, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_b: The standard deviation of the intertemporal preference shifter process.",
                   tex_label="\\sigma_{b}")

    m <= parameter(:??_??, 0.4601, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_z, 0.4618, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_z: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{z}")

    m <= parameter(:??_??_f, 0.1455, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_??_f: The mean of the process that generates the price elasticity of the composite good. Specifically, the elasticity is (1+??_{f,t})/(??_{f_t}).",
                   tex_label="\\sigma_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.2089, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   tex_label="\\sigma_{\\lambda_w}")

    m <= parameter(:??_rm, 0.2397, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2., 0.10), fixed=false,
                   description="??_r_m: The standard deviation of the monetary policy shock.",
                   tex_label="\\sigma_{r^m}")


    m <= parameter(:??_gz, 0.0500, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_gz: Correlate g and z shocks.",
                   tex_label="\\eta_{gz}")

    m <= parameter(:??_??_f, 0.7652, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_f: Moving average component in the price markup shock.",
                   tex_label="\\eta_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.8936, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_w: Moving average component in the wage markup shock.",
                   tex_label="\\eta_{\\lambda_w}")

    m <= parameter(:e_y, 0.0, fixed = true, description = "e_y: Measurement error on GDP", tex_label = "e_y")
    m <= parameter(:e_L, 0.0, fixed = true, description = "e_L: Measurement error on hours worked", tex_label = "e_L")
    m <= parameter(:e_w, 0.0, fixed = true, description = "e_w: Measurement error on wages", tex_label = "e_w")
    m <= parameter(:e_??, 0.0, fixed = true, description = "e_??: Measurement error on GDP deflator", tex_label = "e_??")
    m <= parameter(:e_R, 0.0, fixed = true, description = "e_R: Measurement error on nominal rate of interest", tex_label = "e_R")
    m <= parameter(:e_c, 0.0, fixed = true, description = "e_c: Measurement error on consumption", tex_label = "e_c")
    m <= parameter(:e_i, 0.0, fixed = true, description = "e_i: Measurement error on investment", tex_label = "e_i")


    # steady states
    m <= SteadyStateParameter(:zstar, NaN, description="Steady-state growth rate of productivity", tex_label="\\z_*")
    m <= SteadyStateParameter(:rstar, NaN, tex_label="\\r_*")
    m <= SteadyStateParameter(:Rstarn, NaN, tex_label="\\R_*_n")
    m <= SteadyStateParameter(:rkstar, NaN, tex_label="\\r^k_")
    m <= SteadyStateParameter(:wstar, NaN, tex_label="\\w_*")
    m <= SteadyStateParameter(:Lstar, NaN, tex_label="\\L_*")
    m <= SteadyStateParameter(:kstar, NaN, description="Effective capital that households rent to firms in the steady state.", tex_label="\\k_*")
    m <= SteadyStateParameter(:kbarstar, NaN, description="Total capital owned by households in the steady state.", tex_label="\\bar{k}_*")
    m <= SteadyStateParameter(:istar, NaN, description="Detrended steady-state investment", tex_label="\\i_*")
    m <= SteadyStateParameter(:ystar, NaN, tex_label="\\y_*")
    m <= SteadyStateParameter(:cstar, NaN, tex_label="\\c_*")
    m <= SteadyStateParameter(:wl_c, NaN, tex_label="\\wl_c")
end

"""
```
steadystate!(m::SmetsWouters)
```

Calculates the model's steady-state values. `steadystate!(m)` must be called whenever the parameters of `m` are updated.
"""
function steadystate!(m::SmetsWouters)
    m[:zstar]    = log(1+m[:??]) + m[:??]/(1-m[:??])*log(m[:Upsilon])
    m[:rstar]    = exp(m[:??_c]*m[:zstar]) / m[:??]
    m[:Rstarn]   = 100*(m[:rstar]*m[:??_star] - 1)
    m[:rkstar]   = m[:rstar]*m[:Upsilon] - (1-m[:??])
    m[:wstar]    = (m[:??]^m[:??] * (1-m[:??])^(1-m[:??]) * m[:rkstar]^(-m[:??]) / m[:??])^(1/(1-m[:??]))
    m[:Lstar]    = 1.
    m[:kstar]    = (m[:??]/(1-m[:??])) * m[:wstar] * m[:Lstar] / m[:rkstar]
    m[:kbarstar] = m[:kstar] * (1+m[:??]) * m[:Upsilon]^(1 / (1-m[:??]))
    m[:istar]    = m[:kbarstar] * (1-((1-m[:??])/((1+m[:??]) * m[:Upsilon]^(1/(1-m[:??])))))
    m[:ystar]    = (m[:kstar]^m[:??]) * (m[:Lstar]^(1-m[:??])) / m[:??]
    m[:cstar]    = (1-m[:g_star])*m[:ystar] - m[:istar]
    m[:wl_c]     = (m[:wstar]*m[:Lstar])/(m[:cstar]*m[:??_w])

    return m
end

function model_settings!(m::SmetsWouters)

    default_settings!(m)

    # Anticipated shocks
    m <= Setting(:n_mon_anticipated_shocks, 0)
    m <= Setting(:n_mon_anticipated_shocks_padding, 20)

    # Estimation
    m <= Setting(:reoptimize, true)
    m <= Setting(:recalculate_hessian, true)

    # Data
    m <= Setting(:data_vintage, "150827")
    m <= Setting(:data_id, 1, "Dataset identifier")
    m <= Setting(:cond_full_names, [:obs_gdp, :obs_nominalrate])
    m <= Setting(:cond_semi_names, [:obs_nominalrate])
end

"""
```
parameter_groupings(m::SmetsWouters)
```

Returns an `OrderedDict{String, Vector{Parameter}}` mapping descriptions of
parameter groupings (e.g. \"Policy Parameters\") to vectors of
`Parameter`s. This dictionary is passed in as a keyword argument to
`prior_table`.
"""
function parameter_groupings(m::SmetsWouters)
    policy     = [:??1, :??2, :??3, :??, :??_rm, :??_rm]
    sticky     = [:??_p, :??_p, :??_p, :??_w, :??_w, :??_w]
    other_endo = [:??, :??, :??, :??_c, :h, :??_l, :??, :??, :S??????, :ppsi,
                  :Lmean, :??_w, :??_star, :g_star]
    processes  = [:??_g, :??_b, :??_??, :??_z, :??_??_f, :??_??_w, :??_??_f, :??_??_w,
                  :??_g, :??_b, :??_??, :??_z, :??_??_f, :??_??_w, :??_gz]

    all_keys     = Vector[policy, sticky, other_endo, processes]
    all_params   = map(keys -> [m[??]::Parameter for ?? in keys], all_keys)
    descriptions = ["Policy", "Nominal Rigidities",
                    "Other Endogenous Propagation and Steady State",
                    "Exogenous Process"]

    groupings = OrderedDict{String, Vector{Parameter}}(zip(descriptions, all_params))

    # Ensure no parameters missing
    incl_params = vcat(collect(values(groupings))...)
    excl_params = [m[??] for ?? in [:Upsilon, :e_y, :e_L, :e_w, :e_??, :e_R, :e_c, :e_i]]
    @assert isempty(setdiff(m.parameters, vcat(incl_params, excl_params)))
    @assert isempty(setdiff(vcat(incl_params, excl_params), m.parameters))

    return groupings
end

"""
```
shock_groupings(m::SmetsWouters)
```

Returns a `Vector{ShockGroup}`, which must be passed in to
`plot_shock_decomposition`. See `?ShockGroup` for details.
"""
function shock_groupings(m::SmetsWouters)
    gov = ShockGroup("g", [:g_sh], RGB(0.70, 0.13, 0.13)) # firebrick
    bet = ShockGroup("b", [:b_sh], RGB(0.3, 0.3, 1.0))
    tfp = ShockGroup("z", [:z_sh], RGB(1.0, 0.55, 0.0)) # darkorange
    pmu = ShockGroup("p-mkp", [:??_f_sh], RGB(0.60, 0.80, 0.20)) # yellowgreen
    wmu = ShockGroup("w-mkp", [:??_w_sh], RGB(0.0, 0.5, 0.5)) # teal
    pol = ShockGroup("pol", vcat([:rm_sh], [Symbol("rm_shl$i") for i = 1:n_anticipated_shocks(m)]),
                     RGB(1.0, 0.84, 0.0)) # gold
    mei = ShockGroup("mu", [:??_sh], :cyan)
    det = ShockGroup("dt", [:dettrend], :gray40)

    return [gov, bet, tfp, pmu, wmu, pol, mei, det]
end
