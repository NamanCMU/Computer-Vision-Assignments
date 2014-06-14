function [ x2,y2 ] = epipolarCorrespondence(im1,im2,F,x1,y1)

diff_threshold = 100;
point = [x1,y1];
Lines = epipolarLine(F,point);
ys = 1;
xs = -(Lines(2)*ys + Lines(3))/Lines(1);
ye = size(im2,1);
xe = -(Lines(2)*ye+ Lines(3))/Lines(1);

xs = round(xs);
xe = round(xe);

vecy = ys:ye;
vecx = xs:(xe-xs)/ye:xe;
vecx = vecx(1:480);
%vecx = interp1([xs ys],[xe ye],vecy)
%pts = [vecx; vecy]';

xvec2 = (x1 - 10) : (x1 + 10);
yvec2 = (y1 - 10) : (y1 + 10);
[X2,Y2] = meshgrid(xvec2,yvec2);
patch2 = interp2(im2double(rgb2gray(im1)),X2,Y2);
patch22 = patch2(:);

for i =1:480
    xinitial = vecx(i) - 10;
    xfinal = vecx(i) + 10;
    yinitial = vecy(i) - 10;
    yfinal = vecy(i) + 10;
    if xinitial < 1 || xfinal > size(im2,2) || yinitial < 1 || yfinal > size(im2,1) 
        continue;
    end
    xvec1 = xinitial : xfinal;
    yvec1 = yinitial : yfinal;
    [X1,Y1] = meshgrid(xvec1,yvec1);
    patch1 = interp2(im2double(rgb2gray(im2)),X1,Y1);
    patch11 = patch1(:);
    diff = sum((patch11 - patch22).^2);
    if diff < diff_threshold
        diff_threshold = diff;
        x2 = vecx(i);
        y2 = vecy(i);
    end
end



end

