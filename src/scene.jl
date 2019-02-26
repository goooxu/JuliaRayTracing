struct Scene
    objects::Vector{Object}

    function Scene()
        new(Vector{Object}[])
    end
end

function hit(scene::Scene, ray::Ray, range::NamedTuple{(:min, :max), Tuple{T, T}} where T <: AbstractFloat)::Tuple{Bool, Union{Nothing, HitPoint}, Union{Nothing, Material}}
    hit_anything::Bool = false
    closest_so_far::AbstractFloat = range.max
    local hp::HitPoint
    local m::Material
    for object in scene.objects
        succeeded::Bool, t::AbstractFloat, hp0::Union{Nothing, HitPoint}, m0::Union{Nothing, Material} = hit(object, ray, (min=range.min, max=closest_so_far))
        if succeeded
            hit_anything = true
            closest_so_far = t;
            hp = hp0
            m = m0
        end
    end
    if hit_anything
        return true, hp, m
    else
        return false, nothing, nothing
    end
end

function addObject(scene::Scene, object::Object)
    push!(scene.objects, object)
end