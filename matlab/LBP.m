%Load Image
clear
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

cellnum = 4;  
featrue = zeros(img_num, 160);

% feature extraction
if img_num > 0
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = rgb2gray(img);
        feature(k,:) = extractLBPFeatures(img,'CellSize',fix(size(img)/cellnum), 'Upright',false);
    end
end

[COEFF, SCORE, LATENT] = pca(feature, 'NumComponents',12);

output = fopen('LBP.txt','wt');
fprintf(output, '%d\n', img_num);
for k = 1 : img_num    
    name = img_path_list(k).name;
    fprintf(output, '%s', name);
    fprintf(output, ' %f', SCORE(k,:));
    fprintf(output, '\n');
end
fclose(output);

