function h = plot_patch_target(centers,radii,color_value,alpha_value)
% Generates circular patches following the very handy viscirle format
xc=centers(1);
yc=centers(2);
theta = 0:0.05:2*pi;
x = radii*sin(theta) +xc;
y = radii*cos(theta) +yc;

h = patch(x,y,color_value,'EdgeColor',[1 1 1],'FaceAlpha','flat','FaceVertexAlphaData',alpha_value);            % make a  circular patch
% Edge color set to white, default is black [0 0 0]

% Example / tester
% plot_patch_target([-2.5 2.5],1.5,[0 0 1],0.3);