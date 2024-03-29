function[check] = checkFK(points, angles)
    global arms_lengths;
    check = 1;
    k = keys(points);
    v_points = values(points);
    v_lengths = values(arms_lengths);
    v_angles = values(angles);
    
    [cx, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~] = get_real_board_coords();
    
    for i = 1:length(points)
        if (i~=1)
            if(abs(norm(v_points{i}-v_points{i-1}) - v_lengths{i-1}) > 0.01) 
                disp(i);
                disp(norm(v_points{i}-v_points{i-1}));
                disp(v_lengths{i-1});
                check = -100;
                error("LENGTH ERROR");
            end
        end
        
%         if (i==3 || i==4 || i==5) %Can't really check angle anymore since
%         signs
%             if abs((pi-cosine_law_angle(v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}))) - abs(v_angles{i-2})) > 0.01
%                 ["Correct Answer:", v_angles{i-2}]
%                 ["Got Answer:", (pi-cosine_law_angle(v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1})))]
%                 txt = [k(i), v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}), (pi-cosine_law_angle(v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}))), v_angles{i-2}];
%                 disp(txt);
%                 txt_angles = [points('C'), points('D'), points('E'), points('F')];
%                 disp(txt_angles);
%                 error("ANGLE ERROR");
%                 check = -200;
%                 return;
%             end
%         end
        
        if i ~= 6
            if check_segmentboard_intersection(v_points{i}, v_points{i+1}-v_points{i}, i) == -1
                check = -300;
                return;
            end
        end
        
        if i ~= 1
            if v_points{i}(3) < 0.01 || v_points{i}(1) > cx+3.5
                check = -400;
                return;
            end
        end
                   
    end
    
    %disp("DONE");
end