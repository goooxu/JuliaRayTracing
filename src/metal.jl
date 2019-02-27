struct Metal <: Material
    albedo::Texture
    fuzz::AbstractFloat

    function Metal(albedo::Texture, fuzz::AbstractFloat)
        new(albedo, min(fuzz, 1.0))
    end
end

function scatter(metal::Metal, ray::Ray, hp::HitPoint)::Tuple{Bool, Union{Nothing, AbstractVec}, Union{Nothing, Ray}}
    reflected::AbstractVec = reflect(ray.direction, hp.normal)
    attenuation::AbstractVec = value(metal.albedo, hp.u, hp.v, hp.point)
    scattered::Ray = Ray(hp.point, reflected + metal.fuzz * random_in_unit_sphere())
    dot(scattered.direction, hp.normal) > 0, attenuation, scattered
end

