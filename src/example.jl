include("./render.jl")
using .RayTracing
using LinearAlgebra
using Images

const width = 1280
const height = 720
const samples = 100

const logo_img = load("logo.png")

const texture_1 = ConstantTexture(Vec(0.8, 0.8, 0.8))
const texture_2 = ConstantTexture(Vec(0.89, 0.74, 0.25)) #sunshine color
const texture_3 = ImageTexture(logo_img)
const material_1 = Lambertian(texture_1)
const material_2 = Metal(texture_1, 0.1)
const material_3 = Dielectric(1.5)
const material_4 = DiffuseLight(texture_2)
const material_5 = Metal(texture_3, 0.0)

const scene = Scene()
addObject(scene, Object(Sphere(Vec(-0.2, 0.0, -0.2), 0.2), material_1))
addObject(scene, Object(Sphere(Vec(-0.2, 0.0, 0.2), 0.2), material_2))
addObject(scene, Object(Sphere(Vec(0.2, 0.0, 0.2), 0.2), material_3))
addObject(scene, Object(Sphere(Vec(0.2, 0.0, -0.2), 0.2), material_4))
addObject(scene, Object(Rectangle(Vec(1.0, -0.2, 1.0), Vec(-1.0, -0.2, 1.0), Vec(-1.0, -0.2, -1.0)), material_5));

const look_from = Vec(2.0, 3.0, 2.5)
const look_to = Vec(0.0, 0.0, 0.0)
const dist_to_focus = norm(look_from - look_to)
const aperture = 0.1

const camera = Camera(
    look_from,
    look_to,
    Vec(0.0, 1.0, 0.0),
    20.0,
    width / height,
    aperture,
    dist_to_focus)

const image = @time render(scene, camera, (width=width, height=height), samples, Vec(0.5, 0.7, 1.0))

save("output.jpg", image)