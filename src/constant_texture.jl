struct ConstantTexture <: Texture
    color::AbstractVec
end

function value(texture::ConstantTexture, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)::AbstractVec
    texture.color
end