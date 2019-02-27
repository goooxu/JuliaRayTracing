const AbstractVec = SVector{3, T} where T <: AbstractFloat
const Vec = AbstractVec{Float64}

function normalize(v::AbstractVec)::AbstractVec
    v / norm(v)
end

@inline function x(v::AbstractVec)::AbstractFloat
    v[1]
end

@inline function y(v::AbstractVec)::AbstractFloat
    v[2]
end

@inline function z(v::AbstractVec)::AbstractFloat
    v[3]
end

function random_on_unit_disk()::AbstractVec
    v::AbstractVec = Vec(randn(), randn(), 0.0)
    normalize(v)
end

function random_in_unit_disk()::AbstractVec
    v::AbstractVec = random_on_unit_disk()
    r::AbstractFloat = rand()
    sqrt(r) * v
end

function random_on_unit_sphere()::AbstractVec
    v::AbstractVec = Vec(randn(), randn(), randn())
    normalize(v)
end

function random_in_unit_sphere()::AbstractVec
    v::AbstractVec = random_on_unit_disk()
    r::AbstractFloat = rand()
    cbrt(r) * v
end

function reflect(v::AbstractVec, n::AbstractVec)::AbstractVec
    v::AbstractVec = normalize(v)
    v - 2dot(v, n)n
end

function refract(v::AbstractVec, n::AbstractVec, index::AbstractFloat)::Tuple{Bool, Union{Nothing, AbstractVec}}
    v::AbstractVec = normalize(v)
    dt::AbstractFloat = dot(v, n)
    discriminant::AbstractFloat = 1.0 - index^2 * (1.0 - dt^2)
    if discriminant > 0
        refracted::AbstractVec = index * (v - n * dt) - n * sqrt(discriminant)
        true, refracted
    end
    false, nothing
end
