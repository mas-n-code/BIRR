function edgima=simpleLaplace(image)
sizmat=size(image);
hs=[1,4,1;4,-20,4;1,4,1];
edgima = imfilter(image, hs, 'replicate', 'conv');
edgima=edgima(1:sizmat(1),1:sizmat(2));
