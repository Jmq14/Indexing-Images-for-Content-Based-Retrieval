%Load Image
clear
path = './image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

output = fopen('HOG.txt','wt');
cellnum = 4;  % n = cellnum * 10;

% feature extraction
if img_num > 0
    fprintf(output, '%d\n', img_num);
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        feature = extractHOGFeatures(img,'CellSize', fix(size(rgb2gray(img))/cellnum), 'NumBins', 4);
        
        fprintf(output, '%s', name);
        fprintf(output, ' %f', feature);
        fprintf(output, '\n');
    end
end

fclose(output);
