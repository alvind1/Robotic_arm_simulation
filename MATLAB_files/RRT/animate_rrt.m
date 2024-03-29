function[] = animate_rrt(cur_point, next_point, p)
    global step_size;
    v = next_point(1:5)-cur_point(1:5);
    n = ceil(norm(v)/step_size);
    temp_angles = containers.Map();
    
    for i=1:n
        temp_coord = cur_point(1:5)+ i*v/n;
        temp_angles('C') = temp_coord(1);
        temp_angles('D') = temp_coord(2);
        temp_angles('E') = temp_coord(3);
        temp_angles('T') = temp_coord(4);
        temp_z0 = temp_coord(5);
        
        [points, ~] = FK(temp_angles, temp_z0);
        if points <= -100
            error("ERROR");
        end
        animate_func(temp_angles, points, temp_z0, i, p, n);
    end
end