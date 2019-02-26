abstract type Material end

function emit(material::Material, u::AbstractFloat, v::AbstractFloat, point::AbstractVec)::Vec
    Vec(0.0, 0.0, 0.0)
end