height = 3;
width  = 3;

[x y] = meshgrid((-width / 2.0):(width / 2.0), (-height / 2.0):(height/2.0));
m = (x .* x) + (y .* y)
m = -m + max(reshape(m, [], 1))