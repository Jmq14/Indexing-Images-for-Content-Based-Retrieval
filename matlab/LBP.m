%Load Image
clear
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

output = fopen('LBP.txt','wt');
cellnum = 2;  % n = cellnum * 10;

% feature extraction
if img_num > 0
    fprintf(output, '%d\n', img_num);
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = rgb2gray(img);
        feature = extractLBPFeatures(img,'CellSize',fix(size(img)/cellnum), 'Upright',false);
        
        fprintf(output, '%s', name);
        fprintf(output, ' %f', feature);
        fprintf(output, '\n');
    end
end

fclose(output);
