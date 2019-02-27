struct ImageTexture{T} <: Texture where T <: Real
    width::Integer
    height::Integer
    img::Array{RGBA{T}, 2}

    function ImageTexture(img::Array{RGBA{T}, 2}) where T <: Real
        img_size::Tuple{Integer, Integer} = size(img)
        new{T}(img_size[2], img_size[1], img)
    end
end

function value(it::ImageTexture, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)::AbstractVec
    i::Integer = convert(Integer, floor(u * it.width)) + 1
    j::Integer = convert(Integer, floor((1.0 - v) * it.height)) + 1
    i = max(1, i)
    j = max(1, j)
    i = min(it.width, i)
    j = min(it.height, j)
    pixel::RGBA = it.img[j, i]
    r::AbstractFloat = pixel.r
    g::AbstractFloat = pixel.g
    b::AbstractFloat = pixel.b
    a::AbstractFloat = pixel.alpha
    Vec(r * a, g * a, b * a)
end