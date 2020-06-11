clear all;
clc;

video = VideoReader('./video/BallTossOut.mp4');
positionX = [];
positionY = [];
j = 0;
originX = 108.7795;
originY = 240.0608;
metro = 428;
    
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
            positionX(j)=(centersBright(2,1) - originX)/metro;
            positionY(j)=(originY - centersBright(2,2))/metro;
        else
            positionX(j)=(centersBright(1,1) - originX)/metro;
            positionY(j)=(originY - centersBright(1,2))/metro;
        end
    else
        positionX(j)= (291 - originX)/metro;
        positionY(j)= (originY - 97)/metro;
    end
end














