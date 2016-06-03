%Load Image
clear
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

cellnum = 4;  

feature = zeros(img_num, 324);

% feature extraction
if img_num > 0
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        feature(k,:) = extractHOGFeatures(img,'CellSize', fix(size(rgb2gray(img))/cellnum));
    end
end

[COEFF, SCORE, LATENT] = pca(feature, 'NumComponents',12);

output = fopen('HOG.txt','wt');
fprintf(output, '%d\n', img_num);
for k = 1 : img_num    
    name = img_path_list(k).name;
    fprintf(output, '%s', name);
    fprintf(output, ' %f', SCORE(k,:));
    fprintf(output, '\n');
end
fclose(output);
