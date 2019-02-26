struct ConstantTexture <: Texture
    color::AbstractVec
end

function value(texture::ConstantTexture, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)
    texture.color
end