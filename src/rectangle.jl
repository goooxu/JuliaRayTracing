struct Rectangle <: Surface
    p1::AbstractVec
    p2::AbstractVec
    p3::AbstractVec
    v1::AbstractVec
    v2::AbstractVec
    normal::AbstractVec
    d::AbstractFloat
    u2::AbstractFloat
    u4::AbstractFloat

    function Rectangle(p1::AbstractVec, p2::AbstractVec, p3::AbstractVec)
        v1::AbstractVec = p1 - p2
        v2::AbstractVec = p3 - p2
        normal::AbstractVec = normalize(cross(v1, v2))
        d::AbstractFloat = -dot(normal, p2)
        u2::AbstractFloat = dot(v1, v1)
        u4::AbstractFloat = dot(v2, v2)
        new(p1, p2, p3, v1, v2, normal, d, u2, u4)
    end
end

function hit(rect::Rectangle, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, AbstractFloat, Union{Nothing, HitPoint}}
    b::AbstractFloat = dot(rect.normal, ray.direction)

    if b != 0
        a::AbstractFloat = -dot(rect.normal, ray.origin) - rect.d
        t::AbstractFloat = a / b
        if range.min < t < range.max
            point::AbstractVec = point_at(ray, t)
            v::AbstractVec = point - rect.p2
            u1::AbstractFloat = dot(v, rect.v1)
            u3::AbstractFloat = dot(v, rect.v2)

            if 0 < u1 < rect.u2 && 0 < u3 < rect.u4
                if a < 0
                    return true, t, HitPoint(point, rect.normal, 1.0 - u1 / rect.u2, 1.0 - u3 / rect.u4, true)
                else
                    return true, t, HitPoint(point, -rect.normal, 1.0 - u1 / rect.u2, 1.0 - u3 / rect.u4, false)
                end
            end
        end
    end

    false, NaN, nothing
end