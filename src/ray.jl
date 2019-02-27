struct Ray
    origin::AbstractVec
    direction::AbstractVec
end

function point_at(ray::Ray, t::AbstractFloat)::AbstractVec
    ray.origin + t * ray.direction
end