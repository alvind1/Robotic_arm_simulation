grid on;

xmin = 0;
xmax = 18;
ymin = -6;
ymax = 6;
zmin = 0;
zmax = 12;

x = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
y = 0;
z = 8;
theta_x = 0; %May not be given
theta_y = 0; 

z1 = y*tan(theta_x);
z0 = z-z1;

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [0, 0, z0];
points('C') = [arms_lengths('BC'), 0, z0];
points('D') = [-1, -1, -1];
points('E') = [x-cos(theta_y)*arms_lengths('EF'), y+sin(theta_y)*arms_lengths('EF')*cos(theta_x), z+sin(theta_y)*arms_lengths('EF')*sin(theta_x)];
points('F') = [x, y, z];

arms_lengths('CE') = norm(points('E')-points('C'));

if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
    error("Not possible 1");
end 

% if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
%     error("Not possible 2");
% end 

vectors = containers.Map();
vectors('CE') = points('E') - points('C');
vectors('CF') = points('F') - points('C');
vectors('cross1') = cross(vectors('CE'), vectors('CF'));
vectors('cross2') = cross(vectors('CE'), vectors('cross1'));

height = 2*heron(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))/arms_lengths('CE');

vectors('CG') = sqrt(arms_lengths('CD')^2-height^2)*vectors('CE')/norm(vectors('CE'));
if sqrt(arms_lengths('DE')^2-height^2) >= norm(points('E')-points('C'))
    vectors('CG') = -vectors('CG');
end 

if norm(vectors('cross2')) ~= 0
    vectors('GD') = height*vectors('cross2')/norm(vectors('cross2'));
else
    vectors('GD') = 0;
end

vectors('CD') = vectors('CG')+vectors('GD');

points('D') = points('C')+vectors('CD');

angles = containers.Map();
angles('C') = pi-cosine_law_angle(norm(points('C')-points('B')), arms_lengths('CD'), norm(points('D')-points('B')));
angles('D') = pi-cosine_law_angle(arms_lengths('CD'), arms_lengths('DE'), norm(points('E')-points('C')));
angles('E') = pi-cosine_law_angle(arms_lengths('DE'), arms_lengths('EF'), norm(points('F')-points('D')));
temp = points('D');

if temp(2) ~= 0
    angles('T') = atan((temp(3)-z0)/temp(2));
else
    angles('T') = 0;
end

x_val = [];
y_val = [];
z_val = [];

k = keys(points);
val = values(points);

for i = 1:length(points)
    x_val(end+1) = val{i}(1);
    y_val(end+1) = val{i}(2);
    z_val(end+1) = val{i}(3);
    scatter3(val{i}(1), val{i}(2), val{i}(3));
    text(val{i}(1), val{i}(2), val{i}(3), k(i));
    
    if(i ~= 1) %Print lengths
        text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
    end
    
    if(i ~= 1 && i ~= 2 && i ~= 6)
        text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(angles(k{i})), 'Color', 'r');
    end 
    
    if (i == 3)
        txt = ["Plane rotation", num2str(angles('T'))];
        text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt);
    end 
    
    hold on;
end

plot3(x_val, y_val, z_val);
axis([xmin, xmax, ymin, ymax, zmin, zmax]);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('IK');

%% TODO
% Fix some cases in IK using givens from FK
