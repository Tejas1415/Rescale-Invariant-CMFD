format long

i=imread('tamp14.jpg');
i2=rgb2gray(i);
i2=imresize(i2,[64 64]);
figure,imshow(i2);title('original image');
impixelinfo;
i2=im2double(i2);
i3= i2(15:30,15:30);
figure,imshow(i3);title('cropped image');
i4= imresize(i3,1.6);
i2(35:60, 33:58)= i4;
figure,imshow(i2);title('rescaled i2 image');
[row, col]= size(i2);

count5=0;
counti=0;countj=0;S=zeros(1,2);corner_pixels=zeros(1,4);
Blocks2 = cell(row/4,col/4);
for i=1:row-3
    counti = counti + 1;
   countj = 0;
    for j=1:col-3
        
        countj = countj + 1;
Blocks2{counti,countj} = i2(counti:counti+3,countj:countj+3);
       count5=count5+1;
       
       image=Blocks2{counti,countj};
       for i=1.1:0.1:2
           A1= imresize(image,i);
           scale=i;
           c1= A1(1,1); c2=A1(1,end); c3=A1(end,1); c4=A1(end,end);
           %cp=[ scale, c1, c2, c3, c4 ];
           cp= [c1, c2, c3, c4];
 %          cp=round(cp,7);
           corner_pixels=vertcat(corner_pixels, cp);
       end
       corner_pixels(1,:)=[];
       resize_matrix{counti,countj}=corner_pixels;
       corner_pixels=zeros(1,4);
    end
end



