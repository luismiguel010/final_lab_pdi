clear all;
clc;

video = VideoReader('./video/BallTossOut.mp4');
positionX = [];
positionY = [];
j = 0;
%numImgs = get(video, 'NumberOfFrames');
%frames = read(video);
%frameEspecific = read(video,21);
%framGray = rgb2gray(frameEspecific);
%imshow(framGray)

%    Rmin = 1; Rmax = 4;
%    [centersBright, radiiBright] = imfindcircles(framGray,[Rmin Rmax],'ObjectPolarity','bright');
%    viscircles(centersBright, radiiBright,'Color','b');
    
for i=10:29
    frameEspecific = read(video,i);
    framGray = rgb2gray(frameEspecific);
    Rmin = 1; Rmax = 4;
    [centersBright, radiiBright] = imfindcircles(framGray,[Rmin Rmax],'ObjectPolarity','bright');
    valueMax450 = find(centersBright>450);
    [m,n] = size(centersBright);
    j = j + 1;
    if(m~=0)
        if(valueMax450==3)
            positionX(j)=centersBright(2,1);
            positionY(j)=centersBright(2,2);
        else
            positionX(j)=centersBright(1,1);
            positionY(j)=centersBright(1,2);
        end
    else
        positionX(j)=291;
        positionY(j)=97;
    end
end














