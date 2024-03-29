function[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_board_coords()
    %PRACTICE COORDINATES
    cx = 10; %x coord of board centre
    cy = 0; %y coord of board centre
    cz = 20;% z coord
    w = 3; %width
    board_theta = 0;
    holez = 16; %height of centre of hole
    r = 2;  
    
    plane = [1*cos(board_theta), 1*sin(board_theta), 0]; %Normal vector of plane
    ppoint = [cx, cy, holez]; %Centre of hole
    board = [abs(sin(board_theta)*w), abs(w*cos(board_theta)), cz]; %positive x, y, z components of one of the top corners
end