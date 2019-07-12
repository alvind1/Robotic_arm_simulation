grid on;

axis_dim = [0, 18, -6, 6, 0, 15];

x = 11;
y = 5;
z = 5;
theta_x = 1.4834; %May not be given
theta_y = 1.5290; 

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

if(IK_conditions(points, arms_lengths) ~= 1)
    error("NOT POSSIBLE");
end

vectors = containers.Map();
vectors('CE') = points('E') - points('C');
vectors('CF') = points('F') - points('C');
vectors('cross1') = -cross(vectors('CE'), vectors('CF'));
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

figure(1);
plot_points(points, angles, 'IK', axis_dim);

txt_points = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
disp(txt_points);

%% TODO
% Fix some cases in IK using givens from FK
