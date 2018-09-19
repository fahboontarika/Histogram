%% imread
clc;clear all
img = imread('jpg3.jpg'); %for jpg
%img = imread('bmp3.bmp'); %for bmp
%img = imread('tif3.tif'); %for tif
%img = imread('png3.png'); %for png
%img = imread('gif3.gif'); %for gif

%% RGB to Grayscale 
g_img = rgb2gray(img);
%g_img = img;  %change for gif only

%% histogram and cdf 
a = size(g_img,1);
b = size(g_img,2);
f = zeros(1,256); %histogram
for p = 1:256
    for i = 1:a
        for j = 1:b
            if g_img(i,j)==p-1
                f(1,p)=f(1,p)+1;  % p-1 =intensity of pixel 0:255 map to f 1:256
            end
        end
    end
end
cdf = zeros(1,256);
for p = 1:256
    for k = 1:p
    cdf(1,p) = cdf(1,p)+f(1,k);
    end
end

%% Histogram Equalization 
Heq = zeros(1,256);
for p = 1:256
    Heq(1,p) = round(((cdf(1,p) - min(cdf))/((a*b) - min(cdf)))*255);
end

%% Convert to image 
new_img = zeros(a,b);
for i=1:a
    for j=1:b
        P = g_img(i,j); %%original i of g_jpg = P =0:255 has to map to Heq=1:256 so Heq use P+1
        new_img(i,j) = Heq(1,P+1); 
    end
end
eq_img = uint8(new_img);  %convert from double to uint8

%% Equalized image histogram and cdf 
a = size(eq_img,1);
b = size(eq_img,2);
eq_f = zeros(1,256); %histogram
for p = 1:256
    for i = 1:a
        for j = 1:b
            if eq_img(i,j)==p-1
                eq_f(1,p)=eq_f(1,p)+1;  % p-1 =intensity of pixel 0:255 map to f 1:256
            end
        end
    end
end
eq_cdf = zeros(1,256);
for p = 1:256
    for k = 1:p
    eq_cdf(1,p) = eq_cdf(1,p)+eq_f(1,k);
    end
end

%% Display for compare original and Equalize image
subplot(321);
imshow(g_img);
title('Original image')
subplot(322);
imshow(eq_img);
title('Equalized image')
subplot(323);
bar(f,'b');
subplot(324);
bar(eq_f,'r');
subplot(325)
plot(cdf,'b');
subplot(326)
plot(eq_cdf,'r');
