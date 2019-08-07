function[check] = IK_conditions(points, arms_lengths, num, plane, board, ppoint, r)
    check = 1;
    if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
        check = -1;
        %disp("A.1");
        return;
    end 

    if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
        check = -2;
        %disp("A.2");
        return;
    end 
    
    if num == 1
        got_val = values(points);
        k = keys(points);

        for i=1:length(k) %Checks if x or z components are negative
            temp = got_val{i};
            %disp(points(k{i}));
            if(temp(1) < -0.01 || temp(3) < -0.01)
                %disp("B.2");
                check = -4;
                return;
            end
            
            for m = i+1:length(k)-1 %Check if arm segments over lap
                if check_line_intersection(got_val{i}, got_val{i+1}, got_val{m}, got_val{m+1})  == -3
                    return;
                end
            end
            
            if i ~= 6 && r ~= -1
                if check_segmentboard_intersection(plane, ppoint, points(k{i}), points(k{i+1})-points(k{i}), board, r) == -1
                    check = -5;
                    disp(i);
                    disp("PLANE INTERSECTION");
                    return;
                end
            end
            
        end
    end
end