struct Camera
    origin::AbstractVec
    lower_left_corner::AbstractVec
    horizontal::AbstractVec
    vertical::AbstractVec
    u::AbstractVec
    v::AbstractVec
    lens_radius::AbstractFloat

    function Camera(
        look_from::AbstractVec,
        look_to::AbstractVec,
        up::AbstractVec,
        vfov::AbstractFloat,
        aspect::AbstractFloat,
        aperture::AbstractFloat,
        focus_dist::AbstractFloat)
        
        Θ::AbstractFloat = vfov * π / 180
        half_height::AbstractFloat = tan(Θ / 2)
        half_width::AbstractFloat = aspect * half_height
        w::AbstractVec = normalize(look_from - look_to)
        u::AbstractVec = normalize(cross(up, w))
        v::AbstractVec = cross(w, u)
        lower_left_corner::AbstractVec = look_from - focus_dist * (half_width * u + half_height * v + w)
        horizontal::AbstractVec = 2.0 * focus_dist * half_width * u
        vertical::AbstractVec = 2.0 * focus_dist * half_height * v
        lens_radius::AbstractFloat = aperture / 2

        new(look_from, lower_left_corner, horizontal, vertical, u, v, lens_radius)
    end
end

function get_ray(camera::Camera, s::AbstractFloat, t::AbstractFloat)::Ray
    rd::AbstractVec = camera.lens_radius * random_in_unit_disk()
    offset::AbstractVec = camera.u * x(rd) + camera.v * y(rd)
    Ray(camera.origin + offset, camera.lower_left_corner + s * camera.horizontal + t * camera.vertical - (camera.origin + offset))
end