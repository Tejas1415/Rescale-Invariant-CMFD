clc
count5=0; match=zeros(1,7); sorted= zeros(1,7);
i2=round(i2,15);
for i=1:61                      %Finding matching corner points in the image
    for j=1:61
        A2=resize_matrix{i,j};
        [row1, col1]= size(A2);
        for k=1:row1
            for l=1:col1
               E= A2(k,l);
               E=round(E,15);
               for a=1:64
                   for b=1:64
                if(i2(a,b)==E)
                   D= [E k l a b i j];
                 match=vertcat(match,D);
                 
                count5 = count5+1;
                end
            end
        end
    end
end
end
end
match(1,:)=[];
B=unique(match, 'rows', 'stable');
[row3, col3]= size(B); % row1=10,4; row3= 118,1
for i=1:row1                                        % create different matricces for different sizes.
    D = B(:,2) == i;
    
    for j=1:row3
   if D(j)==1;
       F=B(j,:);
       sorted=vertcat(sorted,F);      
   end
    end
    sorted(1,:)=[];
    match1{i}=sorted;
    sorted=zeros(1,7);
end

corner=[ 1 2 3 4 ];
count4=1;
for i=1:row1                                        %eliminate the sizes not having all 4 corner pixels.
    Z=match1{i};
    corner_values= Z(:,3);
    check =  all(ismember(corner, corner_values));
    if check==1;
        correct_matches{count4}= Z;
        i;
        count4=count4+1;
    end    
end
count4=count4-1;

c=0;c1=0;c2=0;
for i=1:count4                       %count4   % eliminate all the rows in pixels with less that 2 repetitions to match rectangle
    A3= correct_matches{i};
    B3=A3;
    B1=A3(:,4); B2=A3(:,5);
    [row4, col4]=size(A3);
    for j=1:row4
    c1=numel(find(B1==B1(j))); c2= numel(find(B2==B2(j)));
    if (c1 < 2 && c2 < 2)
        B3(j,:)=[];
        c=c+1;
    end
    end
    correct_matches{i}=B3;
end


corner1=zeros(1,2);corner2=zeros(1,2);corner3=zeros(1,2);corner4=zeros(1,2);
for i=2:2
    A5=correct_matches{i};
    B5=A5;
    B6= A5(:,3);B1=A5(:,4); B2=A5(:,5);
    [row6,col6]=size(A5);
    for j=1:row6 
        B6(j)=round(B6(j));
            if (B6(j)==1)
            co1= [B1(j) B2(j)];
            corner1=vertcat(corner1,co1);
        end
        if (B6(j)==2)
            co2=[B1(j) B2(j)];
            corner2= vertcat(corner2,co2);
    end
    if (B6(j)==3)
            co3=[B1(j) B2(j)];
            corner3= vertcat(corner3,co3);
    end
    if (B6(j)==4)
            co4=[B1(j) B2(j)];
            corner4= vertcat(corner4,co4);
    end 
    end
    corner1(1,:)=[];corner2(1,:)=[];corner3(1,:)=[];corner4(1,:)=[];
    %[r1,c1]=size(corner1);[r2,c2]=size(corner2);[r3,c3]=size(corner3);[r4,c4]=size(corner4);
   % mini= min(row1,row2,row3,row4);
end
    output= zeros(row, col);
    output(35:60,33:58)=1;
    figure,imshow(output);title('output');
    

