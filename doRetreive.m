% this script performs the retreival operation
%assuming the revolver is positioned properly
%and the retreiver is properly zeroed
moveMotorToDegree(retreiver, 22);
jigglyPuff(retreiver, 20);
pause(.5);
moveMotorToDegree(retreiver, 130);
pause(.5);