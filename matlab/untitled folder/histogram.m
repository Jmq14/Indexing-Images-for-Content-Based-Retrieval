%Load Image
clear
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

output = fopen('histogram.txt','wt');


grpnum_R = 2;
grpnum_G = 2;
grpnum_B = 2;
range_r = 256 / grpnum_R;
range_g = 256 / grpnum_G;
range_b = 256 / grpnum_B;
if (mod(256, grpnum_R) > 0) 
    grpnum_R = grpnum_R+1;
end
if (mod(256, grpnum_G) > 0) 
    grpnum_G = grpnum_G+1;
end;
if (mod(256, grpnum_B) > 0) 
    grpnum_B = grpnum_B+1;
end

feature = zeros(grpnum_R*grpnum_G*grpnum_B, 1);

if img_num > 0
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        
        [m, n, c] = size(img);
        for i = 1:m
            for j = 1:n 
               
                r = fix(double(img(i,j,1))/range_r);
                g = fix(double(img(i,j,2))/range_g);
                b = fix(double(img(i,j,3))/range_b);
                p = r*grpnum_G*grpnum_B + g*grpnum_B + b + 1;
                feature(p, 1) = feature(p, 1)+1;
            end
        end
        a = sum(feature(:,1));
        for i = 1:length(feature)
            feature(i) = feature(i)/a;
        end
        fprintf(output, '%s', name);
        fprintf(output, ' %f', feature);
        fprintf(output, '\n');
    end
end

fclose(output);

