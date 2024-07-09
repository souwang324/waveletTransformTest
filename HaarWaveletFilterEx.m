

close all
clear all
clc
wname = 'haar';
[Lo_D, Hi_D, Lo_R, Hi_R] = wfilters(wname);

imagename='lena256x256.jpg';
ImageMatrix = imread(imagename);
figure
imshow(ImageMatrix);
title('original')
IMatrix = double(ImageMatrix);
[h, w, d]= size(IMatrix);
P = zeros(h, w);

for j = 1:2:h
    P(j, (j-1)/2+1) = Lo_D(1);
    P(j+1, (j-1)/2+1) = Lo_D(2);
    P(j, h/2+(j-1)/2+1) = Hi_D(1);
    P(j+1, h/2+(j-1)/2+1) = Hi_D(2);
end

IMatrixLH = IMatrix*P;
ImageMatrixLH = uint8(IMatrixLH);
figure
imshow(ImageMatrixLH);
title('LH')

Q = P';  %%% zeros(size(P));    
% for i= 1:h/2
%     Q(i, 2*(i-1)+1 ) = Lo_D(1);
%     Q(i, 2*i) = Lo_D(2);
%     Q(h/2+i, 2*(i-1)+1) = Hi_D(1);
%     Q(h/2+i ,2*i) = Hi_D(2);
% end
IMatrixLH2 = Q*IMatrixLH;
ImageMatrixLH = uint8(IMatrixLH2);
figure
imshow(ImageMatrixLH)
title('2 LH')

%% IMatrixLH22 = [IMatrixLH2(1:h/2, 1:w/2) zeros(h/2, w/2); zeros(h/2, w/2) zeros(h/2, w/2)];
IMatrixLH22 = IMatrixLH2;
restoreImage =Q'*IMatrixLH22*P';
res_image = uint8(restoreImage); 
figure
imshow(res_image);
title('restore')

norm(IMatrix - restoreImage)

