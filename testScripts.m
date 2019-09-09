%some testing information

clear;
clc;

brick1 = legoev3('usb'); %the brains
dispenser = motor(brick1, 'A'); %the brawn: dispenser motor

barcode = motor(brick1, 'D'); %barcode motor

stop(dispenser, 1);
resetRotation(dispenser);

barcodeSensor = colorSensor(brick1, 3); 
myBcode = readBarcode(barcode, barcodeSensor)
printRequest(myBcode);
% 
% i = 0;
% while( i < 50)
%    moveMotorToDegree(dispenser, i*-36-36);
%    i = i+1;
%    pause(2)
% end