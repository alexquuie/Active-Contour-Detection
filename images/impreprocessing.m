
I=im2double(imread('pacman.pgm'));
I=imresize(I,[size(I,1)/3,size(I,2)/4]);
I(I<mean(I(:)))=0;
I(I>0)=255;
bwfinal=I;
bwoutline=bwperim(bwfinal);
Segout=I;
Segout(bwoutline)=255;


I=I/255;
BW = edge(I,'canny',0.5);
imwrite(bwoutline,'pacman_raw.pgm');