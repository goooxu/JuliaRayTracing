function get_sphere_uv(p::AbstractVec)
    ϕ = atan(z(p), x(p))
    Θ = asin(y(p))
    u = 1.0 - (ϕ + π) / 2π
    v = (Θ + 0.5π) / π
    u, v
end

struct Sphere <: Surface
    center::AbstractVec
    radius::AbstractFloat
end

function hit(sphere::Sphere, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, AbstractFloat, Union{Nothing, HitPoint}}
    oc = ray.origin - sphere.center
    a = dot(ray.direction, ray.direction)
    b = dot(oc, ray.direction)
    c = dot(oc, oc) - sphere.radius * sphere.radius
    discriminant = b * b - a * c

    if discriminant > 0
        t = (-b + copysign(sqrt(discriminant), -c)) / a;
        if range.min < t < range.max
            point = point_at(ray, t)
            normal = normalize(point - sphere.center)
            u, v = get_sphere_uv(normal)

            if c > 0
                return true, t, HitPoint(point, normal, u, v, true)
            else
                return true, t, HitPoint(point, -normal, u, v, false)
            end
        end
    end

    false, NaN, nothing
end