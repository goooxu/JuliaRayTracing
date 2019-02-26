using StaticArrays
using LinearAlgebra
include("vector.jl")

function random_on_unit_sphere_1()
    v = Vec(2rand() - 1.0, 2rand() - 1.0, 2rand() - 1.0)
    normalize(v)
end

function random_on_unit_sphere_2()
    Θ = (2rand() - 1.0) * 2π
    ϕ = (2rand() - 1.0) * π - π/2
    Vec(sin(ϕ) * sin(Θ), cos(ϕ) * sin(Θ), cos(Θ))
end

function random_on_unit_sphere_3()
    v = Vec(randn(), randn(), randn())
    normalize(v)
end

function random_in_unit_sphere_1()
    v = random_on_unit_sphere_3()
    r = rand()
    r * v
end

function random_in_unit_sphere_2()
    v = random_on_unit_sphere_3()
    r = rand()
    cbrt(r) * v
end

function random_in_unit_sphere_3()
    local v
    while true
        v = Vec(2rand() - 1.0, 2rand() - 1.0, 2rand() - 1.0)
        if dot(v, v) < 1.0
            break
        end
    end
    v
end

println(random_on_unit_sphere_1())
println(random_on_unit_sphere_2())
println(random_on_unit_sphere_3())
println(random_in_unit_sphere_1())
println(random_in_unit_sphere_2())
println(random_in_unit_sphere_3())