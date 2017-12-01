function [ total_length ] = length_of_flat_coil(n, wire_radius, spacing, inner_radius )
total_length = 0;

for n_ = 1:1:n
    
    radius_for_loop = inner_radius + n_*(wire_radius+spacing);

    circumference_for_loop = radius_for_loop*2*pi;
    
    total_length = total_length + circumference_for_loop;
end

end

