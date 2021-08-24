clc
clear all
close all

syms phi theta psi X Y Z xa ya za xb yb zb

xa = 0.225
ya = 0.0
za = -0.228

xb = 1.7580
yb = 2.8
zb = -1.015

X = 0.2
Y = 0.3
Z = -0.4

phi = 0.1
theta = -1.4
psi = 0.1

phidot = diff(phi, t);
thetadot = diff(theta, t);
psidot = diff(psi, t);
phidotdot = diff(phidot, t);
thetadotdot = diff(thetadot, t);
psidotdot = diff(psidot, t);

%rotation matrix
R = [cos(psi)*cos(phi)-cos(theta)*sin(phi)*sin(psi) -sin(psi)*cos(phi)-cos(theta)*sin(phi)*cos(psi) sin(theta)*sin(phi); cos(psi)*sin(phi)+cos(theta)*cos(phi)*sin(psi) -sin(psi)*sin(phi)+cos(theta)*cos(phi)*cos(psi) -sin(theta)*cos(phi); sin(psi)*sin(theta) cos(psi)*sin(theta) cos(theta)];

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

%transformation mtarix
a = x + R*Pa;

%coordinates of attachment point on base
b = [xb; yb; zb];

L = a - b

%length of link
l = sqrt(dot(L, L))
