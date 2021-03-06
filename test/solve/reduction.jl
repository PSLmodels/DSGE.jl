using DSGE, JLD2, DataStructures
import Test: @test, @testset
import DSGE: @test_matrix_approx_eq

m = KrusellSmith()

# Load pre-reduced canonical form matrices
g1 = load("../../test_outputs/solve/canonical.jld2", "g1")
g0 = load("../../test_outputs/solve/canonical.jld2", "g0")
psi = load("../../test_outputs/solve/canonical.jld2", "psi")
pi = load("../../test_outputs/solve/canonical.jld2", "pi")
c = load("../../test_outputs/solve/canonical.jld2", "c")

# Load reduced canonical form matrices
g1_kry = load("../../test_outputs/solve/canonical_kry.jld2", "g1")
g0_kry = load("../../test_outputs/solve/canonical_kry.jld2", "g0")
psi_kry = load("../../test_outputs/solve/canonical_kry.jld2", "psi")
pi_kry = load("../../test_outputs/solve/canonical_kry.jld2", "pi")
c_kry = load("../../test_outputs/solve/canonical_kry.jld2", "c")

# Load Krylov + spline reduced canonical form matrices
g1_spl = load("../../test_outputs/solve/canonical_spl.jld2", "g1")
g0_spl = load("../../test_outputs/solve/canonical_spl.jld2", "g0")
psi_spl = load("../../test_outputs/solve/canonical_spl.jld2", "psi")
pi_spl = load("../../test_outputs/solve/canonical_spl.jld2", "pi")
c_spl = load("../../test_outputs/solve/canonical_spl.jld2", "c")

# Update model
update!(m.settings[:I], Setting(:I, 100))
update!(m.settings[:amin], Setting(:amin, 0.))
update!(m.settings[:amax], Setting(:amax, 100.))
update!(m.settings[:a], Setting(:a, collect(linspace(0., 100., 100))))
update!(m.settings[:da], Setting(:da, 100./(100 - 1)))
update!(m.settings[:aaa], Setting(:aaa, reshape(get_setting(m, :aa), 2 * 100, 1)))
update!(m.settings[:J], Setting(:J, 2))
update!(m.settings[:z], Setting(:z, [0., 1.]))
update!(m.settings[:dz], Setting(:dz, 1.))
update!(m.settings[:zz], Setting(:zz, ones(100, 1) * get_setting(m, :z)'))
update!(m.settings[:zzz], Setting(:zzz, reshape(get_setting(m, :zz), 2 * 100, 1)))
update!(m.settings[:n_jump_vars], Setting(:n_jump_vars, 200))
update!(m.settings[:n_state_vars], Setting(:n_state_vars, 199 + 1))
update!(m.settings[:n_state_vars_unreduce], Setting(:n_state_vars_unreduce, 0))
update!(m.settings[:reduce_state_vars], Setting(:reduce_state_vars, true))
update!(m.settings[:reduce_v], Setting(:reduce_v, true))
update!(m.settings[:krylov_dim], Setting(:krylov_dim, 5))
update!(m.settings[:n_knots], Setting(:n_knots, 12))
update!(m.settings[:c_power], Setting(:c_power, 7))
update!(m.settings[:knots_dict], Setting(:knots_dict, Dict(1 => collect(linspace(get_setting(m, :amin), get_setting(m, :amax), 12 - 1)))))
update!(m.settings[:spline_grid], Setting(:spline_grid, get_setting(m, :a)))
update!(m.settings[:n_prior], Setting(:n_prior, 1))
update!(m.settings[:n_post], Setting(:n_post, 2))
update!(m.settings[:F], Setting(:F, identity))

# Test non-sparse methods
??0, ??1, ??, ??, C, ~, ~ = krylov_reduction(m, full(g0), full(g1), full(psi), full(pi), full(c))
@testset "Krylov Reduction (non-sparse)" begin
    @test @test_matrix_approx_eq full(g1_kry) ??1
    @test @test_matrix_approx_eq full(g0_kry) ??0
    @test vec(full(psi_kry)) ??? vec(full(??)) # allow machine error
    @test vec(full(pi_kry)) ??? vec(full(??))
    @test vec(full(c_kry)) ??? vec(full(C))
end

??0, ??1, ??, ??, C, ~, ~ = valuef_reduction(m, full(g0_kry), full(g1_kry), full(psi_kry), full(pi_kry), full(c_kry))
@testset "Value Function Reduction via Spline Basis (non-sparse)" begin
    @test @test_matrix_approx_eq full(g1_spl) ??1
    @test @test_matrix_approx_eq full(g0_spl) ??0
    @test vec(full(psi_spl)) ??? vec(full(??))
    @test vec(full(pi_spl)) ??? vec(full(??))
    @test vec(full(c_spl)) ??? vec(full(C))
end

# Test sparse methods
??0, ??1, ??, ??, C, ~, ~ = krylov_reduction(m, sparse(g0), sparse(g1), sparse(psi), sparse(pi), sparse(c))
@testset "Krylov Reduction (sparse)" begin
    @test typeof(??1) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??0) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??) == SparseMatrixCSC{Float64,Int64}
    @test typeof(C) == SparseMatrixCSC{Float64,Int64}
    @test @test_matrix_approx_eq full(g1_kry) full(??1)
    @test @test_matrix_approx_eq full(g0_kry) full(??0)
    @test vec(full(psi_kry)) ??? vec(full(??)) # allow machine error
    @test vec(full(pi_kry)) ??? vec(full(??))
    @test vec(full(c_kry)) ??? vec(full(C))
end

??0, ??1, ??, ??, C, ~, ~ = valuef_reduction(m, sparse(g0_kry), sparse(g1_kry), sparse(psi_kry),
                                         sparse(pi_kry), sparse(c_kry))
@testset "Value Function Reduction via Spline Basis (sparse)" begin
    @test typeof(??1) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??0) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??) == SparseMatrixCSC{Float64,Int64}
    @test typeof(??) == SparseMatrixCSC{Float64,Int64}
    @test typeof(C) == SparseMatrixCSC{Float64,Int64}
    @test @test_matrix_approx_eq full(g1_spl) full(??1)
    @test @test_matrix_approx_eq full(g0_spl) full(??0)
    @test vec(full(psi_spl)) ??? vec(full(??))
    @test vec(full(pi_spl)) ??? vec(full(??))
    @test vec(full(c_spl)) ??? vec(full(C))
end
