struct DiffuseLight <: Material
    emit::Texture
end

function scatter(light::DiffuseLight, ray::Ray, hp::HitPoint)::Tuple{Bool, Union{Nothing, Vec}, Union{Nothing, Ray}}
    false, nothing, nothing
end

function emit(light::DiffuseLight, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)::Vec
    value(light.emit, u, v, point)
end