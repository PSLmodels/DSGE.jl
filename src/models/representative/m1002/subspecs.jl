"""
`init_subspec!(m::Model1002)`

Initializes a model subspecification by overwriting parameters from
the original model object with new parameter objects. This function is
called from within the model constructor.
"""
function init_subspec!(m::Model1002)
    if subspec(m) == "ss2"
        return
    elseif subspec(m) == "ss8"
        return ss8!(m)
    elseif subspec(m) == "ss9"
        return ss9!(m)
    elseif subspec(m) == "ss10"
        return ss10!(m)
    elseif subspec(m) == "ss11"
        # Normalize s.t. sum of variances of anticipated shocks equals the
        # variance of the contemporaneous shock
        # See measurement equation
        return ss10!(m)
    elseif subspec(m) == "ss12"
        return ss12!(m)
    elseif subspec(m) == "ss13"
        return ss13!(m)
    elseif subspec(m) == "ss14"
        return ss14!(m)
    elseif subspec(m) == "ss15"
        return ss15!(m)
    elseif subspec(m) == "ss16"
        return ss16!(m)
    elseif subspec(m) == "ss17"
        return ss17!(m)
    elseif subspec(m) == "ss18"
        return ss18!(m)
    elseif subspec(m) == "ss19"
        return ss19!(m)
    elseif subspec(m) == "ss20"
        return ss20!(m)
    elseif subspec(m) == "ss30"
        return ss30!(m)
    elseif subspec(m) == "ss51v"
        return ss51v!(m)
    elseif subspec(m) == "ss59"
        return ss59!(m)
    elseif subspec(m) == "ss60"
        return ss60!(m)
    elseif subspec(m) == "ss61"
        return ss61!(m)
    elseif subspec(m) == "ss62"
        return ss62!(m)
    elseif subspec(m) == "ss63"
        return ss63!(m)
    elseif subspec(m) == "ss64"
        return ss64!(m)
    elseif subspec(m) == "ss65"
        return ss65!(m)
    elseif subspec(m) == "ss66"
        return ss66!(m)
    elseif subspec(m) == "ss67"
        return ss67!(m)
    elseif subspec(m) == "ss68"
        return ss68!(m)
    elseif subspec(m) == "ss69"
        return ss69!(m)
    elseif subspec(m) == "ss70"
        return ss70!(m)
    elseif subspec(m) == "ss71"
        return ss71!(m)
    elseif subspec(m) == "ss72"
        return ss72!(m)
    elseif subspec(m) == "ss73"
        return ss73!(m)
    elseif subspec(m) == "ss74"
        return ss74!(m)
    elseif subspec(m) == "ss75"
        return ss75!(m)
    elseif subspec(m) == "ss76"
        return ss76!(m)
    elseif subspec(m) == "ss77"
        return ss77!(m)
    elseif subspec(m) == "ss78"
        return ss78!(m)
    elseif subspec(m) == "ss79"
        return ss79!(m)
    elseif subspec(m) == "ss80"
        return ss80!(m)
    elseif subspec(m) == "ss81"
        return ss81!(m)
    elseif subspec(m) == "ss82"
        return ss82!(m)
    elseif subspec(m) == "ss83"
        return ss83!(m)
    elseif subspec(m) == "ss84"
        return ss84!(m)
    elseif subspec(m) == "ss85"
        return ss85!(m)
    elseif subspec(m) == "ss86"
        return ss86!(m)
    else
        error("This subspec is not defined.")
    end
end

"""
```
ss3!(m::Model1002)
```

"""
function ss3!(m::Model1002)
    ss10!(m)
       m <= parameter(:??, 0.1596, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Normal(0.30, 0.15), fixed=false,
                   description="??: Capital elasticity in the intermediate goods sector's production function (also known as the capital share).",
                   tex_label="\\alpha")

    m <= parameter(:??_p, 0.8940, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.3), fixed=false,
                   description="??_p: The Calvo parameter. In every period, intermediate goods producers optimize prices with probability (1-??_p). With probability ??_p, prices are adjusted according to a weighted average of the previous period's inflation (??_t1) and steady-state inflation (??_star).",
                   tex_label="\\zeta_p")

    m <= parameter(:??_p, 0.1865, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.45), fixed=false,
                   description="??_p: The weight attributed to last period's inflation in price indexation. (1-??_p) is the weight attributed to steady-state inflation.",
                   tex_label="\\iota_p")

    m <= parameter(:??, 0.025, fixed=true,
                   description="??: The capital depreciation rate.",
                   tex_label="\\delta" )

    m <= parameter(:Upsilon, 1.000, (0., 10.), (1e-5, 0.), ModelConstructors.Exponential(), GammaAlt(1., 1.5), fixed=true,
                   description="??: The trend evolution of the price of investment goods relative to consumption goods. Set equal to 1.",
                   tex_label="\\Upsilon")

    m <= parameter(:??, 1.1066, (1., 10.), (1.00, 10.00), ModelConstructors.Exponential(), Normal(1.25, 0.36), fixed=false,
                   description="??: Fixed costs.",
                   tex_label="\\Phi_p")

    m <= parameter(:S??????, 2.7314, (-15., 15.), (-15., 15.), ModelConstructors.Untransformed(), Normal(4., 4.5), fixed=false,
                   description="S'': The second derivative of households' cost of adjusting investment.",
                   tex_label="S''")

    m <= parameter(:h, 0.5347, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="h: Consumption habit persistence.",
                   tex_label="h")

    m <= parameter(:ppsi, 0.6862, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="ppsi: Utilization costs.",
                   tex_label="\\psi")

    m <= parameter(:??_l, 2.5975, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(2, 2.25), fixed=false,
                   description="??_l: The coefficient of relative risk aversion on the labor term of households' utility function.",
                   tex_label="\\nu_l")

    m <= parameter(:??_w, 0.9291, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0.,1.), fixed=false,
                   description="??_w: (1-??_w) is the probability with which households can freely choose wages in each period. With probability ??_w, wages increase at a geometrically weighted average of the steady state rate of wage increases and last period's productivity times last period's inflation.",
                   tex_label="\\zeta_w")

    m <= parameter(:??_w, 0.2992, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0.,1.), fixed=false,
                   description="??_w: The weight attributed to last period's wage in wage indexation. (1-??_w) is the weight attributed to steady-state wages.",
                   tex_label="\\iota_w")

    m <= parameter(:??_w, 1.5000, fixed=true,
                   description="??_w: The wage markup, which affects the elasticity of substitution between differentiated labor services.",
                   tex_label="\\lambda_w")


    m <= parameter(:??, 0.1402, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.25, 0.3), fixed=false,
                   scaling = x -> 1/(1 + x/100),
                   description="??: Discount rate.",
                   tex_label="100(\\beta^{-1} - 1)")

    m <= parameter(:??1, 1.3679, (1e-5, 10.), (1e-5, 10.00), ModelConstructors.Exponential(), Normal(1.5, 0.75), fixed=false,
                   description="?????: Weight on inflation gap in monetary policy rule.",
                   tex_label="\\psi_1")

    m <= parameter(:??2, 0.0388, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.15), fixed=false,
                   description="?????: Weight on output gap in monetary policy rule.",
                   tex_label="\\psi_2")

    m <= parameter(:??3, 0.2464, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.15), fixed=false,
                   description="?????: Weight on rate of change of output gap in the monetary policy rule.",
                   tex_label="\\psi_3")

    m <= parameter(:??_star, 0.5000, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), GammaAlt(0.75, 0.4), fixed=true,
                   scaling = x -> 1 + x/100,
                   description="??_star: The steady-state rate of inflation.",
                   tex_label="\\pi_*")

    m <= parameter(:??_c, 0.8719, (1e-5, 10.), (1e-5, 10.), ModelConstructors.Exponential(), Normal(1.5, 1.11), fixed=false,
                   description="??_c: Coefficient of relative risk aversion.",
                   tex_label="\\sigma_{c}")

    m <= parameter(:??, 0.7126, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1,), fixed=false,
                   description="??: The degree of inertia in the monetary policy rule.",
                   tex_label="\\rho_R")

    m <= parameter(:??_p, 10.000, fixed=true,
                   description="??_p: Curvature parameter in the Kimball aggregator for prices.",
                   tex_label="\\epsilon_{p}")

    m <= parameter(:??_w, 10.000, fixed=true,
                   description="??_w: Curvature parameter in the Kimball aggregator for wages.",
                   tex_label="\\epsilon_{w}")

    # financial frictions parameters
    m <= parameter(:F??, 0.0300, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), BetaAlt(0.03, 0.01), fixed=true,
                   scaling = x -> 1 - (1-x)^0.25,
                   description="F(??): The cumulative distribution function of ?? (idiosyncratic iid shock that increases or decreases entrepreneurs' capital).",
                   tex_label="F(\\bar{\\omega})")

    m <= parameter(:spr, 1.7444, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), GammaAlt(2., 0.1), fixed=false,
                   scaling = x -> (1 + x/100)^0.25,
                   description="spr_*: Steady-state level of spread.",
                   tex_label="SP_*")

    m <= parameter(:??_spb, 0.0559, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), BetaAlt(0.05, 0.005), fixed=false,
                   description="??_spb: The elasticity of the expected exess return on capital (or 'spread') with respect to leverage.",
                   tex_label="\\zeta_{sp,b}")

    m <= parameter(:??_star, 0.9900, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), BetaAlt(0.99, 0.002), fixed=true,
                   description="??_star: Fraction of entrepreneurs who survive and continue operating for another period.",
                   tex_label="\\gamma_*")

    # exogenous processes - level
    m <= parameter(:??, 0.3673, (-5.0, 5.0), (-5., 5.), ModelConstructors.Untransformed(), Normal(0.4, 0.1), fixed=false,
                   scaling = x -> x/100,
                   description="??: The log of the steady-state growth rate of technology.",
                   tex_label="100\\gamma")

    m <= parameter(:Lmean, -45.9364, (-1000., 1000.), (-1e3, 1e3), ModelConstructors.Untransformed(), Normal(-45., 5.), fixed=false,
                   description="Lmean: Mean level of hours.",
                   tex_label="\\bar{L}")

    m <= parameter(:g_star, 0.1800, fixed=true,
                   description="g_star: 1 - (c_star + i_star)/y_star.",
                   tex_label="g_*")

    # exogenous processes - autocorrelation
    m <= parameter(:??_g, 0.9863, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_g: AR(1) coefficient in the government spending process.",
                   tex_label="\\rho_g")

    m <= parameter(:??_b, 0.9410, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_b: AR(1) coefficient in the intertemporal preference shifter process.",
                   tex_label="\\rho_b")

    m <= parameter(:??_??, 0.8735, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_??: AR(1) coefficient in capital adjustment cost process.",
                   tex_label="\\rho_{\\mu}")

    m <= parameter(:??_ztil, 0.9446, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_ztil: AR(1) coefficient in the technology process.",
                   tex_label="\\rho_{\\tilde{z}}")

    m <= parameter(:??_??_f, 0.8827, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_??_f: AR(1) coefficient in the price mark-up shock process.",
                   tex_label="\\rho_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3884, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_??_w: AR(1) coefficient in the wage mark-up shock process.",
                   tex_label="\\rho_{\\lambda_w}")

    # monetary policy shock - see eqcond
    m <= parameter(:??_rm, 0.2135, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_rm: AR(1) coefficient in the monetary policy shock process.",
                   tex_label="\\rho_{r^m}")

    m <= parameter(:??_??_w, 0.9898, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), Uniform(0., 1.0), fixed=false,
                   description="??_??_w: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with mean ??_??_w. Innovations to the process are called _spread shocks_.",
                   tex_label="\\rho_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.7500, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), Uniform(0., 1.0), fixed=true,
                   description="??_??_e: AR(1) coefficient in the exogenous bankruptcy cost process.",
                   tex_label="\\rho_{\\mu_e}")

    m <= parameter(:??_??, 0.7500, (1e-5, 0.99999), (1e-5, 0.99), ModelConstructors.SquareRoot(), Uniform(0., 1.0), fixed=true,
                   description="??_??: AR(1) coefficient in the process describing the fraction of entrepreneurs surviving period t.",
                   tex_label="\\rho_{\\gamma}")

    m <= parameter(:??_??_star, 0.9900, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=true,
                   description="??_??_star: AR(1) coefficient in the time-varying inflation target process.",
                   tex_label="\\rho_{\\pi_*}")

    m <= parameter(:??_lr, 0.6936, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   tex_label="\\rho_{10y}")

    m <= parameter(:??_z_p, 0.8910, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   description="??_z_p: AR(1) coefficient in the process describing the permanent component of productivity.",
                   tex_label="\\rho_{z^p}")

    m <= parameter(:??_tfp, 0.1953, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   tex_label="\\rho_{tfp}")


    m <= parameter(:??_gdpdef, 0.5379, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   tex_label="\\rho_{gdpdef}")

    m <= parameter(:??_corepce, 0.2320, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), Uniform(0., 1.), fixed=false,
                   tex_label="\\rho_{pce}")

    m <= parameter(:??_gdp, 0., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.2), fixed=false,
                   tex_label="\\rho_{gdp}")

    m <= parameter(:??_gdi, 0., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.2), fixed=false,
                   tex_label="\\rho_{gdi}")

    m <= parameter(:??_gdpvar, 0., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.SquareRoot(), Normal(0.0, 0.4), fixed=false,
                   tex_label="\\varrho_{gdp}")

    m <= parameter(:me_level, 1., (-0.999, 0.999), (-0.999, 0.999), ModelConstructors.Untransformed(), Normal(0.0, 0.4), fixed=true,
                   description="me_level: Indicator of cointegration of GDP and GDI.",
                   tex_label="\\mathcal{C}_{me}")

    # exogenous processes - standard deviation
    m <= parameter(:??_g, 2.5230, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b, 0.0292, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b: The standard deviation of the intertemporal preference shifter process.",
                   tex_label="\\sigma_{b}")

    m <= parameter(:??_??, 0.4559, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_ztil, 0.6742, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_ztil: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{\\tilde{z}}")

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

    m <= parameter(:??_??_e, 0.0000, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=true,
                   description="??_??_e: Exogenous bankrupcy costs follow an exogenous process with standard deviation ??_??_e.",
                   tex_label="\\sigma_{\\mu_e}")

    m <= parameter(:??_??, 0.0000, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.01), fixed=true,
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

  # standard deviations of the anticipated policy shocks
    for i = 1:n_mon_anticipated_shocks_padding(m)
        if i <= n_mon_anticipated_shocks(m)
            m <= parameter(Symbol("??_r_m$i"), .2, (1e-7, 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, .2), fixed=false,
                           description="??_r_m$i: Standard deviation of the $i-period-ahead anticipated policy shock.",
                           tex_label=@sprintf("\\sigma_{ant%d}",i))
        else
            m <= parameter(Symbol("??_r_m$i"), .0, (1e-7, 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, .2), fixed=true,
                           description="??_r_m$i: Standard deviation of the $i-period-ahead anticipated policy shock.",
                           tex_label=@sprintf("\\sigma_{ant%d}",i))
        end
    end

    m <= parameter(:??_gz, 0.8400, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_gz: Correlate g and z shocks.",
                   tex_label="\\eta_{gz}")

    m <= parameter(:??_??_f, 0.7892, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_f: Moving average component in the price markup shock.",
                   tex_label="\\eta_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.4226, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.50, 0.20), fixed=false,
                   description="??_??_w: Moving average component in the wage markup shock.",
                   tex_label="\\eta_{\\lambda_w}")

    m <= parameter(:Iendo??, 0.0000, (0.000, 1.000), (0., 0.), ModelConstructors.Untransformed(), BetaAlt(0.50, 0.20), fixed=true,
                   description="Iendo??: Indicates whether to use the model's endogenous ?? in the capacity utilization adjustment of total factor productivity.",
                   tex_label="I\\{\\alpha^{model}\\}")

    m <= parameter(:??_gdpdef, 1.0354, (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(1.00, 2.), fixed=false,
                   tex_label="\\gamma_{gdpdef}")

    m <= parameter(:??_gdpdef, 0.0181, (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(0.00, 2.), fixed=false,
                   tex_label="\\delta_{gdpdef}")

    m <= parameter(:??_gdi, 1., (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(1., 2.), fixed=false,
                   tex_label="\\gamma_{gdi}")

    m <= parameter(:??_gdi, 0., (-10., 10.), (-10., -10.), ModelConstructors.Untransformed(), Normal(0.00, 2.), fixed=false,
                   tex_label="\\delta_{gdi}")


end

"""
```
ss5!(m::Model1002)
```
The loose prior subspec we ACTUALLY WANT since it's only loose on the parameters we allow to switch
"""
function ss5!(m::Model1002)
    ss10!(m)
    m <= parameter(:??1, 1.3679, (1e-5, 10.), (1e-5, 10.00), ModelConstructors.Exponential(), Normal(1.5, 0.75), fixed=false,
                   description="?????: Weight on inflation gap in monetary policy rule.",
                   tex_label="\\psi_1")

    m <= parameter(:??2, 0.0388, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.15), fixed=false,
                   description="?????: Weight on output gap in monetary policy rule.",
                   tex_label="\\psi_2")

    m <= parameter(:??3, 0.2464, (-0.5, 0.5), (-0.5, 0.5), ModelConstructors.Untransformed(), Normal(0.12, 0.15), fixed=false,
                   description="?????: Weight on rate of change of output gap in the monetary policy rule.",
                   tex_label="\\psi_3")

    m <= parameter(:??, 0.7126, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.75, 0.30), fixed=false,
                   description="??: The degree of inertia in the monetary policy rule.",
                   tex_label="\\rho_R")

    m <= parameter(:??_p, 0.8940, (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(), BetaAlt(0.5, 0.3), fixed=false,
                   description="??_p: The Calvo parameter (Regime 1). In every period, intermediate goods producers optimize prices with probability (1-??_p). With probability ??_p, prices are adjusted according to a weighted average of the previous period's inflation (??_t1) and steady-state inflation (??_star).",
                   tex_label="\\zeta_p")
end


"""
```
ss8!(m::Model1002)
```

Initializes subspec 8 of `Model1002`. In this subspecification, ??_gdi
and ??_gdi are fixed at 1 and 0 respectively.
"""
function ss8!(m::Model1002)
    m <= parameter(:??_gdi, 1., (-10., 10.), (-10., -10.), Untransformed(), Normal(1., 2.), fixed = true,
                   tex_label = "\\gamma_{gdi}")

    m <= parameter(:??_gdi, 0., (-10., 10.), (-10., -10.), Untransformed(), Normal(0.00, 2.), fixed = true,
                   tex_label = "\\delta_{gdi}")
end

"""
```
ss9!(m::Model1002)
```

Initializes subspec 9 of `Model1002`. This subspecification is ss8 + Iskander's
changes + the bounds for beta-distributed parameters have been changed from
(1e-5, 0.99) to (0.0, 1.0).
"""
function ss9!(m::Model1002)

    ss8!(m)

    m <= parameter(:??_p, 0.8940, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.1), fixed = false,
                   description = "??_p: The Calvo parameter. In every period, intermediate goods producers optimize prices with probability (1-??_p). With probability ??_p, prices are adjusted according to a weighted average of the previous period's inflation (??_t1) and steady-state inflation (??_star).",
                   tex_label = "\\zeta_p")

    m <= parameter(:??_p, 0.1865, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.15), fixed = false,
                   description = "??_p: The weight attributed to last period's inflation in price indexation. (1-??_p) is the weight attributed to steady-state inflation.",
                   tex_label = "\\iota_p")

    m <= parameter(:h, 0.5347, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.7, 0.1), fixed = false,
                   description = "h: Consumption habit persistence.",
                   tex_label = "h")

    m <= parameter(:ppsi, 0.6862, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.15), fixed = false,
                   description = "ppsi: Utilization costs.",
                   tex_label = "\\psi")

    m <= parameter(:??_w, 0.9291, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.1), fixed = false,
                   description = "??_w: (1-??_w) is the probability with which households can freely choose wages in each period. With probability ??_w, wages increase at a geometrically weighted average of the steady state rate of wage increases and last period's productivity times last period's inflation.",
                   tex_label = "\\zeta_w")

    m <= parameter(:??_w, 0.2992, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.15), fixed = false,
                   description = "??_w: The weight attributed to last period's wage in wage indexation. (1-??_w) is the weight attributed to steady-state wages.",
                   tex_label = "\\iota_w")

    m <= parameter(:??, 0.7126, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.75, 0.10), fixed = false,
                   description = "??: The degree of inertia in the monetary policy rule.",
                   tex_label = "\\rho_R")

    # Financial frictions parameters
    m <= parameter(:F??, 0.0300, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.03, 0.01), fixed = true,
                   scaling = x -> 1 - (1-x)^0.25,
                   description = "F(??): The cumulative distribution function of ?? (idiosyncratic iid shock that increases or decreases entrepreneurs' capital).",
                   tex_label = "F(\\bar{\\omega})")

    m <= parameter(:??_spb, 0.0559, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.05, 0.005), fixed = false,
                   description = "??_spb: The elasticity of the expected exess return on capital (or 'spread') with respect to leverage.",
                   tex_label = "\\zeta_{sp,b}")

    m <= parameter(:??_star, 0.9900, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.99, 0.002),
                   fixed = true,
                   description = "??_star: Fraction of entrepreneurs who survive and continue operating for another period.",
                   tex_label = "\\gamma_*")

    m <= parameter(:??_g, 0.9863, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_g: AR(1) coefficient in the government spending process.",
                   tex_label = "\\rho_g")

    m <= parameter(:??_b, 0.9410, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_b: AR(1) coefficient in the intertemporal preference shifter process.",
                   tex_label = "\\rho_b")

    m <= parameter(:??_??, 0.8735, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_??: AR(1) coefficient in capital adjustment cost process.",
                   tex_label = "\\rho_{\\mu}")

    m <= parameter(:??_ztil, 0.9446, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_ztil: AR(1) coefficient in the technology process.",
                   tex_label = "\\rho_ztil")

    m <= parameter(:??_??_f, 0.8827, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_??_f: AR(1) coefficient in the price mark-up shock process.",
                   tex_label = "\\rho_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3884, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_??_w: AR(1) coefficient in the wage mark-up shock process.",
                   tex_label = "\\rho_{\\lambda_w}")

    m <= parameter(:??_rm, 0.2135, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_rm: AR(1) coefficient in the monetary policy shock process.",
                   tex_label = "\\rho_{r^m}")

    m <= parameter(:??_??_w, 0.9898, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.75, 0.15), fixed = false,
                   description = "??_??_w: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with mean ??_??_w. Innovations to the process are called _spread shocks_.",
                   tex_label = "\\rho_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.7500, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.75, 0.15), fixed = true,
                   description = "??_??_e: AR(1) coefficient in the exogenous bankruptcy cost process.",
                   tex_label = "\\rho_{\\mu_e}")

    m <= parameter(:??_??, 0.7500, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.75, 0.15), fixed = true,
                   description = "??_??: AR(1) coefficient in the process describing the fraction of entrepreneurs surviving period t.",
                   tex_label = "\\rho_{\\gamma}")

    m <= parameter(:??_??_star, 0.9900, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = true,
                   description = "??_??_star: AR(1) coefficient in the time-varying inflation target process.",
                   tex_label = "\\rho_{\\pi_*}")

    m <= parameter(:??_lr, 0.6936, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   tex_label = "\\rho_{10y}")

    m <= parameter(:??_z_p, 0.8910, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   description = "??_z_p: AR(1) coefficient in the process describing the permanent component of productivity.",
                   tex_label = "\\rho_{z^p}")

    m <= parameter(:??_tfp, 0.1953, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   tex_label = "\\rho_{tfp}")

    m <= parameter(:??_gdpdef, 0.5379, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   tex_label = "\\rho_{gdpdef}")

    m <= parameter(:??_corepce, 0.2320, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.5, 0.2), fixed = false,
                   tex_label = "\\rho_{pce}")

    m <= parameter(:??_gz, 0.8400, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.50, 0.20), fixed = false,
                   description = "??_gz: Correlate g and z shocks.",
                   tex_label = "\\eta_{gz}")

    m <= parameter(:??_??_f, 0.7892, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.50, 0.20), fixed = false,
                   tex_label = "\\eta_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.4226, (0.0, 1.0), (0.0, 1.0), SquareRoot(), BetaAlt(0.50, 0.20), fixed = false,
                   description = "??_??_w: AR(2) coefficient on wage markup shock process.",
                   tex_label = "\\eta_{\\lambda_w}")

    m <= parameter(:Iendo??, 0.0000, (0.0, 1.0), (0.0, 0.0), Untransformed(), BetaAlt(0.50, 0.20), fixed = true,
                   description = "Iendo??: Indicates whether to use the model's endogenous ?? in the capacity utilization adjustment of total factor productivity.",
                   tex_label = "I\\{\\alpha^{model}\\}")
end

"""
```
ss10!(m::Model1002)
```

Initializes subspec 10 of `Model1002`. This subspecification is the same as ss9,
except `betabar` is defined with `m[:??_c]` instead of `??_??_star`.
"""
function ss10!(m::Model1002)
    ss9!(m)
end

"""
```
ss12!(m::Model1002)
```

Initializes subspec 12 of `Model1002`. This subspecification is the same as ss10,
but exogenous processes are added as pseudo-observables.
"""
function ss12!(m::Model1002)
    ss10!(m)
end

"""
```
ss13!(m::Model1002)
```

Initializes subspec 13 of `Model1002`. This subspecification is the same as ss10,
but tracks Sinf_t, the contribution of expected future marginal cost, as a pseudo-obs.
"""
function ss13!(m::Model1002)
    ss10!(m)
end

"""
```
ss14!(m::Model1002)
```

Initializes subspec 14 of `Model1002`. This subspecification is the same as ss13,
but with stationarity in the levels (rather than growth) of the measurement
error in the TFP process.
"""
function ss14!(m::Model1002)
    ss13!(m)
end

"""
```
ss15!(m::Model1002)
```

Initializes subspec 15 of `Model1002`. This subspecification is the same as ss14,
but with the TFP observables series now being Fernald's TFP adjusted to utilization.
"""
function ss15!(m::Model1002)
    ss14!(m)
end

"""
```
ss16!(m::Model1002)
```

Initializes subspec 16 of `Model1002`. This subspecification is the same as ss15,
but with the measurement equation using log labor share instead of wage growth.
"""
function ss16!(m::Model1002)
    ss15!(m)
end

"""
```
ss17!(m::Model1002)
```

Initializes subspec 17 of `Model1002`. This subspecification is the same as ss13,
but with the measurement equation using log labor share instead of wage growth.
"""
function ss17!(m::Model1002)
    ss13!(m)
end

"""
```
ss18!(m::Model1002)
```

Initializes subspec 18 of `Model1002`. This subspecification is the same as ss14,
but with ??_tfp = 0 (fixed) and a near-zero prior on ??_tfp
"""
function ss18!(m::Model1002)
    ss14!(m)
    m <= parameter(:??_tfp, 0., (1e-5, 0.999), (1e-5, 0.999), ModelConstructors.SquareRoot(),
                   BetaAlt(0.5, 0.2), fixed = true, tex_label = "\\rho_{tfp}")
    m <= parameter(:??_tfp, 0.01, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(),
                   RootInverseGamma(2, sqrt(0.0001)), fixed=false,
                   tex_label="\\sigma_{tfp}")
end

"""
```
ss19!(m::Model1002)
```

Initializes subspec 19 of `Model1002`. This subspecification is the same as ss14,
but with a near zero prior on ??_tfp and ??_tfp
"""
function ss19!(m::Model1002)
    ss14!(m)
    m <= parameter(:??_tfp, 0.01, (1e-5, 0.999999), (1e-5, 0.999999), ModelConstructors.SquareRoot(),
                   BetaAlt(0.01, 0.02), fixed = false, tex_label = "\\rho_{tfp}")
    m <= parameter(:??_tfp, 0.01, (1e-8, 5.), (1e-8, 5.), ModelConstructors.Exponential(),
                   RootInverseGamma(2, sqrt(0.0001)), fixed=false,
                   tex_label="\\sigma_{tfp}")
end

"""
```
ss20!(m::Model1002)
```

Initializes subspec 20 of `Model1002`. This subspecification is the same as ss10,
but the coefficient on markup shocks in the price Phillips curve is re-scaled.
"""
function ss20!(m::Model1002)
    ss10!(m)
end

"""
```
ss30!(m::Model1002)
```

Initializes subspec 30 of `Model1002`. This subspecification is the same as ss10,
except the monetary policy rule incorporates the Federal Reserve's policy change
to flexible average inflation targeting in 2020-Q3.
"""
function ss30!(m::Model1002)
    ss10!(m)

    # Default regime dates
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 9, 30)))
    setup_regime_switching_inds!(m)

    # Default settings for flexible AIT rule
    if get_setting(m, :flexible_ait_policy_change)
        m <= Setting(:pgap_type, :flexible_ait)
        m <= Setting(:pgap_value, 0.)
        m <= Setting(:ygap_type, :flexible_ait)
        m <= Setting(:ygap_value, 12.)

        m <= Setting(:ait_Thalf, 10.)
        m <= Setting(:gdp_Thalf, 10.)
        m <= Setting(:flexible_ait_??_smooth, 0.)
        m <= Setting(:flexible_ait_??_??, 6.)
        m <= Setting(:flexible_ait_??_y, 6.)

        # Set up imperfect credibility of flexible AIT rule
        if !haskey(get_settings(m), :imperfect_credibility_weights)
            m <= Setting(:imperfect_credibility_weights, [1., 0.]) # default to perfect credibility
        end
        if !haskey(get_settings(m), :imperfect_credibility_historical_policy)
            m <= Setting(:imperfect_credibility_historical_policy, taylor_rule())
        end
    end
end

"""
```
ss51v!(m::Model1002)
```

Second regime where b, mp, and anticipated shocks are ctive.
"""
function ss51v!(m::Model1002)
    ModelConstructors.set_regime_val!(m[:??_g], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_b], 2, 0.0292)
    ModelConstructors.set_regime_val!(m[:??_??], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_ztil], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??_f], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??_w], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_r_m], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??_??], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??_e], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_??_star], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_lr], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_z_p], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_tfp], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_gdpdef], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_corepce], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_gdp], 2, 0., override_bounds = true)
    ModelConstructors.set_regime_val!(m[:??_gdi], 2, 0., override_bounds = true)

    # standard deviations of the anticipated policy shocks
    for i = 1:n_mon_anticipated_shocks(m)
        ModelConstructors.set_regime_val!(m[Symbol("??_r_m$(i)")], 2, 0., override_bounds = true)
    end

    # Add regime switching settings
    m <= Setting(:regime_switching, true)
    m <= Setting(:n_regimes, 1)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m))) # By default, 1 regime starting at the presample start date.
end

"""
```
ss59!(m::Model1002)
```

models a "temporary shutdown" scenario of the COVID-19 pandemic by using the following features:

1. biidc, ??, and ziid shocks alive in 2020Q1-Q2
2. One-period ahead anticipated shocks for the iid shocks alive in 2020Q1 and expected to hit in 2020Q2.
     These shocks are assumed to be twice the size of the unanticipated shocks which are realized in 2020Q1.
3. The standard deviation of the zp (permanent technology shock) is zero.
4. The standard deviation of the other shocks are set to 0.25 times their value in the time periods before 2020Q1.
5. The standard deviation of monetary policy shocks are set to 10 times their value in the time periods before 2020Q1.

Confer with the official documentation about the COVID-19 shocks on the GitHub page.
"""
function ss59!(m::Model1002)
    # Set up regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30)))
    # if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
    #     m <= Setting(:model2para_regime, Dict{Symbol, Dict{Int, Int}}()) # initialize
    # end
    setup_regime_switching_inds!(m)

    # Default settings for flexible AIT rule
    if get_setting(m, :flexible_ait_policy_change)
        m <= Setting(:pgap_type, :flexible_ait)
        m <= Setting(:pgap_value, 0.)
        m <= Setting(:ygap_type, :flexible_ait)
        m <= Setting(:ygap_value, 12.)

        m <= Setting(:ait_Thalf, 10.)
        m <= Setting(:gdp_Thalf, 10.)
        m <= Setting(:flexible_ait_??_smooth, 0.)
        m <= Setting(:flexible_ait_??_??, 6.)
        m <= Setting(:flexible_ait_??_y, 6.)

        # Set up imperfect credibility of flexible AIT rule
        if !haskey(get_settings(m), :imperfect_credibility_weights)
            m <= Setting(:imperfect_credibility_weights, [1., 0.]) # default to perfect credibility
        end
        if !haskey(get_settings(m), :imperfect_credibility_historical_policy)
            m <= Setting(:imperfect_credibility_historical_policy, taylor_rule())
        end
    end

    # Allow the lower bound of non-COVID-19 parameters to equal zero
    m <= parameter(:??_g, 2.5230, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b, 0.0292, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b: The standard deviation of the intertemporal preference shifter process.",
                   tex_label="\\sigma_{b}")

    m <= parameter(:??_??, 0.4559, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_ztil, 0.6742, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_ztil: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{\\tilde{z}}")

    m <= parameter(:??_??_f, 0.1314, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??_f: The mean of the process that generates the price elasticity of the composite good. Specifically, the elasticity is (1+??_{f,t})/(??_{f_t}).",
                   tex_label="\\sigma_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3864, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{\\lambda_w}")

    m <= parameter(:??_r_m, 0.2380, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_r_m: The standard deviation of the monetary policy shock.",
                   tex_label="\\sigma_{r^m}")

    m <= parameter(:??_??_??, 0.0428, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_??: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with standard deviation ??_??_??.",
                   tex_label="\\sigma_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.0000, (0. ,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_e: Exogenous bankrupcy costs follow an exogenous process with standard deviation ??_??_e.",
                   tex_label="\\sigma_{\\mu_e}")

    m <= parameter(:??_??, 0.0000, (0.,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.01), fixed=false,
                   description="??_??: The fraction of entrepreneurs surviving period t follows an exogenous process with standard deviation ??_??.",
                   tex_label="\\sigma_{\\gamma}")

    m <= parameter(:??_??_star, 0.0269, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_??_star: The standard deviation of the inflation target.",
                   tex_label="\\sigma_{\\pi_*}")

    m <= parameter(:??_lr, 0.1766, (0.,10.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.75), fixed=false,
                   tex_label="\\sigma_{10y}")

    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    m <= parameter(:??_tfp, 0.9391, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{tfp}")

    m <= parameter(:??_gdpdef, 0.1575, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdpdef}")

    m <= parameter(:??_corepce, 0.0999, (0., 5.),(0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{pce}")

    m <= parameter(:??_gdp, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdp}")

    m <= parameter(:??_gdi, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdi}")

    # standard deviations of the anticipated policy shocks
    for i = 1:n_mon_anticipated_shocks(m)
        m <= parameter(Symbol("??_r_m$(i)"), .2, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end
    for i = n_mon_anticipated_shocks(m) + 1:n_mon_anticipated_shocks_padding(m)
        m <= parameter(Symbol("??_r_m$(i)"), 0., (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end

    # TODO: add functionality for different model regimes from parameter regimes by
    #       creating the Setting model2para_regime.
    # Define regimes for standard shocks
    for i in 1:4
        adj = (i == 2 || i == 3) ? .25 : 1.
        ModelConstructors.set_regime_val!(m[:??_g], i, adj * m[:??_g].value)
        ModelConstructors.set_regime_val!(m[:??_b], i, adj * m[:??_b].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, adj * m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_ztil], i, adj * m[:??_ztil].value)
        ModelConstructors.set_regime_val!(m[:??_??_f], i, adj * m[:??_??_f].value)
        ModelConstructors.set_regime_val!(m[:??_??_w], i, adj * m[:??_??_w].value)
        ModelConstructors.set_regime_val!(m[:??_r_m], i, adj * m[:??_r_m].value)
        ModelConstructors.set_regime_val!(m[:??_??_??], i, adj * m[:??_??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_e], i, adj * m[:??_??_e].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, adj * m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_star], i, adj * m[:??_??_star].value)
        ModelConstructors.set_regime_val!(m[:??_lr], i, adj * m[:??_lr].value)
        ModelConstructors.set_regime_val!(m[:??_z_p], i, adj * m[:??_z_p].value)
        ModelConstructors.set_regime_val!(m[:??_tfp], i, adj * m[:??_tfp].value)
        err_adj = (i == 3) ? 10. : adj
        ModelConstructors.set_regime_val!(m[:??_gdpdef], i, err_adj * m[:??_gdpdef].value)
        ModelConstructors.set_regime_val!(m[:??_corepce], i, err_adj * m[:??_corepce].value)
        ModelConstructors.set_regime_val!(m[:??_gdp], i, adj * m[:??_gdp].value)
        ModelConstructors.set_regime_val!(m[:??_gdi], i, adj * m[:??_gdi].value)

        for j = 1:DSGE.n_mon_anticipated_shocks(m)
            ModelConstructors.set_regime_val!(m[Symbol("??_r_m$(j)")], i, adj * m[Symbol("??_r_m$(j)")].value)
        end
    end

    ModelConstructors.set_regime_val!(m[:??_r_m], 2, 10. * m[:??_r_m].value) # By default, we set these to 10 times their
    ModelConstructors.set_regime_val!(m[:??_r_m], 3, 10. * m[:??_r_m].value) # value in the pre-COVID and post-COVID regimes
    for i = 2:3
        for j = 1:n_mon_anticipated_shocks(m)
            ModelConstructors.set_regime_val!(m[Symbol("??_r_m$(j)")], i, m[Symbol("??_r_m$(j)")].value)
        end
    end
    ModelConstructors.set_regime_val!(m[:??_z_p], 2, 0.)
    ModelConstructors.set_regime_val!(m[:??_z_p], 3, 0.)

    # Set up the COVID-19 shocks. We do not add anticipation by default
    ModelConstructors.set_regime_val!(m[:??_??], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??], 2, 400.) # initial value from literature, blown up by 100
    ModelConstructors.set_regime_val!(m[:??_??], 3, 400.)
    ModelConstructors.set_regime_val!(m[:??_??], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 2, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 3, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 2, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 3, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 4, 0.)
end

"""
```
ss60!(m::Model1002)
```
models a "temporary shutdown with business cycle dynamics" scenario of the COVID-19 pandemic by using the following features:

1. biidc, ??, and ziid shocks alive in 2020Q1-Q2
2. One-period ahead anticipated shocks for the iid shocks alive in 2020Q1 and expected to hit in 2020Q2.
     These shocks are assumed to be twice the size of the unanticipated shocks which are realized in 2020Q1.
3. The standard deviation of monetary policy shocks are set to 10 times their value in the time periods before 2020Q1.

Confer with the official documentation about the COVID-19 shocks on the GitHub page.
"""
function ss60!(m::Model1002)
    # Set up regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30)))
    # if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
    #     m <= Setting(:model2para_regime, Dict{Symbol, Dict{Int, Int}}()) # initialize
    # end
    setup_regime_switching_inds!(m)

    # Default settings for flexible AIT rule
    if get_setting(m, :flexible_ait_policy_change)
        m <= Setting(:pgap_type, :flexible_ait)
        m <= Setting(:pgap_value, 0.)
        m <= Setting(:ygap_type, :flexible_ait)
        m <= Setting(:ygap_value, 12.)

        m <= Setting(:ait_Thalf, 10.)
        m <= Setting(:gdp_Thalf, 10.)
        m <= Setting(:flexible_ait_??_smooth, 0.)
        m <= Setting(:flexible_ait_??_??, 6.)
        m <= Setting(:flexible_ait_??_y, 6.)

        # Set up imperfect credibility of flexible AIT rule
        if !haskey(get_settings(m), :imperfect_credibility_weights)
            m <= Setting(:imperfect_credibility_weights, [1., 0.]) # default to perfect credibility
        end
        if !haskey(get_settings(m), :imperfect_credibility_historical_policy)
            m <= Setting(:imperfect_credibility_historical_policy, taylor_rule())
        end
    end

    # Allow the lower bound of non-COVID-19 parameters to equal zero
    m <= parameter(:??_g, 2.5230, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b, 0.0292, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b: The standard deviation of the intertemporal preference shifter process.",
                   tex_label="\\sigma_{b}")

    m <= parameter(:??_??, 0.4559, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_ztil, 0.6742, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_ztil: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{\\tilde{z}}")

    m <= parameter(:??_??_f, 0.1314, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??_f: The mean of the process that generates the price elasticity of the composite good. Specifically, the elasticity is (1+??_{f,t})/(??_{f_t}).",
                   tex_label="\\sigma_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3864, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{\\lambda_w}")

    m <= parameter(:??_r_m, 0.2380, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_r_m: The standard deviation of the monetary policy shock.",
                   tex_label="\\sigma_{r^m}")

    m <= parameter(:??_??_??, 0.0428, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_??: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with standard deviation ??_??_??.",
                   tex_label="\\sigma_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.0000, (0. ,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_e: Exogenous bankrupcy costs follow an exogenous process with standard deviation ??_??_e.",
                   tex_label="\\sigma_{\\mu_e}")

    m <= parameter(:??_??, 0.0000, (0.,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.01), fixed=false,
                   description="??_??: The fraction of entrepreneurs surviving period t follows an exogenous process with standard deviation ??_??.",
                   tex_label="\\sigma_{\\gamma}")

    m <= parameter(:??_??_star, 0.0269, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_??_star: The standard deviation of the inflation target.",
                   tex_label="\\sigma_{\\pi_*}")

    m <= parameter(:??_lr, 0.1766, (0.,10.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.75), fixed=false,
                   tex_label="\\sigma_{10y}")

    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    m <= parameter(:??_tfp, 0.9391, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{tfp}")

    m <= parameter(:??_gdpdef, 0.1575, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdpdef}")

    m <= parameter(:??_corepce, 0.0999, (0., 5.),(0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{pce}")

    m <= parameter(:??_gdp, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdp}")

    m <= parameter(:??_gdi, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdi}")

    # standard deviations of the anticipated policy shocks
    for i = 1:n_mon_anticipated_shocks(m)
        m <= parameter(Symbol("??_r_m$(i)"), .2, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end
    for i = n_mon_anticipated_shocks(m) + 1:n_mon_anticipated_shocks_padding(m)
        m <= parameter(Symbol("??_r_m$(i)"), 0., (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end

    # Define regimes for standard shocks
    for i in 1:4
        ModelConstructors.set_regime_val!(m[:??_g], i, m[:??_g].value)
        ModelConstructors.set_regime_val!(m[:??_b], i, m[:??_b].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_ztil], i, m[:??_ztil].value)
        ModelConstructors.set_regime_val!(m[:??_??_f], i, m[:??_??_f].value)
        ModelConstructors.set_regime_val!(m[:??_??_w], i, m[:??_??_w].value)
        ModelConstructors.set_regime_val!(m[:??_r_m], i, m[:??_r_m].value)
        ModelConstructors.set_regime_val!(m[:??_??_??], i, m[:??_??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_e], i, m[:??_??_e].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_star], i, m[:??_??_star].value)
        ModelConstructors.set_regime_val!(m[:??_lr], i, m[:??_lr].value)
        ModelConstructors.set_regime_val!(m[:??_z_p], i, m[:??_z_p].value)
        ModelConstructors.set_regime_val!(m[:??_tfp], i, m[:??_tfp].value)
        err_adj = (i == 3) ? 10. : 1.
        ModelConstructors.set_regime_val!(m[:??_gdpdef], i, err_adj * m[:??_gdpdef].value)
        ModelConstructors.set_regime_val!(m[:??_corepce], i, err_adj * m[:??_corepce].value)
        ModelConstructors.set_regime_val!(m[:??_gdp], i, m[:??_gdp].value)
        ModelConstructors.set_regime_val!(m[:??_gdi], i, m[:??_gdi].value)

        for j = 1:DSGE.n_mon_anticipated_shocks(m)
            ModelConstructors.set_regime_val!(m[Symbol("??_r_m$(j)")], i, m[Symbol("??_r_m$(j)")].value)
        end
    end

    ModelConstructors.set_regime_val!(m[:??_r_m], 2, 10. * m[:??_r_m].value) # By default, we set these to 10 times their
    ModelConstructors.set_regime_val!(m[:??_r_m], 3, 10. * m[:??_r_m].value) # value in the pre-COVID and post-COVID regimes

    # Set up the COVID-19 shocks. We do not add anticipation by default
    ModelConstructors.set_regime_val!(m[:??_??], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??], 2, 400.) # initial value from literature, blown up by 100
    ModelConstructors.set_regime_val!(m[:??_??], 3, 400.)
    ModelConstructors.set_regime_val!(m[:??_??], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 2, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 3, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 2, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 3, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 4, 0.)
end

"""
```
ss61!(m::Model1002)
```

models a "persistent demand shortfall" scenario of the COVID-19 pandemic by using the following features:

1. biidc, ??, and ziid shocks alive in 2020Q1-Q2
2. One-period ahead anticipated shock for all the iid shocks alive in 2020Q1 (expected to hit in 2020Q2). Only the
    one-period ahead anticipated shock for the biidc shock is alive in 2020Q2 (expected to hit in 2020Q3).
    The anticipated shocks in 2020Q1 are assumed to be twice the size of
    the unanticipated shocks realized in 2020Q1. The anticipated biidc shock in 2020Q2 is assumed to be the same size of
    the unanticipated biidc shock realized in 2020Q2.
3. The standard deviation of monetary policy shocks are set to 10 times their value in the time periods before 2020Q1.

Confer with the official documentation about the COVID-19 shocks on the GitHub page.
"""
function ss61!(m::Model1002)
    # Set up regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30)))
    # if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
    #     m <= Setting(:model2para_regime, Dict{Symbol, Dict{Int, Int}}()) # initialize
    # end
    setup_regime_switching_inds!(m)

    # Default settings for flexible AIT rule
    if get_setting(m, :flexible_ait_policy_change)
        m <= Setting(:pgap_type, :flexible_ait)
        m <= Setting(:pgap_value, 0.)
        m <= Setting(:ygap_type, :flexible_ait)
        m <= Setting(:ygap_value, 12.)

        m <= Setting(:ait_Thalf, 10.)
        m <= Setting(:gdp_Thalf, 10.)
        m <= Setting(:flexible_ait_??_smooth, 0.)
        m <= Setting(:flexible_ait_??_??, 6.)
        m <= Setting(:flexible_ait_??_y, 6.)

        # Set up imperfect credibility of flexible AIT rule
        if !haskey(get_settings(m), :imperfect_credibility_weights)
            m <= Setting(:imperfect_credibility_weights, [1., 0.]) # default to perfect credibility
        end
        if !haskey(get_settings(m), :imperfect_credibility_historical_policy)
            m <= Setting(:imperfect_credibility_historical_policy, taylor_rule())
        end
    end

    # Allow the lower bound of non-COVID-19 parameters to equal zero
    m <= parameter(:??_g, 2.5230, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_g: The standard deviation of the government spending process.",
                   tex_label="\\sigma_{g}")

    m <= parameter(:??_b, 0.0292, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_b: The standard deviation of the intertemporal preference shifter process.",
                   tex_label="\\sigma_{b}")

    m <= parameter(:??_??, 0.4559, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??: The standard deviation of the exogenous marginal efficiency of investment shock process.",
                   tex_label="\\sigma_{\\mu}")

    m <= parameter(:??_ztil, 0.6742, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_ztil: The standard deviation of the process describing the stationary component of productivity.",
                   tex_label="\\sigma_{\\tilde{z}}")

    m <= parameter(:??_??_f, 0.1314, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_??_f: The mean of the process that generates the price elasticity of the composite good. Specifically, the elasticity is (1+??_{f,t})/(??_{f_t}).",
                   tex_label="\\sigma_{\\lambda_f}")

    m <= parameter(:??_??_w, 0.3864, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{\\lambda_w}")

    m <= parameter(:??_r_m, 0.2380, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_r_m: The standard deviation of the monetary policy shock.",
                   tex_label="\\sigma_{r^m}")

    m <= parameter(:??_??_??, 0.0428, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_??: The standard deviation of entrepreneurs' capital productivity follows an exogenous process with standard deviation ??_??_??.",
                   tex_label="\\sigma_{\\sigma_\\omega}")

    m <= parameter(:??_??_e, 0.0000, (0. ,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.05), fixed=false,
                   description="??_??_e: Exogenous bankrupcy costs follow an exogenous process with standard deviation ??_??_e.",
                   tex_label="\\sigma_{\\mu_e}")

    m <= parameter(:??_??, 0.0000, (0.,100.), (1e-5, 0.), ModelConstructors.Exponential(), RootInverseGamma(4, 0.01), fixed=false,
                   description="??_??: The fraction of entrepreneurs surviving period t follows an exogenous process with standard deviation ??_??.",
                   tex_label="\\sigma_{\\gamma}")

    m <= parameter(:??_??_star, 0.0269, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(6, 0.03), fixed=false,
                   description="??_??_star: The standard deviation of the inflation target.",
                   tex_label="\\sigma_{\\pi_*}")

    m <= parameter(:??_lr, 0.1766, (0.,10.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.75), fixed=false,
                   tex_label="\\sigma_{10y}")

    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    m <= parameter(:??_tfp, 0.9391, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{tfp}")

    m <= parameter(:??_gdpdef, 0.1575, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdpdef}")

    m <= parameter(:??_corepce, 0.0999, (0., 5.),(0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{pce}")

    m <= parameter(:??_gdp, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdp}")

    m <= parameter(:??_gdi, 0.1, (0., 5.),(0., 5.),ModelConstructors.Exponential(),RootInverseGamma(2, 0.10), fixed=false,
                   tex_label="\\sigma_{gdi}")

    # standard deviations of the anticipated policy shocks
    for i = 1:n_mon_anticipated_shocks(m)
        m <= parameter(Symbol("??_r_m$(i)"), .2, (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end
    for i = n_mon_anticipated_shocks(m) + 1:n_mon_anticipated_shocks_padding(m)
        m <= parameter(Symbol("??_r_m$(i)"), 0., (0., 100.), (1e-5, 0.), ModelConstructors.Exponential(),
                       RootInverseGamma(4, .2), fixed=false,
                       description="??_r_m$(i): Standard deviation of the $i-period-ahead anticipated policy shock.",
                       tex_label=@sprintf("\\sigma_{ant%d}",i))
    end

    # Define regimes for standard shocks
    for i in 1:4
        ModelConstructors.set_regime_val!(m[:??_g], i, m[:??_g].value)
        ModelConstructors.set_regime_val!(m[:??_b], i, m[:??_b].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_ztil], i, m[:??_ztil].value)
        ModelConstructors.set_regime_val!(m[:??_??_f], i, m[:??_??_f].value)
        ModelConstructors.set_regime_val!(m[:??_??_w], i, m[:??_??_w].value)
        ModelConstructors.set_regime_val!(m[:??_r_m], i, m[:??_r_m].value)
        ModelConstructors.set_regime_val!(m[:??_??_??], i, m[:??_??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_e], i, m[:??_??_e].value)
        ModelConstructors.set_regime_val!(m[:??_??], i, m[:??_??].value)
        ModelConstructors.set_regime_val!(m[:??_??_star], i, m[:??_??_star].value)
        ModelConstructors.set_regime_val!(m[:??_lr], i, m[:??_lr].value)
        ModelConstructors.set_regime_val!(m[:??_z_p], i, m[:??_z_p].value)
        ModelConstructors.set_regime_val!(m[:??_tfp], i, m[:??_tfp].value)
        err_adj = (i == 3) ? 10. : 1.
        ModelConstructors.set_regime_val!(m[:??_gdpdef], i, err_adj * m[:??_gdpdef].value)
        ModelConstructors.set_regime_val!(m[:??_corepce], i, err_adj * m[:??_corepce].value)
        ModelConstructors.set_regime_val!(m[:??_gdp], i, m[:??_gdp].value)
        ModelConstructors.set_regime_val!(m[:??_gdi], i, m[:??_gdi].value)

        for j = 1:DSGE.n_mon_anticipated_shocks(m)
            ModelConstructors.set_regime_val!(m[Symbol("??_r_m$(j)")], i, m[Symbol("??_r_m$(j)")].value)
        end
    end

    ModelConstructors.set_regime_val!(m[:??_r_m], 2, 10. * m[:??_r_m].value) # By default, we set these to 10 times their
    ModelConstructors.set_regime_val!(m[:??_r_m], 3, 10. * m[:??_r_m].value) # value in the pre-COVID and post-COVID regimes

    # Set up the COVID-19 shocks. We do not add anticipation by default
    ModelConstructors.set_regime_val!(m[:??_??], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??], 2, 400.) # initial value from literature, blown up by 100
    ModelConstructors.set_regime_val!(m[:??_??], 3, 400.)
    ModelConstructors.set_regime_val!(m[:??_??], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_??_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 2, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 3, 4.)
    ModelConstructors.set_regime_val!(m[:??_biidc], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 3, 1.)
    ModelConstructors.set_regime_val!(m[:??_biidc_prop], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 2, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 3, 5.)
    ModelConstructors.set_regime_val!(m[:??_ziid], 4, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 1, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 2, 2.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 3, 0.)
    ModelConstructors.set_regime_val!(m[:??_ziid_prop], 4, 0.)
end

"""
```
ss62!(m::Model1002)
```

models the COVID-19 pandemic by using the following features:

1. biidc, ??, and ziid shocks alive in 2020:Q1-Q4.
2. One-period ahead anticipated shocks for the iid shocks alive in 2020:Q1 and expected to hit in 2020:Q2.
     These shocks are assumed to be twice the size of the unanticipated shocks which are realized in 2020:Q1.
3. The standard deviation of the zp (permanent technology shock) is zero in 2020:Q1-Q2.
4. The prior on the standard deviation of other "business cycle" shocks in 2020:Q1-Q2 are centered around values which are
    0.25 times the prior in the time period before and after 2020:Q1-Q2.
5. The standard deviation of monetary policy shocks in 2020:Q1-Q2 are centered around values which are
    10 times the prior in the time period before and after 2020:Q1-Q2. However, the prior on the standard deviation
    for anticipated monetary policy shocks is the same before, during, and after 2020:Q1-Q2.
6. There are, in 2020:Q3-Q4, one-period ahead anticipated biidc shocks (drawn from their own distribution rather than
    specified as proportional to contemporaneous unanticipated shocks).
7. The standard deviation of Core PCE and GDP Deflator measurement error shocks in 2020:Q1-Q3
    are centered around values which are 10 times the prior in the time period
    before and after in 2020:Q1-Q3.
8. The Federal Reserve's commitment to a ZLB followed by a policy switch to
    Flexible Average Inflation Targeting is modeled as a temporary switch to a ZLB policy
    followed by a permanent switch to a monetary policy rule that targets average price
    and output gaps over time (but still includes monetary policy shocks).
9. The "parameter regimes" for the COVID shocks are treated separately from "model regimes".

Confer with the official documentation about the COVID-19 shocks on the GitHub page.
"""
function ss62!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)

    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Need to allow a zero value for sigma_z_p
    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Damp standard business cycle shocks
        m2p[:damp_standard_shocks] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
        for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
            m2p[:damp_standard_shocks][i] = 1
        end
        set_regime_val!(m[:damp_standard_shocks], 1, 1.)
        set_regime_val!(m[:damp_standard_shocks], 2, .25)

        set_regime_fixed!(m[:damp_standard_shocks], 1, true) # calibrated
        set_regime_fixed!(m[:damp_standard_shocks], 2, true)

        # Set ??_z_p
        m2p[:??_z_p] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
        for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
            m2p[:??_z_p][i] = 1
        end
        set_regime_val!(m[:??_z_p], 1, m[:??_z_p].value)
        set_regime_val!(m[:??_z_p], 2, 0.)

        set_regime_fixed!(m[:??_z_p], 1, false)
        set_regime_fixed!(m[:??_z_p], 2, true) # Fix ??_z_p = 0 in para regime 2

        # Amplify inflation measurement error and monetary policy shocks during COVID
        m2p[:amplify_??_r_m] = Dict(1 => 1, 2 => 2, 3 => 2)
        for i in 4:get_setting(m, :n_regimes)
            m2p[:amplify_??_r_m][i] = 1
        end
        set_regime_val!(m[:amplify_??_r_m], 1, 1.)
        set_regime_val!(m[:amplify_??_r_m], 2, 10.)

        set_regime_fixed!(m[:amplify_??_r_m], 1, true)
        set_regime_fixed!(m[:amplify_??_r_m], 2, true)

        m2p[:amplify_inflation_me] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2)
        for i in 5:get_setting(m, :n_regimes)
            m2p[:amplify_inflation_me][i] = 1
        end
        set_regime_val!(m[:amplify_inflation_me], 1, 1.)
        set_regime_val!(m[:amplify_inflation_me], 2, 10.)

        set_regime_fixed!(m[:amplify_inflation_me], 1, true)
        set_regime_fixed!(m[:amplify_inflation_me], 2, true)

        # The block of code below is kept as an example of how to
        # re-center priors if we want to estimate these damping/amplification factors
        #= # Re-center priors for parameter regime 2
        set_regime_prior!(m[pk], 1, get(m[pk].prior))
        newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
        newprior.?? = amplify_adj * newprior.??         # To recenter w/roughly same mean and proportionally smaller SD, we can just adjust ??
        set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))=#

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)

            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end

        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1

    if haskey(get_settings(m), :estimation_fixed_covid_shocks) && get_setting(m, :estimation_fixed_covid_shocks)
        if !get_settings(m)[:estimation_fixed_covid_shocks].print
            # Make sure a print statement will occur
            @warn "Setting :estimation_fixed_covid_shocks did not have print statements set to true. This will be automatically added"
            m <= Setting(:estimation_fixed_covid_shocks, true, true, "est_fixed_covid", "")
        end

        for pk in [:??_??, :??_ziid, :??_biidc, :??_biidc1, :??_??_prop, :??_ziid_prop, :??_biidc_prop]
            para_regs = unique(values(m2p[pk]))
            for reg in para_regs # Fix all regimes to initial calibration
                set_regime_fixed!(m[pk], reg, true)
            end
        end
    end
end

"""
```
ss63!(m::Model1002)
```

models the COVID-19 pandemic by using the following features:

1. biidc, ??, and ziid shocks alive in 2020:Q1-Q4.
2. One-period ahead anticipated shocks for the iid shocks alive in 2020:Q1 and expected to hit in 2020:Q2.
     These shocks are assumed to be twice the size of the unanticipated shocks which are realized in 2020:Q1.
3. The standard deviation of monetary policy shocks in 2020:Q1-Q2 are centered around values which are
    10 times the prior in the time period before and after 2020:Q1-Q2. However, the prior on the standard deviation
    for anticipated monetary policy shocks is the same before, during, and after 2020:Q1-Q2.
4. There are, in 2020:Q3-Q4, one-period ahead anticipated biidc shocks (drawn from their own distribution rather than
    specified as proportional to contemporaneous unanticipated shocks).
5. The standard deviation of Core PCE and GDP Deflator measurement error shocks in 2020:Q1-Q3
    are centered around values which are 10 times the prior in the time period
    before and after in 2020:Q1-Q3.
6. The Federal Reserve's commitment to a ZLB followed by a policy switch to
    Flexible Average Inflation Targeting is modeled as a temporary switch to a ZLB policy
    followed by a permanent switch to a monetary policy rule that targets average price
    and output gaps over time (but still includes monetary policy shocks).
7. The "parameter regimes" for the COVID shocks are treated separately from "model regimes".

Confer with the official documentation about the COVID-19 shocks on the GitHub page.
"""
function ss63!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)

    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # TODO: uncomment block below and remove the implementation where ??_r_m, ??_gdpdef, and ??_corepce
        # are regime-switching in 2nd regime rather than multiplied by an amplification/damping factor
#=        # Amplify inflation measurement error and monetary policy shocks during COVID
        m2p[:amplify_??_r_m] = Dict(1 => 1, 2 => 2, 3 => 2)
        for i in 4:get_setting(m, :n_regimes)
            m2p[:amplify_??_r_m][i] = 1
        end
        set_regime_val!(m[:amplify_??_r_m], 1, 1.)
        set_regime_val!(m[:amplify_??_r_m], 2, 10.)

        set_regime_fixed!(m[:amplify_??_r_m], 1, true)
        set_regime_fixed!(m[:amplify_??_r_m], 2, true)

        m2p[:amplify_inflation_me] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2)
        for i in 5:get_setting(m, :n_regimes)
            m2p[:amplify_inflation_me][i] = 1
        end
        set_regime_val!(m[:amplify_inflation_me], 1, 1.)
        set_regime_val!(m[:amplify_inflation_me], 2, 10.)

        set_regime_fixed!(m[:amplify_inflation_me], 1, true)
        set_regime_fixed!(m[:amplify_inflation_me], 2, true)=#

        # Inflation measurement errors and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = amplify_adj * newprior.??         # To recenter w/roughly same mean and proportionally smaller SD, we can just adjust ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)

            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end

        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1

    if haskey(get_settings(m), :estimation_fixed_covid_shocks) && get_setting(m, :estimation_fixed_covid_shocks)
        if !get_settings(m)[:estimation_fixed_covid_shocks].print
            # Make sure a print statement will occur
            @warn "Setting :estimation_fixed_covid_shocks did not have print statements set to true. This will be automatically added"
            m <= Setting(:estimation_fixed_covid_shocks, true, true, "est_fixed_covid", "")
        end

        # COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc, :??_biidc1, :??_??_prop, :??_ziid_prop, :??_biidc_prop]
            para_regs = unique(values(m2p[pk]))
            for reg in para_regs # Fix all regimes to initial calibration
                set_regime_fixed!(m[pk], reg, true)
            end
        end
    end
end

function ss64!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Need to allow a zero value for sigma_z_p
    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]

            # Allow zero for value bounds
            m[pk].valuebounds                = (0., m[pk].valuebounds[2])
            m[pk].transform_parameterization = (0., m[pk].transform_parameterization[2])

            # Set up m2p
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))
            m[pk].transform_parameterization = (m[pk].transform_parameterization[1],
                                                max(m[pk].transform_parameterization[2],
                                                    m[pk].transform_parameterization[2] * mode_adj * spread_adj))


            if pk == :??_z_p
                # Set value, fixed, and prior
                set_regime_val!(m[:??_z_p], 1, m[:??_z_p].value)
                set_regime_val!(m[:??_z_p], 2, 0.)

                # Fix ??_z_p = 0 in para regime 2
                set_regime_fixed!(m[:??_z_p], 1, false)
                set_regime_fixed!(m[:??_z_p], 2, true)
            else
                set_regime_val!(m[pk], 1, m[pk].value)
                set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

                # Re-center priors for parameter regime 2
                set_regime_prior!(m[pk], 1, get(m[pk].prior))
                newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
                newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
                newprior.?? = mode_adj * newprior.?? # ?? is the mode
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
            end
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss65!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss66!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_w, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p, :??_rm, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, m[pk].value)

            # Re-center priors for parameter regime 2, which are all BetaAlt, hence the parameters are ??, ??
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior))
            if isa(newprior, Beta)
                newprior_?? = 1. / (newprior.?? / newprior.?? + 1.)
                newprior_?? = sqrt((1. - newprior_??) * newprior_??^2 / (newprior.?? + newprior_??))
                newprior_?? *= spread_adj
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(ModelConstructors.BetaAlt(newprior_??, newprior_??)))
            else
                newprior = Normal(newprior.??, newprior.?? * spread_adj)
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
            end
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss67!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021,6,30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, true)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss68!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos


    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, true)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss69!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, true)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss70!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, true)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss71!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss72!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021,6,30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss73!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss74!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss75!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Allow persistence in COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Unfix persistence
            m[pk].fixed = false

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., 0.999)
            m[pk].transform_parameterization = (0., 0.999)

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, .1) # center at 0.1
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            m[pk].prior = ModelConstructors.NullablePriorUnivariate(BetaAlt(0.1, 0.2))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end

        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss76!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021,6,30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Allow persistence in COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Unfix persistence
            m[pk].fixed = false

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., 0.999)
            m[pk].transform_parameterization = (0., 0.999)

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, .1) # center at 0.1
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            m[pk].prior = ModelConstructors.NullablePriorUnivariate(BetaAlt(0.1, 0.2))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss77!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Allow persistence in COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Unfix persistence
            m[pk].fixed = false

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., 0.999)
            m[pk].transform_parameterization = (0., 0.999)

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, .1) # center at 0.1
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            m[pk].prior = ModelConstructors.NullablePriorUnivariate(BetaAlt(0.1, 0.2))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss78!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid,
                   :??_gdpvar_covid, :??_z_p_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Allow persistence in COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Unfix persistence
            m[pk].fixed = false

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., 0.999)
            m[pk].transform_parameterization = (0., 0.999)

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, .1) # center at 0.1
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            m[pk].prior = ModelConstructors.NullablePriorUnivariate(BetaAlt(0.1, 0.2))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss79!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Need to allow a zero value for sigma_z_p
    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]

            # Allow zero for value bounds
            m[pk].valuebounds                = (0., m[pk].valuebounds[2])
            m[pk].transform_parameterization = (0., m[pk].transform_parameterization[2])

            # Set up m2p
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))
            m[pk].transform_parameterization = (m[pk].transform_parameterization[1],
                                                max(m[pk].transform_parameterization[2],
                                                    m[pk].transform_parameterization[2] * mode_adj * spread_adj))


            if pk == :??_z_p
                # Set value, fixed, and prior
                set_regime_val!(m[:??_z_p], 1, m[:??_z_p].value)
                set_regime_val!(m[:??_z_p], 2, 0.)

                # Fix ??_z_p = 0 in para regime 2
                set_regime_fixed!(m[:??_z_p], 1, false)
                set_regime_fixed!(m[:??_z_p], 2, true)
            else
                set_regime_val!(m[pk], 1, m[pk].value)
                set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

                # Re-center priors for parameter regime 2
                set_regime_prior!(m[pk], 1, get(m[pk].prior))
                newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
                newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
                newprior.?? = mode_adj * newprior.?? # ?? is the mode
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
            end
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2, 2020:Q3-Q4 to para regime 3
            # OTHERWISE, ss79 is identical to ss64
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 3, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

# ss67 but also kills b, ziid, z_p, and ??_w during the second regime
function ss80!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31), 7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # Standard business cycle shocks that have a COVID-specific counterpart, plus z_p
        for pk in [:??_g, :??_??, :??_??_f, :??_??_??, :??_lr, :??_tfp, :??_gdp, :??_gdi, :??_b, :??_ztil, :??_z_p, :??_??_w]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Allow zero in the valuebounds
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, false)
            set_regime_fixed!(m[pk], 2, true)
        end

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 0.)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, true)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss81!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2, 2020:Q3-Q4 to para regime 3
            # OTHERWISE, ss81 is identical to ss65
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 3, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss82!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2, 2020:Q3-Q4 to para regime 3
            # OTHERWISE, ss82 is identical to ss72
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 3, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss83!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Adjustment factors for priors
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.

        # COVID counterpart for standard business cycle shocks
        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_??_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj and to allow a zero value
            m[pk].valuebounds = (0., max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
            newprior.?? = mode_adj * newprior.?? # ?? is the mode
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [:??_g_covid, :??_??_covid, :??_??_f_covid, :??_??_w_covid,
                   :??_lr_covid, :??_tfp_covid, :??_gdp_covid, :??_gdi_covid, :??_gdpvar_covid]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., m[pk].valuebounds[2])

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, m[pk].value)
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2, 2020:Q3-Q4 to para regime 3
            # OTHERWISE, ss83 is identical to ss76
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 3, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, m[:??_??].prior)
                set_regime_prior!(m[:??_biidc], i, m[:??_biidc].prior)
                set_regime_prior!(m[:??_ziid], i, m[:??_ziid].prior)
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2 * (40.)^2 / 40., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(8.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(10.0, 0.0501))
        end

        # Allow persistence in COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Unfix persistence
            m[pk].fixed = false

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (0., 0.999)
            m[pk].transform_parameterization = (0., 0.999)

            # Set value, fixed, and prior
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, .1) # center at 0.1
            set_regime_fixed!(m[pk], 1, true) # these shocks don't apply outside of COVID times
            set_regime_fixed!(m[pk], 2, false)

            m[pk].prior = ModelConstructors.NullablePriorUnivariate(BetaAlt(0.1, 0.2))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss84!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Need to allow a zero value for sigma_z_p
    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]

            # Allow zero for value bounds
            m[pk].valuebounds                = (0., m[pk].valuebounds[2])
            m[pk].transform_parameterization = (0., m[pk].transform_parameterization[2])

            # Set up m2p
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))
            m[pk].transform_parameterization = (m[pk].transform_parameterization[1],
                                                max(m[pk].transform_parameterization[2],
                                                    m[pk].transform_parameterization[2] * mode_adj * spread_adj))


            if pk == :??_z_p
                # Set value, fixed, and prior
                set_regime_val!(m[:??_z_p], 1, m[:??_z_p].value)
                set_regime_val!(m[:??_z_p], 2, 0.)

                # Fix ??_z_p = 0 in para regime 2
                set_regime_fixed!(m[:??_z_p], 1, false)
                set_regime_fixed!(m[:??_z_p], 2, true)
            else
                set_regime_val!(m[pk], 1, m[pk].value)
                set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

                # Re-center priors for parameter regime 2
                set_regime_prior!(m[pk], 1, get(m[pk].prior))
                newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
                newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
                newprior.?? = mode_adj * newprior.?? # ?? is the mode
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
            end
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, RootInverseGamma(2., get(m[:??_??].prior).??))
                set_regime_prior!(m[:??_biidc], i, RootInverseGamma(2., get(m[:??_biidc].prior).??))
                set_regime_prior!(m[:??_ziid], i, RootInverseGamma(2., get(m[:??_ziid].prior).??))
            end
            set_regime_prior!(m[:??_??], 3, RootInverseGamma(2., sqrt(4.)^2))
            set_regime_prior!(m[:??_biidc], 3, RootInverseGamma(2.0, 0.0401248))
            set_regime_prior!(m[:??_ziid], 3, RootInverseGamma(2.0, 0.0501))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss85!(m::Model1002)
    ss9!(m) # fix ??_gdi, ??_gdi; also add Iskander's changes and change bounds on rhos

    ## Set up model regime-switching
    m <= Setting(:regime_switching, true)
    m <= Setting(:regime_dates, Dict{Int, Date}(1 => date_presample_start(m), 2 => Date(2020, 3, 31),
                                                3 => Date(2020, 6, 30), 4 => Date(2020, 9, 30),
                                                5 => Date(2020, 12, 31), 6 => Date(2021, 3, 31),
                                                7 => Date(2021, 6, 30)))
    m <= Setting(:time_varying_trends, true)
    setup_regime_switching_inds!(m)

    ## Default settings for flexible AIT rule
    m <= Setting(:pgap_type, :flexible_ait)
    m <= Setting(:pgap_value, 0.)
    m <= Setting(:ygap_type, :flexible_ait)
    m <= Setting(:ygap_value, 12.)

    m <= Setting(:ait_Thalf, 10.)
    m <= Setting(:gdp_Thalf, 10.)
    m <= Setting(:flexible_ait_??_smooth, 0.)
    m <= Setting(:flexible_ait_??_??, 6.)
    m <= Setting(:flexible_ait_??_y, 6.)
    # TODO: Set up with temporary ZLB + flexible AIT rule and imperfect awareness

    ## Set up regime-switching parameters

    # Need to allow a zero value for sigma_z_p
    m <= parameter(:??_z_p, 0.1662, (0., 5.), (0., 5.), ModelConstructors.Exponential(), RootInverseGamma(2, 0.10), fixed=false,
                   description="??_z_p: The standard deviation of the shock to the permanent component of productivity.",
                   tex_label="\\sigma_{z^p}")

    # Populate model2para_regime if it wasn't passed as a custom_setting
    if !haskey(get_settings(m), :model2para_regime) # check if it was set by custom_settings already
        m2p = Dict{Symbol, Dict{Int, Int}}() # initialize model2para_regime dict

        # Standard business cycle shocks
        mode_adj = haskey(get_settings(m), :standard_shocks_mode_adjust) ? get_setting(m, :standard_shocks_mode_adjust) : 1.
        spread_adj = haskey(get_settings(m), :standard_shocks_spread_adjust) ? get_setting(m, :standard_shocks_spread_adjust) : 1.
        for pk in [:??_g, :??_b, :??_??, :??_ztil, :??_??_f, :??_??_w,
                   :??_??_??, :??_??_e, :??_??, :??_??_star, :??_lr, :??_tfp,
                   :??_gdp, :??_gdi, :??_z_p]

            # Allow zero for value bounds
            m[pk].valuebounds                = (0., m[pk].valuebounds[2])
            m[pk].transform_parameterization = (0., m[pk].transform_parameterization[2])

            # Set up m2p
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Update valuebounds based on the mode_adj, spread_adj
            m[pk].valuebounds = (m[pk].valuebounds[1], max(m[pk].valuebounds[end], m[pk].valuebounds[end] * mode_adj * spread_adj))
            m[pk].transform_parameterization = (m[pk].transform_parameterization[1],
                                                max(m[pk].transform_parameterization[2],
                                                    m[pk].transform_parameterization[2] * mode_adj * spread_adj))


            if pk == :??_z_p
                # Set value, fixed, and prior
                set_regime_val!(m[:??_z_p], 1, m[:??_z_p].value)
                set_regime_val!(m[:??_z_p], 2, 0.)

                # Fix ??_z_p = 0 in para regime 2
                set_regime_fixed!(m[:??_z_p], 1, false)
                set_regime_fixed!(m[:??_z_p], 2, true)
            else
                set_regime_val!(m[pk], 1, m[pk].value)
                set_regime_val!(m[pk], 2, mode_adj .* m[pk].value)

                # Re-center priors for parameter regime 2
                set_regime_prior!(m[pk], 1, get(m[pk].prior))
                newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
                newprior.?? = newprior.?? / spread_adj # smaller ?? implies larger spread
                newprior.?? = mode_adj * newprior.?? # ?? is the mode
                set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
            end
        end

        # Adjust inflation measurement error and monetary policy shocks
        amplify_adj = 10.
        for pk in [:??_r_m, :??_gdpdef, :??_corepce]
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q2 to para regime 2
            m2p[pk][4] = pk == :??_r_m ? 1 : 2      # inflation measurement error is still high in 2020:Q3
            for i in 5:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1 TODO: check if we want regime 1 or 3
                m2p[pk][i] = 1
            end

            # Set values
            set_regime_val!(m[pk], 1, m[pk].value)
            set_regime_val!(m[pk], 2, amplify_adj .* m[pk].value)

            # Re-center priors for parameter regime 2
            set_regime_prior!(m[pk], 1, get(m[pk].prior))
            newprior = deepcopy(get(m[pk].prior)) # all ??'s have RootInverseGamma priors where ?? is mode and ?? dof.
            newprior.?? = newprior.?? * amplify_adj # To recenter, we just need to adjust mode ??
            set_regime_prior!(m[pk], 2, ModelConstructors.NullablePriorUnivariate(newprior))
        end

        for pk in [Symbol("??_r_m$i") for i in 1:n_mon_anticipated_shocks(m)]
            # standard deviations should be the same across regimes, so do nothing
        end

        # Contemporaneous COVID-19 shocks
        for pk in [:??_??, :??_ziid, :??_biidc]
            # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1-Q3 to para regime 2, 2020:Q4 to para regime 3
            m2p[pk] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            if pk == :??_??
                set_regime_val!(m[pk], 2, 400.)
                set_regime_val!(m[pk], 3, 4.)
            elseif pk == :??_ziid
                set_regime_val!(m[pk], 2, 5.)
                set_regime_val!(m[pk], 3, .05)
            else
                set_regime_val!(m[pk], 2, 4.)
                set_regime_val!(m[pk], 3, .04)
            end

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)
            set_regime_fixed!(m[pk], 3, false)
            # Regime-switching priors for regime 3
            for i in 1:2
                set_regime_prior!(m[:??_??], i, Uniform(0., 600.))
                set_regime_prior!(m[:??_biidc], i, Uniform(0., 10.))
                set_regime_prior!(m[:??_ziid], i, Uniform(0., 10.))
            end
            set_regime_prior!(m[:??_??], 3, Uniform(0., 6.))
            set_regime_prior!(m[:??_biidc], 3, Uniform(0., 1.))
            set_regime_prior!(m[:??_ziid], 3, Uniform(0., 1.))
        end

        # Anticipated shocks proportional to today's contemporaneous shock
        for pk in [:??_??_prop, :??_ziid_prop, :??_biidc_prop]
            m2p[pk] = Dict(1 => 1, 2 => 2) # map 1959:Q3-2019:Q4 to parameter regime 1, 2020:Q1 to para regime 2
            for i in 3:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 2.)

            # Fix both shocks
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Anticipated contemporaneous shock
        for pk in [:??_biidc1]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2) # map 1959:Q3-2020:Q2 to parameter regime 1, 2020:Q3-Q4 to para regime 2
            for i in 6:get_setting(m, :n_regimes)  # map 2021:Q1 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 4.)

            # Fix shocks to 0 in para regime 1
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, false)

            # Update valuebounds
            set_regime_valuebounds!(m[pk], 2, (0., 1e2))
            m[pk].transform_parameterization = (0., 1e2)

            # Set prior
            m[pk].prior = regime_prior(m[:??_biidc], 1)
        end
        # pgap and ygap initialization shocks
        for pk in [:??_pgap, :??_ygap]
            m2p[pk] = Dict(1 => 1, 2 => 1, 3 => 2) # map 1959:Q3-2020:Q1 to parameter regime 1, 2020:Q2 to para regime 2
            for i in 4:get_setting(m, :n_regimes)  # map 2020:Q3 onward to para regime 1
                m2p[pk][i] = 1
            end

            # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
            set_regime_val!(m[pk], 1, 0.)
            set_regime_val!(m[pk], 2, 20.)

            # Fix shocks to their calibrated values
            set_regime_fixed!(m[pk], 1, true)
            set_regime_fixed!(m[pk], 2, true)
        end

        # Turn some shocks to be fixed to avoid issues
        for pk in [:??_??1, :??_ziid1]
            m[pk].value = 0.
            m[pk].fixed = true
        end

        # Flexible AIT shocks (to initialize the pgap and ygap values)
        m <= Setting(:model2para_regime, m2p)
    end

    ModelConstructors.toggle_regime!(m.parameters, 1) # ensure that regimes are toggled to regime 1
end

function ss86!(m)
    ss64!(m)
#=
    m <= parameter(:??_??_f_iid, 0.0, (0., 100.), (0., 100.), ModelConstructors.Exponential(), RootInverseGamma(10.0, sqrt(25.1)),
                   fixed=false,
                   description="??_??_f_iid: The standard deviation of the shock to the price markup.",
                   tex_label="\\sigma_{\\lambda_f, iid}")
=#
    get_setting(m, :model2para_regime)[:??_??_f_iid] = Dict(1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3)
    for i in 6:get_setting(m, :n_regimes)
        get_setting(m, :model2para_regime)[:??_??_f_iid][i] = 1
    end

    # Set values (priors are set already unless regime-switching is desired in 2020:Q4)
    set_regime_val!(m[:??_??_f_iid], 1, 0.)
    set_regime_val!(m[:??_??_f_iid], 2, 5.0)
    set_regime_val!(m[:??_??_f_iid], 3, 0.05)

    # Fix shocks to 0 in para regime 1
    set_regime_fixed!(m[:??_??_f_iid], 1, true)
    set_regime_fixed!(m[:??_??_f_iid], 2, false)
    set_regime_fixed!(m[:??_??_f_iid], 3, false)

    # Regime-switching priors for regime 3
    for i in 1:2
        set_regime_prior!(m[:??_??_f_iid], i, m[:??_??_f_iid].prior)
    end
    set_regime_prior!(m[:??_??_f_iid], 3, RootInverseGamma(10.0, 0.0501))
end
