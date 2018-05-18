function NewCirc=circ_creator(x,y,rad,label,iterations)
%% function NewCirc=circ_creator(x,y,rad,iterations)
% creates a circ structre of repeatede elements x,y and radius 

%initialize structure;
NewCirc(iterations).x=0;

%fill strucutre with repeated elements.
for i=1:iterations
   NewCirc(i).x=x;
   NewCirc(i).y=y;
   NewCirc(i).rad=rad;
   NewCirc(i).image=label;
   
end