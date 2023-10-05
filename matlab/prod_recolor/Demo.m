% This algorithm automatically adjusts product colours according to primary colour
% change

% Copyright 2020 Han Gong, University of East Anglia

% input (must be in bmp format)
% test image list
% imgs = {'etiqueta.png'};
% n_img = numel(imgs);

blue = [0,0,127]/127;
red = [127,0,0]/127;
green = [0,127,0]/190;
yellow = [127,127,0]/127;
cyan = [0,127,127]/127;
purple = [63,0,63]/127;
magenta = [127,0,63]/127;
orange = [127,63,0]/127;
gray = [63,63,63]/127;
black = [0,0,0]/127;
white = [127,127,127]/127;

colors = {blue, red, green, yellow, cyan, purple, magenta, orange, gray, black, white};
n_colors = numel(colors);

fileList = dir('test_im/*.png');
n_files = numel(fileList);

fh = figure;

for k = 1:n_files
    for j = 1:n_colors
        % c - new colour (specify RGB values)
        c = colors{j};
    
        %imshow(repmat(reshape(c,[1,1,3]),50,50));
    
        i = im2double(imread(['test_im/',fileList(k).name]));
    
        tic;
        r = cc(i,c);
        toc;
    
        set(0, 'CurrentFigure', fh);
        clf reset;
        imshow(r);
        saveas(fh,sprintf('test_im/test/%s%d.png',fileList(k).name,j));
    end
end

% for j = 1:n_colors
%     % c - new colour (specify RGB values)
%     c = colors{j};
% 
%     %imshow(repmat(reshape(c,[1,1,3]),50,50));
% 
%     i = im2double(imread(['test_im/',imgs{id}]));
% 
%     tic;
%     r = cc(i,c);
%     toc;
% 
%     set(0, 'CurrentFigure', fh);
%     clf reset;
%     imshow(r);
%     saveas(fh,sprintf('test_im/test/FIG%d.png',j));
% end

% n_row = ceil(n_img/4+1);
% for id = 1:n_img
%     i = im2double(imread(['test_im/',imgs{id}]));
%     tic;
%     r = cc(i,c);
%     toc;
%     %subplot(n_row,4,id+1);
%     fh=figure;
%     fh.WindowState = 'minimized';
%     imshow(r);
%     saveas(fh,sprintf('test_im/test/FIG%d.png',id));
% end
