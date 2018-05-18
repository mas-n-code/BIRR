function edgima=simplesobel(image)
sizmat=size(image);
hx=[-1,0,1;-2,0,2;-1,0,1];
hy=[1,2,1;0,0,0;-1,-2,-1];
xs = imfilter(image, hx, 'replicate', 'conv');
ys = imfilter(image, hy, 'replicate', 'conv');

edgima=(abs(xs).^2+abs(ys).^2).^0.5;
edgima=edgima(1:sizmat(1),1:sizmat(2));
