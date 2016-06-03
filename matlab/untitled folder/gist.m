%Add function path
addpath('./gistdescriptor');
%Load Image
clear
path = '/Users/mengqingjiang/Desktop/file/Project/DS2/DS&Alg-Project1-Release/data/image/';
%path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

output = fopen('Gist.txt','wt');

% Parameters
clear param
param.imageSize = [256 256]; % it works also with non-square images
param.orientationsPerScale = [4 4 4 4];
param.numberBlocks = 2;
param.fc_prefilt = 4;

%Feature Extraction
if img_num > 0
    fprintf(output, '%d\n', img_num);
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = imresize(img, [16, 16]);
        img = rgb2gray(img);
        
        [feature, param] = LMgist(img, '', param);
        
        fprintf(output, '%s', name);
        fprintf(output, ' %f', feature);
        fprintf(output, '\n');
    end
end

fclose(output);
