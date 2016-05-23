%Add function path
addpath('./3-Gabor');
%Load Image
clear
path = ‘./image_all/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

%Set Filter
u = 5; 
v = 8;
gaborArray = gaborFilterBank(u,v,39,39); 

m = 64;
n = 64;
d1 = 4;
d2 = 4;
feature = zeros(img_num, ceil((m*n*u*v)/(d1*d2)));
%Feature Extraction
if img_num > 0
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = imresize(img, [m, n]);
        img = rgb2gray(img);
        f = gaborFeatures(img,gaborArray,d1,d2)';
        feature(k,:) = f'; 
    end
end

[COEFF, SCORE, LATENT] = pca(feature, 'NumComponents',12);


output = fopen('Gabor.txt','wt');
fprintf(output, '%d\n', img_num);
for k = 1 : img_num    
    name = img_path_list(k).name;
    fprintf(output, '%s', name);
    fprintf(output, ' %f', SCORE(k,:));
    fprintf(output, '\n');
end

fclose(output);
