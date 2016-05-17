%Add function path
addpath('./Gabor');
%Load Image
clear
path = '/Users/mengqingjiang/Desktop/file/Project/DS2/DS&Alg-Project1-Release/data/image/';
img_path_list = dir(strcat(path,'*.JPEG')); 
img_num = length(img_path_list);

output = fopen('Gabor.txt','wt');

%Set Filter
gaborArray = gaborFilterBank(2,8,39,39);  % default:gaborFilterBank(5,8,39,39);


%Feature Extraction
if img_num > 0
    fprintf(output, '%d\n', img_num);
    for k = 1 : img_num
        fprintf('%dth image\n', k);
        name = img_path_list(k).name;
        img = imread(strcat(path, name));
        img = imresize(img, [16, 16]);
        img = rgb2gray(img);
        
        feature = gaborFeatures(img,gaborArray,4,4); 
        
        fprintf(output, '%s', name);
        fprintf(output, ' %f', feature);
        fprintf(output, '\n');
    end
end

fclose(output);
