module RayTracing
    export Vec
    export Sphere, Rectangle
    export ConstantTexture, ImageTexture, Lambertian, Metal, Dielectric, DiffuseLight
    export Object, Scene, Camera
    export addObject, render

    using StaticArrays
    using LinearAlgebra
    using Images
    using Printf

    include("vector.jl")
    include("ray.jl")
    include("surface.jl")
    include("rectangle.jl")
    include("sphere.jl")
    include("hitpoint.jl")
    include("texture.jl")
    include("constant_texture.jl")
    include("image_texture.jl")
    include("material.jl")
    include("lambertian.jl")
    include("metal.jl")
    include("dielectric.jl")
    include("diffuse_light.jl")
    include("object.jl")
    include("scene.jl")
    include("camera.jl")

    function color(scene::Scene, ray::Ray, bg_color::Vec, depth::Int64 = 0)
        local succeeded::Bool
        succeeded, hp::Union{Nothing, HitPoint}, material::Union{Nothing, Material} = hit(scene, ray, (min = 0.001, max = Inf))
        if succeeded
            emitted::Vec = emit(material, hp.u, hp.v, hp.normal)
            if depth < 50
                succeeded, attenuation::Union{Nothing, Vec}, scattered::Union{Nothing, Ray} = scatter(material, ray, hp)
                if succeeded
                    return emitted + attenuation .* color(scene, scattered, bg_color, depth + 1)
                else
                    return emitted
                end
            end
        end

        bg_color
    end

    function render(scene::Scene, camera::Camera, size::NamedTuple{(:width, :height), Tuple{T, T}} where T <: Integer, samples::Integer, bg_color::Vec)
        image = zeros(RGB, size.height, size.width)

        for j = 1:size.height, i = 1:size.width
            col::AbstractVec = Vec(0.0, 0.0, 0.0)
            for s = 1:samples
                u::AbstractFloat = (i - rand()) / size.width
                v::AbstractFloat = (j - rand()) / size.height
                ray::Ray = get_ray(camera, u, v)
                col += color(scene, ray, bg_color)
            end

            col /= samples
            image[size.height + 1 - j, i] = RGB(sqrt(x(col)), sqrt(y(col)), sqrt(z(col)))

            @printf("\r%.0f%%", 100.0 * j / size.height)
        end

        image
    end

end