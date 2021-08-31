clc
clear all
close all

syms phi(t) theta(t) psi(t) X Y Z xa ya za xb yb zb

phi = 0;
theta = 0;
psi = 0;
X = 0;
Y = 0;
Z = 0;
xa = 0;
ya = 0;
za = 0;
xb = 0;
yb = 0;
zb = 0;

fprintf('P is the platform coordinate system and W is the world coordinate system')

for i=1:6
    fprintf('\nEnter values of link %d:- ', i)
    xa = input('\nEnter X coordinate of attachment point of platform with reference to P: ');
    ya = input('\nEnter Y coordinate of attachment point of platform with reference to P: ');
    za = input('\nEnter Z coordinate of attachment point of platform with reference to P: ');

    xb = input('\nEnter X coordinate of attachment point of base with reference to W: ');
    yb = input('\nEnter Y coordinate of attachment point of base with reference to W: ');
    zb = input('\nEnter Z coordinate of attachment point of base with reference to W: ');

    X = input('\nEnter X coordinate of frame P with reference to base coordinate system W: ');
    Y = input('\nEnter Y coordinate of frame P with reference to base coordinate system W: ');
    Z = input('\nEnter Z coordinate of frame P with reference to base coordinate system W: ');

    phi = input('\nEnter roll angle: ');
    theta = input('\nEnter pitch angle: ');
    psi = input('\nEnter yaw angle: ');

    phidot = diff(phi, t);
    thetadot = diff(theta, t);
    psidot = diff(psi, t);
    phidotdot = diff(phidot, t);
    thetadotdot = diff(thetadot, t);
    psidotdot = diff(psidot, t);

    %rotation matrix
    R = [cos(psi)*cos(phi)-cos(theta)*sin(phi)*sin(psi) -sin(psi)*cos(phi)-cos(theta)*sin(phi)*cos(psi) sin(theta)*sin(phi); 
        cos(psi)*sin(phi)+cos(theta)*cos(phi)*sin(psi) -sin(psi)*sin(phi)+cos(theta)*cos(phi)*cos(psi) -sin(theta)*cos(phi); 
        sin(psi)*sin(theta) cos(psi)*sin(theta) cos(theta)];

    %angular velocity
    omegaX = [0 cos(phi) sin(phi)*cos(theta)]*[phidot; thetadot; psidot];
    omegaY = [0 sin(phi) -cos(phi)*sin(theta)]*[phidot; thetadot; psidot];
    omegaZ = [1 0 cos(theta)]*[phidot; thetadot; psidot];
    omega = [omegaX; omegaY; omegaZ]

    %angular acceleration
    alphaX = [0 cos(phi) sin(phi)*cos(theta)]*[phidotdot; thetadotdot; psidotdot] + [0 -phidot*sin(phi) phidot*cos(phi)*sin(theta)+thetadot*sin(phi)*cos(theta)]*[phidot; thetadot; psidot];
    alphaY = [0 sin(phi) -cos(phi)*sin(theta)]*[phidotdot; thetadotdot; psidotdot] + [0 phidot*cos(phi) phidot*sin(phi)*sin(theta)-thetadot*cos(phi)*cos(theta)]*[phidot; thetadot; psidot];
    alphaZ = [1 0 cos(theta)]*[phidotdot; thetadotdot; psidotdot] + [0 0 -thetadot*sin(theta)]*[phidot; thetadot; psidot];
    alpha = [alphaX; alphaY; alphaZ];

    %translation vector
    x = [X; Y; Z];

    %coordinates of attachment point on moving platform
    Pa = [xa; ya; za];

    %transformation matrix
    a = x + R*Pa;

    %coordinates of attachment point on base
    b = [xb; yb; zb];

    L = a - b

    %length of link
    l = sqrt(dot(L, L))
    fprintf('\nLength of link %d is: %f', i, l)
end
