"""
```
standard_spec!(m, vint, directory_path; cdvt = vint,
    dsid = data_id(m), cdid = cond_id(m), fcast-date = Dates.lastdayofquarter(Dates.today()),
    fcast_end = DSGE.quartertodate("2030-Q1"))
```
adds the standard settings to the model object `m` for
the Brookings Phillips Curve project.
"""
function standard_spec!(m::AbstractDSGEModel, vint::String,
                        directory_path::String = dirname(@__FILE__); cdvt::String = vint,
                        dsid::Int = data_id(m),
                        cdid::Int = cond_id(m),
                        fcast_date::Dates.Date = Dates.lastdayofquarter(Dates.today()),
                        fcast_end::Date = DSGE.quartertodate("2024-Q4"),
                        four_folders_down::Bool = false,
                        save_orig::Bool = false)
    m <= Setting(:data_vintage, vint)
    if four_folders_down
        m <= Setting(:saveroot, joinpath(directory_path, "../../../../save/"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../../save/input_data"))
    else
        m <= Setting(:saveroot, joinpath(directory_path, "../../../save/"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../save/input_data"))
    end
    if save_orig
        if four_folders_down
            m <= Setting(:saveroot, joinpath(directory_path, "../../../../save_orig/"))
            m <= Setting(:dataroot, joinpath(directory_path, "../../../../save/input_data"))
        else
            m <= Setting(:saveroot, joinpath(directory_path, "../../../save_orig/"))
            m <= Setting(:dataroot, joinpath(directory_path, "../../../save/input_data"))
        end
    end
    m <= Setting(:data_id, dsid)
    m <= Setting(:cond_id, cdid)
    m <= Setting(:hours_first_observable, true)

    m <= Setting(:cond_vintage, cdvt)
    m <= Setting(:date_forecast_start,  fcast_date)
    m <= Setting(:forecast_horizons, subtract_quarters(fcast_end, fcast_date) + 1)
    m <= Setting(:impulse_response_horizons, 20)
    m <= Setting(:date_conditional_end, fcast_date)
    m <= Setting(:use_population_forecast, true)
    m <= Setting(:forecast_uncertainty_override, Nullable{Bool}(false))

    m <= Setting(:sampling_method, :SMC)
    m <= Setting(:forecast_block_size, 500)
    m <= Setting(:forecast_jstep, 1)

    if cdid == 1
        m <= Setting(:cond_semi_names, [])
        m <= Setting(:cond_full_names, [:obs_hours])
    end
end

function standard_spec200129!(m::AbstractDSGEModel, vint::String,
                        directory_path::String = dirname(@__FILE__); cdvt::String = vint,
                        dsid::Int = data_id(m),
                        cdid::Int = cond_id(m),
                        fcast_date::Dates.Date = Dates.lastdayofquarter(Dates.today()),
                        fcast_end::Date = DSGE.quartertodate("2024-Q4"),
                        four_folders_down::Bool = false)
    m <= Setting(:data_vintage, vint)
    if four_folders_down
        m <= Setting(:saveroot, joinpath(directory_path, "../../../../save/200129"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../../save/input_data"))
    else
        m <= Setting(:saveroot, joinpath(directory_path, "../../../save/200129"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../save/input_data"))
    end
    m <= Setting(:data_id, dsid)
    m <= Setting(:cond_id, cdid)
    m <= Setting(:hours_first_observable, true)

    m <= Setting(:cond_vintage, cdvt)
    m <= Setting(:date_forecast_start,  fcast_date)
    m <= Setting(:forecast_horizons, subtract_quarters(fcast_end, fcast_date) + 1)
    m <= Setting(:impulse_response_horizons, 20)
    m <= Setting(:date_conditional_end, fcast_date)
    m <= Setting(:use_population_forecast, true)
    m <= Setting(:forecast_uncertainty_override, Nullable{Bool}(false))

    m <= Setting(:sampling_method, :SMC)
    m <= Setting(:forecast_block_size, 500)
    m <= Setting(:forecast_jstep, 1)

    m <= Setting(:date_regime2_start_text, "900331", true, "reg2start",
                 "The text version to be saved of when regime 2 starts")
    m <= Setting(:preZLB, "false", true, "preZLB", "")

    if cdid == 1
        m <= Setting(:cond_semi_names, [])
        m <= Setting(:cond_full_names, [:obs_hours])
    end
end

function standard_spec200204_dsgevar!(m::AbstractDSGEModel, vint::String,
                        directory_path::String = dirname(@__FILE__); cdvt::String = vint,
                        dsid::Int = data_id(m),
                        cdid::Int = cond_id(m),
                        fcast_date::Dates.Date = Dates.lastdayofquarter(Dates.today()),
                        fcast_end::Date = DSGE.quartertodate("2024-Q4"),
                        four_folders_down::Bool = false)
    m <= Setting(:data_vintage, vint)
    if four_folders_down
        m <= Setting(:saveroot, joinpath(directory_path, "../../../../save/"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../../save/input_data"))
    else
        m <= Setting(:saveroot, joinpath(directory_path, "../../../save/"))
        m <= Setting(:dataroot, joinpath(directory_path, "../../../save/input_data"))
    end
    m <= Setting(:data_id, dsid)
    m <= Setting(:cond_id, cdid)
    m <= Setting(:hours_first_observable, false)

    m <= Setting(:cond_vintage, cdvt)
    m <= Setting(:date_forecast_start,  fcast_date)
    m <= Setting(:forecast_horizons, subtract_quarters(fcast_end, fcast_date) + 1)
    m <= Setting(:impulse_response_horizons, 20)
    m <= Setting(:date_conditional_end, fcast_date)
    m <= Setting(:use_population_forecast, false)
    m <= Setting(:forecast_uncertainty_override, Nullable{Bool}(false))

    m <= Setting(:sampling_method, :SMC)
    m <= Setting(:forecast_block_size, 500)
    m <= Setting(:forecast_jstep, 1)

    m <= Setting(:date_regime2_start_text, "900331", true, "reg2start",
                 "The text version to be saved of when regime 2 starts")
    m <= Setting(:preZLB, "false", true, "preZLB", "")
    m <= Setting(:dsgevar, "true", true, "dsgevar", "indicates output from DSGEVAR estimation")
end

"""
```
get_??p(m::AbstractDSGEModel, ??::Matrix{Float64})
```
computes the slope of the price Phillips curve, given a
`n_draws ?? n_parameters` matrix.
"""
function get_??p(m::AbstractDSGEModel, ??::Matrix{Float64})
    ?? = Vector{Float64}(undef, size(??, 1))
    for i = 1:size(??, 1)
        ??[i] = get_??p(m, ??[i, :])
    end
    return ??
end

function get_??p(m::AbstractDSGEModel, ??::Vector{Float64})
    DSGE.update!(m, ??)
    return ((1 - m[:??_p]*m[:??]*exp((1 - m[:??_c])*m[:z_star]))*
            (1 - m[:??_p]))/(m[:??_p]*((m[:??]- 1)*m[:??_p] + 1))/(1 + m[:??_p]*m[:??]*exp((1 - m[:??_c])*m[:z_star]))
end

"""
```
get_??w(m::AbstractDSGEModel, ??::Matrix{Float64})
```
computes the slope of the wage Phillips curve, given a
`n_draws ?? n_parameters` matrix.
"""
function get_??w(m::AbstractDSGEModel, ??::Matrix{Float64})
    ?? = Vector{Float64}(undef, size(??, 1))
    for i = 1:size(??, 1)
        ??[i] = get_??w(m, ??[i, :])
    end
    return ??
end

function get_??w(m::AbstractDSGEModel, ??::Vector{Float64})
    DSGE.update!(m, ??)
    return (1 - m[:??_w]*m[:??]*exp((1 - m[:??_c])*m[:z_star]))*
    (1 - m[:??_w])/(m[:??_w]*((m[:??_w] - 1)*m[:??_w] + 1))/(1 + m[:??]*exp((1 - m[:??_c])*m[:z_star]))
end

"""
```
draw_??(m::AbstractDSGEModel; N::Int = 100000,
       kernel_density::Bool = true) where {S <: Real}
```
draws from the implied prior for ??p and ??w, given priors
for the parameters which specify these slopes (e.g. ??_p).
"""
function draw_??(m::AbstractDSGEModel; N::Int = 100000,
                kernel_density::Bool = true) where {S <: Real}
    paras = zeros(N, length(m.parameters))
    for i = 1:N
        success = false
        while !success
            try
                paras[i, :] = rand(m.parameters, 1)
            catch e
                continue
            end
            success = true
        end
    end
    ??p = get_??p(m, paras)
    ??w = get_??w(m, paras)

    if kernel_density
        kdep = kde(??p)
        kdew = kde(??w)

        return kdep, kdew
    else

        return ??p, ??w
    end
end
