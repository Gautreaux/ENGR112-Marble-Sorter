clear;
clc;

brick1 = legoev3('usb'); %the brains

%the Brawn
%TODO: figure out why these cant be global variables
dispenser = motor(brick1, 'A'); %dispenser motor
revolver = motor(brick1, 'B'); %revolver motor
retreiver = motor(brick1, 'C'); % retreiver motor
barcode = motor(brick1, 'D'); %barcode motor

dispSensor = colorSensor(brick1, 1); %dispenser Color sensor
%sizeSensor = colorSensor(brick1, 2); %size selector color sensor
barcodeSensor = colorSensor(brick1, 3); 

tubeList = zeros(1,10);


%start with eveything stopped
stop(dispenser,1);
stop(revolver, 1);
stop(retreiver,1);

%TODO: figure out how to zero the dispencer/revolver
resetRotation(dispenser);
resetRotation(revolver);
resetRotation(retreiver);

%zero the retreival motor
% Give the motor its speed/power
retreiver.Speed = -50;

% Start it up
start(retreiver);

resetRotation(retreiver);

%moving it until it stalls.
lastRot = readRotation(retreiver);
pause(.5)
while(lastRot ~= readRotation(retreiver))
    lastRot = readRotation(retreiver);
    pause(.5);
end
resetRotation(retreiver);
stop(retreiver);
disp('Done zeroing retreiver')
%move the retreiver far out of the way
moveMotorToDegree(retreiver, 140);

%control when to stop the sort loop
validMarbles = 0;

%the main control loop
iterCounter = 0;
consecutiveNotAMarble = 0;
while((consecutiveNotAMarble < 10)&&(validMarbles < 80))
    fprintf("IterCounter on %4f:", iterCounter);
    
    %get the Color ID of the marble
    myMarble = getMarbleIDFromSensor(dispSensor);
    
    %if it was a valid marble then dispense, determine size
    if(myMarble ~= 0)
        %reset the break counter
        consecutiveNotAMarble = 0;
        
        %position the revolver for storgage
        moveMotorToDegree(revolver, getStorageLocationByID(myMarble));  
        
        validMarbles = validMarbles + 1; %tindex the count of marbles
    else
        %it was not a marble
        consecutiveNotAMarble = consecutiveNotAMarble + 1;
    end
    
    % align the dispenser in preparation for next round of sensing
    moveMotorToDegree(dispenser, -36*iterCounter-36);
    if(myMarble)
        jigglyPuff(dispenser);
        pause(.5);
        jigglyPuff(revolver);
    end
    %if it was a marble, index the storage array
    if(myMarble ~= 0)
        tubeList(myMarble) = tubeList(myMarble) + 1;
    end
    
    fprintf("My marble was: %s\n", getMarbleNameByID(myMarble));
    
    %increment the iteration counter
    iterCounter = iterCounter+1;
    
    %a brief pause, not strictly necessary.
    pause(2);
end

disp("Done sorting!")

%Now for the retreival phase
processedBarcodes = 0;
while(processedBarcodes < 4)
   pause(1);
   myRequest = readBarcode(barcode, barcodeSensor);
   printRequest(myRequest);
   if(doesBSatisfyA(myRequest, tubeList))
       tubeList = drain(myRequest, tubeList, revolver, retreiver);
   else
       disp("The request could not be satisfied:");
   end
   
   processedBarcodes = processedBarcodes +1;
end