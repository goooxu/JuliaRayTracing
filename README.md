# JuliaRayTracing

A simple ray tracing render written in [Julia](https://julialang.org/)

## Run

Before run, should install `StaticArrays` and `Images` via the [package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/),

```julia
(v1.1) pkg> add StaticArrays
(v1.1) pkg> add Images
```

Then, execute the following command to run an example

```bash
julia src/example.jl
```

Which will create the below image

![output](https://user-images.githubusercontent.com/22703054/53485391-0fd18800-3ac1-11e9-8cc9-3d9c0d7b9511.jpg)