format long                # to visualise the calculated values upto 15 decimal digits.

i=imread('tamp14.jpg');    # input the tampered image.
i2=rgb2gray(i);            # convert to gray scale and resize the image to 64x64. Better results can be obtained through 128x128, but it is computationally expensive.
i2=imresize(i2,[64 64]);
figure,imshow(i2);title('original image');
impixelinfo;               # Just for visual confirmation over the pixels in the image. Keep cursor on the image to see location values.
i2=im2double(i2);
i3= i2(15:30,15:30);       # Manually cropping a part of the image
figure,imshow(i3);title('cropped image');
i4= imresize(i3,1.6);      # Now we resize (with any constant) the cropped region and paste that elsewhere.
i2(35:60, 33:58)= i4;      # duplicating the region.
figure,imshow(i2);title('rescaled i2 image');
[row, col]= size(i2);


# Now that we have created our own copy-rescale-move forged image, let us formulate an algorithm to detect such an forgery automatically using the above image.

count5=0;
counti=0;countj=0;S=zeros(1,2);corner_pixels=zeros(1,4);  # Divide the image into overlappingblocks of size 4x4.
Blocks2 = cell(row/4,col/4);
for i=1:row-3
    counti = counti + 1;
   countj = 0;
    for j=1:col-3
         
        countj = countj + 1;
Blocks2{counti,countj} = i2(counti:counti+3,countj:countj+3);  
       count5=count5+1;
       
       image=Blocks2{counti,countj};         # Logic is hard to explain in one sentence - go through the paper.
       for i=1.1:0.1:2
           A1= imresize(image,i);
           scale=i;
           c1= A1(1,1); c2=A1(1,end); c3=A1(end,1); c4=A1(end,end); # record all 4 corner pixels of each block.
           %cp=[ scale, c1, c2, c3, c4 ];
           cp= [c1, c2, c3, c4];
           corner_pixels=vertcat(corner_pixels, cp);      # vertically concatenate all these corner pixels for each of the created overlapped blocks.
       end
       
       corner_pixels(1,:)=[];
       resize_matrix{counti,countj}=corner_pixels;
       corner_pixels=zeros(1,4);                          # Reset for next iteration
    end
end

# This is not the end of the program. For simplicity I have divided the recognition part of the process in another file. Once this part of the program is executed, go to the next.


