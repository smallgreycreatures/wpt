net = alexnet;
img = imread('european_shorthair_560.jpg');
img = imresize(img,[227,227]);
label = classify(net,img);
%image(img);
%title(char(label));