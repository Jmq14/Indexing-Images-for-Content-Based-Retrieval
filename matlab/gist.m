%Add function path
addpath('./gistdescriptor');

%Load Image
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

% Parameters
param.imageSize = [32 32]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

feature = zeros(img_num, 512);

%Feature Extraction
if img_num > 0
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = imresize(img, [32, 32]);
        img = rgb2gray(img);
        
        [feature(k,:), param] = LMgist(img, '', param);
    end
end

[COEFF, SCORE, LATENT] = pca(feature, 'NumComponents',12);

output = fopen('Gist.txt','wt');
fprintf(output, '%d\n', img_num);
for k = 1 : img_num    
    name = img_path_list(k).name;
    fprintf(output, '%s', name);
    fprintf(output, ' %f', SCORE(k,:));
    fprintf(output, '\n');
end

fclose(output);
