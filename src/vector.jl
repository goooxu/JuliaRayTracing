const AbstractVec = SVector{3, T} where T <: AbstractFloat
const Vec = AbstractVec{Float64}

function normalize(v::AbstractVec)
    v / norm(v)
end

@inline function x(v::AbstractVec)
    v[1]
end

@inline function y(v::AbstractVec)
    v[2]
end

@inline function z(v::AbstractVec)
    v[3]
end

function random_in_unit_disk()
    while true
        v::AbstractVec = Vec(2.0 * rand() - 1.0, 2.0 * rand() - 1.0, 0.0);
        if dot(v, v) < 1.0
            return v
        end
    end
end

function random_in_unit_sphere()
    while true
        v::AbstractVec = Vec(2.0 * rand() - 1.0, 2.0 * rand() - 1.0, 2.0 * rand() - 1.0)
        if dot(v, v) < 1.0
            return v
        end
    end
end

function reflect(v::AbstractVec, n::AbstractVec)
    v = normalize(v)
    v - 2dot(v, n)n
end

function refract(v::AbstractVec, n::AbstractVec, index::AbstractFloat)
    v = normalize(v)
    dt::AbstractFloat = dot(v, n)
    discriminant::AbstractFloat = 1.0 - index^2 * (1.0 - dt^2)
    if discriminant > 0
        refracted::AbstractVec = index * (v - n * dt) - n * sqrt(discriminant)
        true, refracted
    end
    false, nothing
end
