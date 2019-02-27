struct DiffuseLight <: Material
    emit::Texture
end

function scatter(light::DiffuseLight, ray::Ray, hp::HitPoint)::Tuple{Bool, Union{Nothing, AbstractVec}, Union{Nothing, Ray}}
    false, nothing, nothing
end

function emit(light::DiffuseLight, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)::AbstractVec
    value(light.emit, u, v, point)
end