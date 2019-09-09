%Setup notes
%motors
%PORT A: dispenser
%PORT B: revolver
%PORT C: retreiver
%PORT D: barcode
%
%Sensors:
%PORT 1: dispenser Sensor
%PORT 2: size Sensor
%PORT 3: barcode sensor
%
%CID Dictionary
% 0 - Not a Marble
% 1 - Blue
% 2 - Red
% 3 - White
% 4 - Trash (Green)
% 5 - Trash (Yellow)
% 6 - Steel
% 7 - HDPE
%
%size Dictionary
% isLarge true/false -- should be self explanitory
%
%ID Dictionary
% ID -  Name       - StorageLocation RetreivalLocation
% 0  - Not Marble  - 400+ - 0
% 1  - Blue Small  - -36  - 36
% 2  - Red Small   -  0   - 72
% 3  - White Small -  36  - 108
% 4  - Blue Large  -  72  - 144
% 5  - Red Large   -  108 - 180
% 6  - White Large -  144 - -144
% 7  - Trash Small -  180 - -108
% 8  - Steel       - -144 - -72
% 9  - HPDE        - -108 - -36
% 10 - Trash Large - -72  - -1
%
%Zeroing
% Revolver should have tube 1  aligned against the touch sensor
% Dispenser should have any hole aligned above the dispenser hole
% Retreiver will self zero