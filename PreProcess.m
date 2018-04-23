%STEP ONE:  declare a matrix for your x values (images) and one for your y values (labels)
a = dir('C:\Users\dollowao\Desktop\cropped\*.png');
%files = {a.name};
%a = dir('path_to_images\*.FileExtension');
b = 'C:\Users\dollowao\Desktop\croppped';
%im4 = imread('C:\Users\dollowao\Desktop\cropped/01Angry.png');


numberofImages = length(a);
y_train = zeros(numberofImages, 1);


%sizeofimage = [];
%disp(sizeofimage);
%numberofPixels = size(
%x_train = zeros(numberofImages, sizeofimage);   %zeros creates a matrix and initializes all the values to zero.
%disp("HEYEYEYEYE");
%disp(x_train);
%772= number of pixels
%y_train = zeros(numberofImages, 1); %only one label per image (you can have something like 1 to represent happy, 2 to represent sad, and so on)
%disp(y_train);
for i=1:length(a) %where a is the path to the image folder
    
    file = a(i);
    filename = fullfile(file.folder,file.name);
    %disp(file);
    Image1 = imread(filename);
    %figure
    %imshow(Image1);
    
    sizeofimage = size(Image1(:));
    
    [height, width, dim] = size(Image1);
    disp(sizeofimage);
    
    x_train = zeros([numberofImages, sizeofimage]);
    
    
    %emotion define....
    %HAPPY = 1
    %SAD = 2
    %surprise = 3
    %disgust = 4
    %fear = 5
    %angry = 6
    %neutral = 7
    %read the images
    %imshow(Image1);
    %check pixel value of image
    
    %disp(sizeofimage);
    
    %determine what emotion
    find = regexp(filename,'HAPPY');
    if find
         y_train(i) = 1;
         disp('HAPPY FOUND');
    end
    %x = ['SAD'];
    find = regexp(filename,'SAD');
    if find
         y_train(i) = 2;
         disp('SAD FOUND');
         disp(filename);
    end
    
    find = regexp(filename,'SURPRISE');
    if find
         y_train(i) = 3;
         disp(filename);
    end
    
    find = regexp(filename,'DISGUST');
    if find
         y_train(i) = 4;
         disp(filename);
    end
    
    find = regexp(filename,'FEAR');
    if find
         y_train(i) = 5;
         disp(filename);
    end
    
 
    find = regexp(filename,'Angry');
    if find
         y_train(i) = 6;
         disp(filename);
         
    end
    find = regexp(filename,'Neutral');
    if find
         y_train(i) = 7;
         %disp(y_train);
  
    end
    
    
    %//create face detector object and crop image
    faceDetector = vision.CascadeObjectDetector;%used vision a build face detector
    bbox            = faceDetector(Image1);
    IFaces = insertObjectAnnotation(Image1,'rectangle',bbox,'Face');   
    
    cropped = imcrop (IFaces,bbox);% crops the face
    Image1 = cropped;%convert image1 to the cropped image
    
    %imshow(cropped);
    %rgb2gray here 
    %resize Image1 to 100x100
    
    %figure
    %imshow(Image1);
    %title('Face detected and cropped');
    
    
    %imwrite (cropped, 'C:\Users\dollowao\Desktop\IMAGES\.jpg');
    
    %//normalize images in range 0-1 where the lowest pixel value becomes 0 and the greatest becomes 1. 
    A = rgb2gray(Image1);
    
    %figure
    %imshow(A);
    %title('normal');
    
    normalizedImage = single( A ) / single( max( A(:) ) );
    
    %figure
    %imshow(normalizedImage);
    %title('NORMAL');
    
    
    %X = [2.11 3.5; -3.5 0.78];
    %round(normalizedImage,-3);
    %disp(normalizedImage);
    %disp('BEFORE');
    %normalizedImage = round(X);
    
    
    
    
    
   
    A = normalizedImage;%convert image1 to normalized image
    wavelength = 8;
    orientation = 90;
    [mag,phase] = imgaborfilt(A,wavelength,orientation);
    
    %igure
    %imshow(mag,[])
    %title('Gabor magnitude');
    
    %subplot(1,3,2);
    %imshow(mag,[])
    %title('Gabor magnitude');
    
    
    %DISPLAY GGABOR FILTERED IMAGES.....
    %figure
    %subplot(1,3,1);
    %imshow(A);
    %title('Original Image');
    
    %subplot(1,3,2);
    
    % subplot(1,3,3);
    %imshow(phase,[]);
    %title('Gabor phase');
    
    A = mag;
    
    
    %imshow(A);
    
    %//flatten image into one dimensional array
    %imshow(mag(:));
    mag = A(:);
    %disp(A);
  
    %x_train(i,:) = mag(:).';
    x_train(i) = A(i).';
    %x_train = x_train(:);
    
    %y_train = y_train(:);
    %x_train = filename;
    
    %x_train(i,:) = A(:).'; %this wouldnt work ? so ive converted mag to 1
    %dimension and X_train to 1 dimension seperately.
    %//increment imageCount
    count = i ;
    fprintf("Image Count:  ");
    disp(count);
    %disp(count);
    
end   %end of for loop
%disp (x_train);

%disp(y_train);
%figure
%imshow(x_train);

%Classification = vertcat([x_train; y_train]);

%disp(Classification);