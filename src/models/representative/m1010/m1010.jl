"""
```
Model1010{T} <: AbstractRepModel{T}
```

The `Model1010` type defines the structure of Model1010.

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

* `spec::String`: The model specification identifier, \"m1010\", cached here for
  filepath computation.

* `subspec::String`: The model subspecification number, indicating that
  some parameters from the original model spec (\"ss18\") are initialized
  differently. Cached here for filepath computation.

* `settings::Dict{Symbol,Setting}`: Settings/flags that affect computation without changing
  the economic or mathematical setup of the model.

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
mutable struct Model1010{T} <: AbstractRepModel{T}
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

description(m::Model1010) = "New York Fed DSGE Model m1010, $(m.subspec). Model1009, with trend and stationary components in the safety and liquidity premia processes."

"""
`init_model_indices!(m::Model1010)`

Arguments:
`m:: Model1010`: a model object

Description:
Initializes indices for all of `m`'s states, shocks, and equilibrium conditions.
"""
function init_model_indices!(m::Model1010)
    # Endogenous states
    endogenous_states = [[
        :y_t, :c_t, :i_t, :qk_t, :k_t, :kbar_t, :u_t, :rk_t, :Rktil_t, :n_t,
        :mc_t, :??_t, :??_??_t, :w_t, :L_t, :R_t, :g_t, :b_liq_t, :b_safe_t, :??_t,
        :z_t, :??_f_t, :??_f_t1, :??_w_t, :??_w_t1, :rm_t, :??_??_t, :??_e_t, :??_t,
        :??_star_t, :Ec_t, :Eqk_t, :Ei_t, :E??_t, :EL_t, :Erk_t, :Ew_t,
        :ERtil_k_t, :ERktil_f_t, :y_f_t, :c_f_t, :i_f_t, :qk_f_t, :k_f_t,
        :kbar_f_t, :u_f_t, :rk_f_t, :w_f_t, :L_f_t, :r_f_t, :Ec_f_t, :Eqk_f_t,
        :Ei_f_t, :EL_f_t, :ztil_t, :??_t1, :??_t2, :??_a_t, :R_t1, :zp_t, :Ez_t,
        :rktil_f_t, :n_f_t, :b_liqtil_t, :b_liqp_t, :b_safetil_t, :b_safep_t];
        [Symbol("rm_tl$i") for i = 1:n_anticipated_shocks(m)]]

    # Exogenous shocks
    exogenous_shocks = [[
        :g_sh, :b_liqtil_sh, :b_liqp_sh, :b_safetil_sh, :b_safep_sh, :??_sh,
        :z_sh, :??_f_sh, :??_w_sh, :rm_sh, :??_??_sh, :??_e_sh, :??_sh, :??_star_sh,
        :lr_sh, :zp_sh, :tfp_sh, :gdpdef_sh, :corepce_sh, :gdp_sh, :gdi_sh,
        :BBB_sh, :AAA_sh];
        [Symbol("rm_shl$i") for i = 1:n_anticipated_shocks(m)]]

    # Expectations shocks
    expected_shocks = [
        :Ec_sh, :Eqk_sh, :Ei_sh, :E??_sh, :EL_sh, :Erk_sh, :Ew_sh, :ERktil_sh,
        :Ec_f_sh, :Eqk_f_sh, :Ei_f_sh, :EL_f_sh, :Erktil_f_sh]

    # Equilibrium conditions
    equilibrium_conditions = [[
        :eq_euler, :eq_inv, :eq_capval, :eq_spread, :eq_nevol, :eq_output,
        :eq_caputl, :eq_capsrv, :eq_capev, :eq_mkupp, :eq_phlps, :eq_caprnt,
        :eq_msub, :eq_wage, :eq_mp, :eq_res, :eq_g, :eq_b_liq, :eq_b_safe,
        :eq_??, :eq_z, :eq_??_f, :eq_??_w, :eq_rm, :eq_??_??, :eq_??_e, :eq_??,
        :eq_??_f1, :eq_??_w1, :eq_Ec, :eq_Eqk, :eq_Ei, :eq_E??, :eq_EL, :eq_Erk,
        :eq_Ew, :eq_ERktil, :eq_euler_f, :eq_inv_f, :eq_capval_f, :eq_output_f,
        :eq_caputl_f, :eq_capsrv_f, :eq_capev_f, :eq_mkupp_f, :eq_caprnt_f,
        :eq_msub_f, :eq_res_f, :eq_Ec_f, :eq_Eqk_f, :eq_Ei_f, :eq_EL_f,
        :eq_ztil, :eq_??_star, :eq_??1, :eq_??2, :eq_??_a, :eq_Rt1, :eq_zp, :eq_Ez,
        :eq_spread_f,:eq_nevol_f, :eq_Erktil_f, :eq_b_liqtil, :eq_b_liqp,
        :eq_b_safetil, :eq_b_safep];
        [Symbol("eq_rml$i") for i=1:n_anticipated_shocks(m)]]

    # Additional states added after solving model
    # Lagged states and observables measurement error
    endogenous_states_augmented = [
        :y_t1, :c_t1, :i_t1, :w_t1, :??_t1_dup, :L_t1, :u_t1, :Et_??_t, :lr_t, :tfp_t, :e_gdpdef_t,
        :e_corepce_t, :e_gdp_t, :e_gdi_t, :e_gdp_t1, :e_gdi_t1, :e_BBB_t, :e_AAA_t]

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

function Model1010(subspec::String="ss20";
                   custom_settings::Dict{Symbol, Setting} = Dict{Symbol, Setting}(),
                   testing = false)

    # Model-specific specifications
    spec               = split(basename(@__FILE__),'.')[1]
    subspec            = subspec
    settings           = Dict{Symbol,Setting}()
    test_settings      = Dict{Symbol,Setting}()
    rng                = MersenneTwister(0)

    # Initialize empty model
    m = Model1010{Float64}(
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
    init_pseudo_observable_mappings!(m)

    # Initialize parameters
    init_parameters!(m)

    init_model_indices!(m)
    init_subspec!(m)
    steadystate!(m)

    return m
end

"""
```
init_parameters!(m::Model1010)
```

Initializes the model's parameters, as well as empty values for the steady-state
parameters (in preparation for `steadystate!(m)` being called to initialize
those).
"""
function init_parameters!(m::Model1010)
    m <= parameter(:??, 0.1596, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Normal(0.30, 0.05), fixed=false,
                   description="??: Capital elasticity in the intermediate goods sector's production function (also known as the capital share).",
                   tex_label="\\alpha")

    m <= parameter(:??_p, 0.8940, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.1), fixed=false,
                   description="??_p: The Calvo parameter. In every period, intermediate goods producers optimize prices with probability (1-??_p). With probability ??_p, prices are adjusted according to a weighted average of the previous period's inflation (??_t1) and steady-state inflation (??_star).",
                   tex_label="\\zeta_p")

    m <= parameter(:??_p, 0.1865, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="??_p: The weight attributed to last period's inflation in price indexation. (1-??_p) is the weight attributed to steady-state inflation.",
                   tex_label="\\iota_p")

    m <= parameter(:??, 0.025, fixed=true,
                   description="??: The capital depreciation rate.",
                   tex_label="\\delta" )

    m <= parameter(:Upsilon, 1.000, (0., 10.), (1e-5, 0.), ModelConstructors.Exponential(), GammaAlt(1., 0.5), fixed=true,
                   description="??: The trend evolution of the price of investment goods relative to consumption goods. Set equal to 1.",
                   tex_label="\\Upsilon")

    m <= parameter(:??, 1.000071, (1., 10.), (1.00, 10.00), ModelConstructors.Exponential(), Normal(1.25, 0.12), fixed=true,
                   description="??: Fixed costs.",
                   tex_label="\\Phi_p")

    m <= parameter(:S??????, 2.7314, (-15., 15.), (-15., 15.), ModelConstructors.Untransformed(), Normal(4., 1.5), fixed=false,
                   description="S'': The second derivative of households' cost of adjusting investment.",
                   tex_label="S''")

    m <= parameter(:h, 0.5347, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.7, 0.1), fixed=false,
                   description="h: Consumption habit persistence.",
                   tex_label="h")

    m <= parameter(:ppsi, 0.6862, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="ppsi: Utilization costs.",
                   tex_label="\\psi")

    m <= parameter(:??_l, 2.5975, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(2, 0.75), fixed=false,
                   description="??_l: The coefficient of relative risk aversion on the labor term of households' utility function.",
                   tex_label="\\nu_l")

    m <= parameter(:??_w, 0.9291, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.1), fixed=false,
                   description="??_w: (1-??_w) is the probability with which households can freely choose wages in each period. With probability ??_w, wages increase at a geometrically weighted average of the steady state rate of wage increases and last period's productivity times last period's inflation.",
                   tex_label="\\zeta_w")

    m <= parameter(:??_w, 0.2992, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.15), fixed=false,
                   description="??_w: The weight attributed to last period's wage in wage indexation. (1-??_w) is the weight attributed to steady-state wages.",
                   tex_label="\\iota_w")

    m <= parameter(:??_w, 1.5000, fixed=true,
                   description="??_w: The wage markup, which affects the elasticity of substitution between differentiated labor services.",
                   tex_label="\\lambda_w")

    m <= parameter(:??, 0.1402, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.25, 0.1), fixed=false, scaling = x -> 1/(1 + x/100),
                   description="??: Discount rate in quarterly terms.",
                   tex_label="100(\\beta^{-1} - 1)")

    m <= parameter(:??1, 1.3679, (1e-5, 10.), (1e-5, 10.00), ModelConstructors.Exponential(), Normal(1.5, 0.25), fixed=false,
                   description="?????: Weight on inflation gap in monetary policy rule.",
                   tex_label="\\psi_1")

    m <= parameter(:??2, 0.0388, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.05), fixed=false,
                   description="?????: Weight on output gap in monetary policy rule.",
                   tex_label="\\psi_2")

    m <= parameter(:??3, 0.2464, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.05), fixed=false,
                   description="?????: Weight on rate of change of output gap in the monetary policy rule.",
                   tex_label="\\psi_3")

    m <= parameter(:??_star, 0.5000, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.75, 0.4), fixed=true, scaling = x -> 1 + x/100,
                   description="??_star: The steady-state rate of inflation.",
                   tex_label="\\pi_*")

    m <= parameter(:??_c, 0.8719, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(1.5, 0.37), fixed=false,
                   description="??_c: Coefficient of relative risk aversion.",
                   tex_label="\\sigma_{c}")

    m <= parameter(:??, 0.7126, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.10), fixed=false,
                   description="??: The degree of inertia in the monetary policy rule.",
                   tex_label="\\rho_R")

    m <= parameter(:??_p, 10.000, fixed=true,
                   description="??_p: Curvature parameter in the Kimball aggregator for prices.",
                   tex_label="\\epsilon_{p}")

    m <= parameter(:??_w, 10.000, fixed=true,
                   description="??_w: Curvature parameter in the Kimball aggregator for wages.",
                   tex_label="\\epsilon_{w}")


    # financial frictions parameters
    m <= parameter(:F??, 0.0300, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.03, 0.01), fixed=true, scaling = x -> 1 - (1-x)^0.25,
                   description="F(??): The cumulative distribution function of ?? (idiosyncratic iid shock that increases or decreases entrepreneurs' capital).",
                   tex_label="F(\\bar{\\omega})")

    m <= parameter(:spr, 1.0, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), GammaAlt(1., 0.1), fixed=false,
                   scaling = x -> (1 + x/100)^0.25,
                   description="spr_*: Steady-state level of spread.",
                   tex_label="SP_*")

    m <= parameter(:lnb_liq, 0.47/4, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.47/4, 0.05), fixed=true, scaling = x -> (1 + x/100),
                   description="ln(b_liq): Liquidity premium.",
                   tex_label="ln(b_{liq})")

    m <= parameter(:lnb_safe, 0.26/4, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.26/4, 0.05), fixed=true, scaling = x -> (1 + x/100),
                   description="ln(b_safe_*): Safety premium.",
                   tex_label="ln(b_{safe})")

    m <= parameter(:??_AAA, 0.0, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5,0.2), fixed=true,
                   tex_label="\\lambda_{AAA}")

    m <= parameter(:??_spb, 0.0559, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.05, 0.005), fixed=false,
                   description="??_spb: The elasticity of the expected exess return on capital (or 'spread') with respect to leverage.",
                   tex_label="\\zeta_{sp,b}")

    m <= parameter(:??_star, 0.9900, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.99, 0.002), fixed=true,
                   description="??_star: Fraction of entrepreneurs who survive and continue operating for another period.",
                   tex_label="\\gamma_*")

    # exogenous processes - level
    m <= parameter(:??, 0.3673, (-5.0, 5.0), (-5., 5.), ModelConstructors.Untransformed(), Normal(0.4, 0.1), fixed=false, scaling = x -> x/100,
                   description="??: The log of the steady-state growth rate of technology.",
                   tex_label="100\\gamma")

    m <= parameter(:Lmean, -45.9364, (-1000., 1000.), (-1e3, 1e3), ModelConstructors.Untransformed(), Normal(-45., 5.), fixed=false,
                   description="Lmean: Mean level of hours.",
                   tex_label="\\bar{L}")

    m <= parameter(:g_star, 0.1800, fixed=true,
                   description="g_star: 1 - (c_star + i_star)/y_star.",
                   tex_label="g_*")

    # exogenous processes - autocorrelation
    m <= parameter(:??_g, 0.9863, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_g: AR(1) coefficient in the government spending process.",
                   tex_label="\\rho_g")

    m <= parameter(:??_b_liqtil, 0.9410, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_b_liqtil: AR(1) coefficient in the non-permanent component of the intertemporal preference shifter process for liquid assets.",
                   tex_label="\\rho_{\\tilde{b},liq}")

    m <= parameter(:??_b_liqp, 0.99, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=true,
                   description="??_b_liqp: AR(1) coefficient in the permanent component of the intertemporal preference shifter process for liquid assets.",
                   tex_label="\\rho_{b^p,liq}")

    m <= parameter(:??_b_safetil, 0.9410, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_b_safetil: AR(1) coefficient in the non-permanent component of the intertemporal preference shifter process for safe assets.",
                   tex_label="\\rho_{\\tilde{b},safe}")

    m <= parameter(:??_b_safep, 0.99, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=true,
                   description="??_b_safep: AR(1) coefficient in the permanent component of the intertemporal preference shifter process for safe assets.",
                   tex_label="\\rho_{b^p,safe}")

    m <= parameter(:??_??, 0.8735, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??: AR(1) coefficient in capital adjustment cost process.",
                   tex_label="\\rho_{\\mu}")

    m <= parameter(:??_z, 0.9446, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_z: AR(1) coefficient in the technology process.",
                   tex_label="\\rho_z")

    m <= parameter(:??_??_f, 0.8827, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??_f: AR(1) coefficient in the price mark-up shock process.",
                   tex_label="\\rho_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3884, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_??_w: AR(1) coefficient in the wage mark-up shock process.",
                   tex_label="\\rho_{\\lambda_w}")

    # monetary policy shock - see eqcond
    m <= parameter(:??_rm, 0.2135, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_rm: AR(1) coefficient in the monetary policy shock process.",
                   tex_label="\\rho_{r^m}")

    m <= parameter(:??_??_w, 0.9898, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.15), fixed=false,
                   description="??_??_w: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with mean ??_??_w. Innovations to the process are called _spread shocks_.",
                   tex_label="\\rho_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.7500, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.15), fixed=true,
                   description="??_??_e: AR(1) coefficient in the exogenous bankruptcy cost process.",
                   tex_label="\\rho_{\\mu_e}")

    m <= parameter(:??_??, 0.7500, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.15), fixed=true,
                   description="??_??: AR(1) coefficient in the process describing the fraction of entrepreneurs surviving period t.",
                   tex_label="\\rho_{\\gamma}")

    m <= parameter(:??_??_star, 0.9900, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=true,
                   description="??_??_star: AR(1) coefficient in the time-varying inflation target process.",
                   tex_label="\\rho_{\\pi_*}")

    m <= parameter(:??_lr, 0.6936, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   tex_label="\\rho_{10y}")

    m <= parameter(:??_z_p, 0.8910, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   description="??_z_p: AR(1) coefficient in the process describing the permanent component of productivity.",
                   tex_label="\\rho_{z^p}")

    m <= parameter(:??_tfp, 0.1953, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   tex_label="\\rho_{tfp}")

    m <= parameter(:??_gdpdef, 0.5379, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   tex_label="\\rho_{gdpdef}")

    m <= parameter(:??_corepce, 0.2320, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.2), fixed=false,
                   tex_label="\\rho_{pce}")

    m <= parameter(:??_gdp, 0., (-1.0, 1.0), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.2), fixed=false,
                   tex_label="\\rho_{gdp}")

    m <= parameter(:??_gdi, 0., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.2), fixed=false,
                   tex_label="\\rho_{gdi}")

    m <= parameter(:??_gdpvar, 0., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.4), fixed=false,
                   tex_label="\\varrho_{gdp}")

    m <= parameter(:??_BBB, 0., fixed=true,
                   description="??_BBB: AR(1) coefficient in the BBB spread process.",
                   tex_label="\\rho_{BBB}")

    m <= parameter(:??_AAA, 0., fixed=true,
                   description="??_AAA: AR(1) coefficient in the AAA spread process.",
                   tex_label="\\rho_{AAA}")

    m <= parameter(:me_level, 1., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.Untransformed(), Normal(0.0, 0.4), fixed=true,
                   description="me_level: Indicator of cointegration of GDP and GDI.",
                   tex_label="\\mathcal{C}_{me}")

    # exogenous processes - standard deviation
    m <= parameter(:??_g, 2.5230, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b_liqtil, 0.0292, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b_liqtil: Standard deviation of non-stationary component of liquid asset preference shifter process.",
                   tex_label="\\sigma_{\\tilde{b}, liq}")

    m <= parameter(:??_b_liqp, 0.0269, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_b_liqp: Standard deviation of stationary component of liquid asset preference shifter process.",
                   tex_label="\\sigma_{b^p, liq}")

    m <= parameter(:??_b_safetil, 0.0292, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b_safetil: Standard deviation of non-stationary component of safe asset preference shifter process.",
                   tex_label="\\sigma_{\\tilde{b}, safe}")

    m <= parameter(:??_b_safep, 0.0269, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_b_safep: Standard deviation of stationary component of safe asset preference shifter process.",
                   tex_label="\\sigma_{b^p, safe}")

    m <= parameter(:??_??, 0.4559, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_z, 0.6742, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{z}")

    m <= parameter(:??_??_f, 0.1314, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??_f: The mean of the process that generates the price elasticity of the composite good. Specifically, the elasticity is (1+??_{f,t})/(??_{f_t}).",
                   tex_label="\\sigma_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3864, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{\\lambda_w}")

    m <= parameter(:??_r_m, 0.2380, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_r_m: The standard deviation of the monetary policy shock.",
                   tex_label="\\sigma_{r^m}")

    m <= parameter(:??_??_??, 0.0428, (1e-7,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_??: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with standard deviation ??_??_??.",
                   tex_label="\\sigma_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.0000, (1e-7,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=true,
                   description="??_??_e: Exogenous bankrupcy costs follow an exogenous process with standard deviation ??_??_e.",
                   tex_label="\\sigma_{\\mu_e}")

    m <= parameter(:??_??, 0.0000, (1e-7,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.01), fixed=true,
                   description="??_??: The fraction of entrepreneurs surviving period t follows an exogenous process with standard deviation ??_??.",
                   tex_label="\\sigma_{\\gamma}")

    m <= parameter(:??_??_star, 0.0269, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_??_star: The standard deviation of the inflation target.",
                   tex_label="\\sigma_{\\pi_*}")

    m <= parameter(:??_lr, 0.1766, (1e-8,10.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.75), fixed=false,
                   tex_label="\\sigma_{10y}")

    m <= parameter(:??_z_p, 0.1662, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    m <= parameter(:??_tfp, 0.9391, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{tfp}")

    m <= parameter(:??_gdpdef, 0.1575, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdpdef}")

    m <= parameter(:??_corepce, 0.0999, (1e-8, 5.),(1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{pce}")

    m <= parameter(:??_gdp, 0.1, (1e-8, 5.),(1e-8, 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdp}")

    m <= parameter(:??_gdi, 0.1, (1e-8, 5.),(1e-8, 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdi}")

    m <= parameter(:??_BBB, 0.0, (1e-8, 5.),(1e-8, 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=true,
                   description="??_BBB: Standard deviation on the AR(1) process for measurement error on the BBB spread.",
                   tex_label="\\sigma_{BBB}")

    m <= parameter(:??_AAA, 0.1, (1e-8, 5.),(1e-8, 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   description="??_AAA: Standard deviation on the AR(1) process for measurement error on the AAA spread.",
                   tex_label="\\sigma_{AAA}")

    # standard deviations of the anticipated policy shocks
    for i = 1:n_anticipated_shocks_padding(m)
        if i < 13
            m <= parameter(Symbol("??_r_m$i"), .2, (1e-7, 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, .2), fixed=false,
                           description="??_r_m$i: Standard deviation of the $i-period-ahead anticipated policy shock.",
                           tex_label=@sprintf("\\sigma_{%d,r}",i))
        else
            m <= parameter(Symbol("??_r_m$i"), .0, (1e-7, 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, .2), fixed=true,
                           description="??_r_m$i: Standard deviation of the $i-period-ahead anticipated policy shock.",
                           tex_label=@sprintf("\\sigma_{%d,r}",i))
        end
    end

    m <= parameter(:??_gz, 0.8400, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_gz: Correlate g and z shocks.",
                   tex_label="\\eta_{gz}")

    m <= parameter(:??_??_f, 0.7892, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_f: Moving average component in the price markup shock.",
                   tex_label="\\eta_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.4226, (0.0, 1.0), (0.0, 1.0), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_w: Moving average component in the wage markup shock.",
                   tex_label="\\eta_{\\lambda_w}")

    m <= parameter(:Iendo??, 0.0000, (0.000, 1.000), (0., 0.), ModelConstructors.Untransformed(), BetaAlt(0.50, 0.20), fixed=true,
                   description="Iendo??: Indicates whether to use the model's endogenous ?? in the capacity utilization adjustment of total factor productivity.",
                   tex_label="I\\{\\alpha^{model}\\}")

    m <= parameter(:??_gdpdef, 1.0354, (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(1.00, 2.), fixed=false,
                   tex_label="\\gamma_{gdpdef}")

    m <= parameter(:??_gdpdef, 0.0181, (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(0.00, 2.), fixed=false,
                   tex_label="\\delta_{gdpdef}")

    m <= parameter(:??_gdi, 1., (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(1., 2.), fixed=true,
                   tex_label="\\gamma_{gdi}")

    m <= parameter(:??_gdi, 0., (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(0.00, 2.), fixed=true,
                   tex_label="\\delta_{gdi}")

    # steady states
    m <= SteadyStateParameter(:z_star, NaN, tex_label="\\z_*")
    m <= SteadyStateParameter(:rstar, NaN, tex_label="\\r_*")
    m <= SteadyStateParameter(:Rstarn, NaN, tex_label="\\R_*_n")
    m <= SteadyStateParameter(:r_k_star, NaN, description="Steady-state short-term rate of return on capital.", tex_label="\\r^k_*")
    m <= SteadyStateParameter(:wstar, NaN, tex_label="\\w_*")
    m <= SteadyStateParameter(:Lstar, NaN, tex_label="\\L_*")
    m <= SteadyStateParameter(:kstar, NaN, description="Effective capital that households rent to firms in the steady state.", tex_label="\\k_*")
    m <= SteadyStateParameter(:kbarstar, NaN, description="Total capital owned by households in the steady state.", tex_label="\\bar{k}_*")
    m <= SteadyStateParameter(:istar, NaN, description="Detrended steady-state investment", tex_label="\\i_*")
    m <= SteadyStateParameter(:ystar, NaN, tex_label="\\y_*")
    m <= SteadyStateParameter(:cstar, NaN, tex_label="\\c_*")
    m <= SteadyStateParameter(:wl_c, NaN, tex_label="\\wl_c")
    m <= SteadyStateParameter(:nstar, NaN, tex_label="\\n_*")
    m <= SteadyStateParameter(:vstar, NaN, tex_label="\\v_*")
    m <= SteadyStateParameter(:??_sp??_??, NaN, tex_label="\\zeta_{sp_{\\sigma_\\omega}}")
    m <= SteadyStateParameter(:??_sp??_e, NaN, tex_label="\\zeta_{sp_{\\mu_e}}")
    m <= SteadyStateParameter(:??_nRk, NaN, tex_label="\\zeta_{n_R_k}")
    m <= SteadyStateParameter(:??_nR, NaN, tex_label="\\zeta_{n_R}")
    m <= SteadyStateParameter(:??_nqk, NaN, tex_label="\\zeta_{n_q_k}")
    m <= SteadyStateParameter(:??_nn, NaN, tex_label="\\zeta_{nn}")
    m <= SteadyStateParameter(:??_n??_e, NaN, tex_label="\\zeta_{n_{\\mu_e}}")
    m <= SteadyStateParameter(:??_n??_??, NaN, tex_label="\\zeta_{n_{\\sigma_\\omega}}")
end

"""
```
steadystate!(m::Model1010)
```

Calculates the model's steady-state values. `steadystate!(m)` must be called whenever
the parameters of `m` are updated.
"""
function steadystate!(m::Model1010)
    SIGWSTAR_ZERO = 0.5

    m[:z_star]   = log(1+m[:??]) + m[:??]/(1-m[:??])*log(m[:Upsilon])
    m[:rstar]    = exp(m[:??_c]*m[:z_star]) / (m[:??] * m[:lnb_safe] *  m[:lnb_liq])
    m[:Rstarn]   = 100*(m[:rstar]*m[:??_star] - 1)
    m[:r_k_star] = m[:spr]* m[:lnb_safe] * m[:lnb_liq]*m[:rstar]*m[:Upsilon] - (1-m[:??])
    m[:wstar]    = (m[:??]^m[:??] * (1-m[:??])^(1-m[:??]) * m[:r_k_star]^(-m[:??]) / m[:??])^(1/(1-m[:??]))
    m[:Lstar]    = 1.
    m[:kstar]    = (m[:??]/(1-m[:??])) * m[:wstar] * m[:Lstar] / m[:r_k_star]
    m[:kbarstar] = m[:kstar] * (1+m[:??]) * m[:Upsilon]^(1 / (1-m[:??]))
    m[:istar]    = m[:kbarstar] * (1-((1-m[:??])/((1+m[:??]) * m[:Upsilon]^(1/(1-m[:??])))))
    m[:ystar]    = (m[:kstar]^m[:??]) * (m[:Lstar]^(1-m[:??])) / m[:??]
    m[:cstar]    = (1-m[:g_star])*m[:ystar] - m[:istar]
    m[:wl_c]     = (m[:wstar]*m[:Lstar])/(m[:cstar]*m[:??_w])

    # FINANCIAL FRICTIONS ADDITIONS
    # solve for ??_??_star and z??_star
    z??_star = quantile(Normal(), m[:F??].scaledvalue)
    ??_??_star = SIGWSTAR_ZERO
    try
        ??_??_star = fzero(sigma -> ??_spb_fn(z??_star, sigma, m[:spr]) - m[:??_spb], 0.5)
    catch ex
        ??_??_star = SIGWSTAR_ZERO
        if !isa(ex, ConvergenceFailed)
            rethrow(ex)
        else
            ??_??_star = SIGWSTAR_ZERO
        end
    end

    # evaluate ??barstar
    ??barstar    = ??_fn(z??_star, ??_??_star)

    # evaluate all BGG function elasticities
    Gstar       = G_fn(z??_star, ??_??_star)
    ??star       = ??_fn(z??_star, ??_??_star)
    dGd??_star   = dG_d??_fn(z??_star, ??_??_star)
    d2Gd??2star  = d2G_d??2_fn(z??_star, ??_??_star)
    d??d??_star   = d??_d??_fn(z??_star)
    d2??d??2star  = d2??_d??2_fn(z??_star, ??_??_star)
    dGd??star    = dG_d??_fn(z??_star, ??_??_star)
    d2Gd??d??star = d2G_d??d??_fn(z??_star, ??_??_star)
    d??d??star    = d??_d??_fn(z??_star, ??_??_star)
    d2??d??d??star = d2??_d??d??_fn(z??_star, ??_??_star)

    # evaluate ??, nk, and Rhostar
    ??_estar     = ??_fn(z??_star, ??_??_star, m[:spr])
    nkstar      = nk_fn(z??_star, ??_??_star, m[:spr])
    Rhostar     = 1/nkstar - 1

    # define betabar_inverse
    if subspec(m) == "ss20"
        betabar_inverse = exp( (m[:??_c] -1) * m[:z_star]) / m[:??]
    else
        betabar_inverse = exp( (??_??_star -1) * m[:z_star]) / m[:??]
    end

    # evaluate wekstar and vkstar
    wekstar     = (1-(m[:??_star]*betabar_inverse))*nkstar - m[:??_star]*betabar_inverse*(m[:spr]*(1-??_estar*Gstar) - 1)
    vkstar      = (nkstar-wekstar)/m[:??_star]

    # evaluate nstar and vstar
    m[:nstar]   = nkstar*m[:kbarstar]
    m[:vstar]   = vkstar*m[:kbarstar]

    # a couple of combinations
    ????G         = ??star - ??_estar*Gstar
    ????Gprime    = d??d??_star - ??_estar*dGd??_star

    # elasticities wrt ??bar
    ??_bw        = ??_b??_fn(z??_star, ??_??_star, m[:spr])
    ??_zw        = ??_z??_fn(z??_star, ??_??_star, m[:spr])
    ??_bw_zw     = ??_bw/??_zw

    # elasticities wrt ??_??
    ??_b??_??      = ??_??_star * (((1 - ??_estar*dGd??star/d??d??star) /
        (1 - ??_estar*dGd??_star/d??d??_star) - 1)*d??d??star*m[:spr] + ??_estar*nkstar*
            (dGd??_star*d2??d??d??star - d??d??_star*d2Gd??d??star)/????Gprime^2) /
                ((1 - ??star)*m[:spr] + d??d??_star/????Gprime*(1-nkstar))
    ??_z??_??      = ??_??_star * (d??d??star - ??_estar*dGd??star) / ????G
    m[:??_sp??_??] = (??_bw_zw*??_z??_?? - ??_b??_??) / (1-??_bw_zw)

    # elasticities wrt ??_e
    ??_b??_e      = -??_estar * (nkstar*d??d??_star*dGd??_star/????Gprime+d??d??_star*Gstar*m[:spr]) /
        ((1-??star)*????Gprime*m[:spr] + d??d??_star*(1-nkstar))
    ??_z??_e      = -??_estar*Gstar/????G
    m[:??_sp??_e] = (??_bw_zw*??_z??_e - ??_b??_e) / (1-??_bw_zw)

    # some ratios/elasticities
    Rkstar      = m[:spr]*m[:??_star]*m[:rstar] # (r_k_star+1-??)/Upsilon*??_star
    ??_gw        = dGd??_star/Gstar*??barstar
    ??_G??_??      = dGd??star/Gstar*??_??_star

    # elasticities for the net worth evolution
    m[:??_nRk]   = m[:??_star]*Rkstar/m[:??_star]/exp(m[:z_star])*(1+Rhostar)*(1 - ??_estar*Gstar*(1 - ??_gw/??_zw))
    m[:??_nR]    = m[:??_star]*betabar_inverse*(1+Rhostar)*(1 - nkstar + ??_estar*Gstar*m[:spr]*??_gw/??_zw)
    m[:??_nqk]   = m[:??_star]*Rkstar/m[:??_star]/exp(m[:z_star])*(1+Rhostar)*(1 - ??_estar*Gstar*(1+??_gw/??_zw/Rhostar)) - m[:??_star]*betabar_inverse*(1+Rhostar)
    m[:??_nn]    = m[:??_star]*betabar_inverse + m[:??_star]*Rkstar/m[:??_star]/exp(m[:z_star])*(1+Rhostar)*??_estar*Gstar*??_gw/??_zw/Rhostar
    m[:??_n??_e]  = m[:??_star]*Rkstar/m[:??_star]/exp(m[:z_star])*(1+Rhostar)*??_estar*Gstar*(1 - ??_gw*??_z??_e/??_zw)
    m[:??_n??_??]  = m[:??_star]*Rkstar/m[:??_star]/exp(m[:z_star])*(1+Rhostar)*??_estar*Gstar*(??_G??_??-??_gw/??_zw*??_z??_??)

    return m
end

function model_settings!(m::Model1010)

    default_settings!(m)

    # Anticipated shocks
    m <= Setting(:n_mon_anticipated_shocks, 6,
                 "Number of anticipated policy shocks")
    m <= Setting(:n_mon_anticipated_shocks_padding, 20,
                 "Padding for anticipated policy shocks")

    # Data
    m <= Setting(:data_id, 4, "Dataset identifier")
    m <= Setting(:cond_full_names, [:obs_gdp, :obs_corepce, :obs_BBBspread, :obs_AAAspread, :obs_nominalrate, :obs_longrate],
                 "Observables used in conditional forecasts")
    m <= Setting(:cond_semi_names, [:obs_BBBspread, :obs_AAAspread, :obs_nominalrate, :obs_longrate],
                 "Observables used in semiconditional forecasts")

    # Forecast
    m <= Setting(:use_population_forecast, true,
                 "Whether to use population forecasts as data")
    m <= Setting(:shockdec_startdate, Nullable(quartertodate("2007-Q1")),
                 "Date of start of shock decomposition output period. If null, then shockdec starts at date_mainsample_start")

    nothing
end

"""
```
parameter_groupings(m::Model1010)
```

Returns an `OrderedDict{String, Vector{Parameter}}` mapping descriptions of
parameter groupings (e.g. \"Policy Parameters\") to vectors of
`Parameter`s. This dictionary is passed in as a keyword argument to
`prior_table`.
"""
function parameter_groupings(m::Model1010)
    steadystate = [:??, :??, :??, :??_c, :h, :??_l, :??, :??, :S??????, :ppsi,
                   :??_gdpdef, :Lmean, :??_w, :??_star, :g_star]

    sticky      = [:??_p, :??_w, :??_p, :??_w, :??_p, :??_w]

    policy      = [:??1, :??2, :??3, :??, :??_rm]

    financial   = [:F??, :spr, :??_spb, :??_star, :lnb_safe, :lnb_liq, :??_AAA]

    processes   = [[:??_g, :??_??, :??_z_p, :??_z, :??_b_liqp, :??_b_liqtil, :??_b_safep, :??_b_safetil, :??_??_w,
                  :??_??_star,  :??_??_f, :??_??_w, :??_??_f, :??_??_w, :??_gz, :??_g, :??_??,
                  :??_z_p, :??_z, :??_b_liqp, :??_b_liqtil, :??_b_safep, :??_b_safetil, :??_??_??, :??_??_star,
                  :??_??_f, :??_??_w, :??_r_m];
                  [Symbol("??_r_m$i") for i in 1:n_anticipated_shocks(m)]]

    error       = [:??_gdpdef, :??_gdpdef, :??_gdp, :??_gdi, :??_gdpvar, :??_gdpdef, :??_corepce, :??_AAA,
                   :??_BBB, :??_lr, :??_tfp, :??_gdp, :??_gdi, :??_gdpdef, :??_corepce, :??_AAA, :??_BBB,
                   :??_lr, :??_tfp]

    all_keys     = Vector[steadystate, sticky, policy, financial, processes, error]
    all_params   = map(keys -> [m[??]::Parameter for ?? in keys], all_keys)
    descriptions = ["Steady State",  "Nominal Rigidities", "Policy",
                    "Financial Frictions", "Exogenous Processes",
                    "Measurement"]

    groupings = OrderedDict{String, Vector{Parameter}}(zip(descriptions, all_params))

    # Ensure no parameters missing
    incl_params = vcat(collect(values(groupings))...)
    excl_params = [m[??] for ?? in vcat([:Upsilon, :??_??_e, :??_??, :??_??_e, :??_??, :Iendo??, :??_gdi, :??_gdi, :me_level],
                                      [Symbol("??_r_m$i") for i=2:20])]
    @assert isempty(setdiff(m.parameters, vcat(incl_params, excl_params)))

    return groupings
end

"""
```
shock_groupings(m::Model1010)
```

Returns a `Vector{ShockGroup}`, which must be passed in to
`plot_shock_decomposition`. See `?ShockGroup` for details.
"""
function shock_groupings(m::Model1010)
    gov      = ShockGroup("g", [:g_sh], RGB(0.70, 0.13, 0.13)) # firebrick
    bet_liq  = ShockGroup("b_liq", [:b_liqtil_sh, :b_liqp_sh], RGB(0.3, 0.3, 1.0))
    bet_safe = ShockGroup("b_safe", [:b_safetil_sh, :b_safep_sh], RGB(0.1, 0.6, 1.0))
    fin      = ShockGroup("FF", [:??_sh, :??_e_sh, :??_??_sh], RGB(0.29, 0.0, 0.51)) # indigo
    tfp      = ShockGroup("z", [:z_sh], RGB(1.0, 0.55, 0.0)) # darkorange
    pmu      = ShockGroup("p-mkp", [:??_f_sh], RGB(0.60, 0.80, 0.20)) # yellowgreen
    wmu      = ShockGroup("w-mkp", [:??_w_sh], RGB(0.0, 0.5, 0.5)) # teal
    pol      = ShockGroup("pol", vcat([:rm_sh], [Symbol("rm_shl$i") for i = 1:n_anticipated_shocks(m)]),
                          RGB(1.0, 0.84, 0.0)) # gold
    pis      = ShockGroup("pi-LR", [:??_star_sh], RGB(1.0, 0.75, 0.793)) # pink
    mei      = ShockGroup("mu", [:??_sh], :cyan)
    mea      = ShockGroup("me", [:lr_sh, :tfp_sh, :gdpdef_sh, :corepce_sh, :gdp_sh, :gdi_sh],
                          RGB(0.0, 0.8, 0.0))
    zpe      = ShockGroup("zp", [:zp_sh], RGB(0.0, 0.3, 0.0))
    det      = ShockGroup("dt", [:dettrend], :gray40)

    return [gov, bet_liq, bet_safe, fin, tfp, pmu, wmu, pol, pis, mei, mea, zpe, det]
end
