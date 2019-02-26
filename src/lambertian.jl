struct Lambertian <: Material
    albedo::Texture
end

function scatter(lambertian::Lambertian, ray::Ray, hp::HitPoint)::Tuple{Bool, Union{Nothing, Vec}, Union{Nothing, Ray}}
    attenuation::AbstractVec = value(lambertian.albedo, hp.u, hp.v, hp.point)
    scattered = Ray(hp.point, hp.normal + random_in_unit_sphere())
    true, attenuation, scattered
end