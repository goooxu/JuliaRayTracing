struct Dielectric <: Material
    refractive_index::AbstractFloat
end

function schlick(cosine::AbstractFloat, refractive_index::AbstractFloat)
    r0::AbstractFloat = ((1.0 - refractive_index) / (1.0 + refractive_index))^2
    r0 + (1.0 - r0) * (1.0 - cosine)^5
end
    

function scatter(dielectric::Dielectric, ray::Ray, hp::HitPoint)::Tuple{Bool, Union{Nothing, AbstractVec}, Union{Nothing, Ray}}
    attenuation::AbstractVec = Vec(1.0, 1.0, 1.0)
    local scattered::Ray
    
    succeeded::Bool, refracted::Union{Nothing, AbstractVec} = refract(ray.direction, hp.normal, 1.0 / dielectric.refractive_index)
    if succeeded
        cosine::AbstractFloat = -dot(ray.direction, hp.normal) / norm(ray.direction)
        reflect_prob::AbstractFloat = schlick(cosine, refractive_index)
        if rand() >= reflect_prob
            scattered = Ray(hp.point, refracted)
            return true, attenuation, scattered
        end
    end

    reflected::AbstractVec = reflect(ray.direction, hp.normal)
    scattered = Ray(hp.point, reflected)
    true, attenuation, scattered
end
