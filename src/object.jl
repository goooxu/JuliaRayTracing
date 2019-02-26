struct Object
    surface::Surface
    frontMaterial::Union{Nothing, Material}
    backMaterial::Union{Nothing, Material}

    function Object(surface::Surface, material::Material)
        new(surface, material, nothing)
    end
end

function hit(obj::Object, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, AbstractFloat, Union{Nothing, HitPoint}, Union{Nothing, Material}}
    succeeded::Bool, t::AbstractFloat, hp::Union{Nothing, HitPoint} = hit(obj.surface, ray, range)
    if !succeeded
        return false, NaN, nothing, nothing
    end
    local m::Union{Nothing, Material}
    if hp.front
        m = obj.frontMaterial
    else
        m = obj.backMaterial
    end
    m != nothing, t, hp, m
end