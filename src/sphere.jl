function get_sphere_uv(p::AbstractVec)
    ϕ::AbstractFloat = atan(z(p), x(p))
    Θ::AbstractFloat = asin(y(p))
    u::AbstractFloat = 1.0 - (ϕ + π) / 2π
    v::AbstractFloat = (Θ + 0.5π) / π
    u, v
end

struct Sphere <: Surface
    center::AbstractVec
    radius::AbstractFloat
end

function hit(sphere::Sphere, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, AbstractFloat, Union{Nothing, HitPoint}}
    oc::AbstractVec = ray.origin - sphere.center
    a::AbstractFloat = dot(ray.direction, ray.direction)
    b::AbstractFloat = dot(oc, ray.direction)
    c::AbstractFloat = dot(oc, oc) - sphere.radius * sphere.radius
    discriminant::AbstractFloat = b * b - a * c

    if discriminant > 0
        t::AbstractFloat = (-b + copysign(sqrt(discriminant), -c)) / a;
        if range.min < t < range.max
            point::AbstractVec = point_at(ray, t)
            normal::AbstractVec = normalize(point - sphere.center)
            u::AbstractFloat, v::AbstractFloat = get_sphere_uv(normal)

            if c > 0
                return true, t, HitPoint(point, normal, u, v, true)
            else
                return true, t, HitPoint(point, -normal, u, v, false)
            end
        end
    end

    false, NaN, nothing
end