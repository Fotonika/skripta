import Pkg
Pkg.activate(".")
using Plots
n = 300
f(x, y) = exp(-(x^2 + y^2) / 2)
l0(x, m) = 1
l1(x, m) = -x + m + 1
l2(x, m) = (x^2 - 2 * (m + 2) * x + (m + 1) * (m + 2)) / 2
l = [l0, l1, l2]
x = LinRange(-4, 4, n)
y = LinRange(-4, 4, n)
r(x, y) = sqrt(x^2 + y^2)
"Cosine of a multiply of polar angle for a point in plane."
cos_m(x, y, m) = cos(m * atan(y / x))

color = coloralpha(Colors.parse(Colorant, :blue2), 0)
c_gradient = ColorGradient([color, :white])
plots = []
for i = 0:2, m = 0:3
  z = [abs((r(xi, yi)^m * l[i+1](r(xi, yi)^2, m) * f(xi, yi)) *
           cos_m(xi, yi, m)) for xi in x, yi in y]
  p = heatmap(x, y, z,
    aspect_ratio = 1,
    axis = false,
    legend = false,
    grid = false,
    color = c_gradient,
    background_color = color,
  )
  push!(plots, p)
  savefig("../slike/laguerrovi_snopi_faza_$(i)_$m.png")
end
plot(plots..., layout = (3, 4))
