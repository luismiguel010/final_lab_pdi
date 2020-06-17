clear all;
clc;

video = VideoReader('./video/BallTossOut.mp4');
startReadFrames = 10;
finishReadFrames = 29;
positionX = [];
positionY = [];
time = [];
velocity = [];
velocitySquad = [];
energyK = [];
energyP = [];
energy = [];
j = 0;
velocityInitX = 0;
velocityInitY = 0;
originX = 108.7795;
originY = 240.0608;
originTime = 0.466;
metro = 428;
gravity = 9.8;
mass = 1;
    
for i=startReadFrames:finishReadFrames
    frameEspecific = read(video,i);
    framGray = rgb2gray(frameEspecific);
    Rmin = 1; Rmax = 4;
    [centersBright, radiiBright] = imfindcircles(framGray,[Rmin Rmax],'ObjectPolarity','bright');
    valueMax450 = find(centersBright>450);
    [m,n] = size(centersBright);
    j = j + 1;
    time(j) = video.CurrentTime - originTime;
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
    if(j == 2)
        velocityInitX = positionX(j)/time(j);
        velocityInitY = positionY(j)/time(j);
    end
    if(j == 1)
        velocitySquad(j) = 0;   
    else
        velocitySquad(j) = (velocityInitX)^2 + (velocityInitY)^2 - 2*gravity*positionY(j);
    end
        velocity(j) = sqrt(velocitySquad(j));
        energyK(j) = 0.5*mass*velocitySquad(j);
        energyP(j) = mass*gravity*positionY(j);
        energy(j) = energyK(j) + energyP(j);
end

figure
plot(time,energy,'o', time,energyK,'o', time,energyP,'o')
xlabel('Time (s)')
ylabel('Energy (J)')
legend({'Total Energy','Energy Kinetic', 'Power Energy'},'Location','southwest')

figure
plot(time,energy,'o')
xlabel('Time (s)')
ylabel('Total Energy (J)')

figure
plot(time,energyP,'o')
xlabel('Time (s)')
ylabel('Power Energy (J)')

figure
plot(time,energyK,'o')
xlabel('Time (s)')
ylabel('Kinetic Energy (J)')

figure
plot(positionY,velocitySquad,'o')
xlabel('Position Y (m)')
ylabel('Velocity Squared (m^2/s^2)')

figure
plot(time,positionY,'o')
xlabel('Time (s)')
ylabel('Position Y (m)')

figure
plot(time,positionX,'o')
xlabel('Time (s)')
ylabel('Position X (m)')
























