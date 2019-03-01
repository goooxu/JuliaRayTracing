struct Sketch{T} <: Surface where T <: Real
    rect::Rectangle
    width::Integer
    height::Integer
    img::Array{RGBA{T}, 2}

    function Sketch(p1::AbstractVec, p2::AbstractVec, p3::AbstractVec, img::Array{RGBA{T}, 2}) where T <: Real
        rect::Rectangle = Rectangle(p1, p2, p3)
        image_size::Tuple{Integer, Integer} = size(img)
        new{T}(rect, image_size[2], image_size[1], img)
    end
end

function hit(sketch::Sketch, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, AbstractFloat, Union{Nothing, HitPoint}}
    succeeded::Bool, t::AbstractFloat, hp::Union{Nothing, HitPoint} = hit(sketch.rect, ray, range)
    if succeeded
        if solid(sketch, hp.u, hp.v)
            return true, t, hp
        end
    end
    false, NaN, nothing
end

function solid(sketch::Sketch, u::AbstractFloat, v::AbstractFloat)::Bool
    i::Integer = convert(Integer, floor(u * sketch.width)) + 1
    j::Integer = convert(Integer, floor((1.0 - v) * sketch.height)) + 1
    i = max(1, i)
    j = max(1, j)
    i = min(sketch.width, i)
    j = min(sketch.height, j)
    pixel::RGBA = sketch.img[j, i]
    pixel.alpha > 0
end