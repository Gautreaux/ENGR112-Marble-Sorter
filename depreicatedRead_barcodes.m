% ///////////////Barcode\\\\\\\\\\\\\\\
% Authors: Davis Kirchhofer, Seth Hamilton
% Updated: 04/13/18
% Version: 3.0
%
% This file contains taskforce 3's barcode program. It runs 4 times for 4
% barcodes and saves these binary codes in barcode. After all the barcodes
% have been collected, they get processed and converted to base 10 for
% later use.

function [converted_barcode] = read_barcodes(motor, cs)
%Sorry Seth.
%tts('Impressed yet? Dr. Godwin? Reading barcodes now.');

% Set the feeder motor speed
power = 75;
motor.Speed = power;

% This is the maximum light intensity value a black barcode strip will
% produce in ambient light.
blackMax = 30;

% This is the barcode 2-dim storage array. The robot is given 4 barcodes
% (4 rows) and every barcode has 8 bits (digits)
barcode = zeros(4, 8);

% Array that holds the base 10 version of the first three bits (material)
% in the first column and the base 10 version of the next 5 bits (num to
% dispense) in the second column.
converted_barcode = zeros(10);

% bitIndex is the column index of the current bit (not its value) in its
% respective row (which holds an entire barcode).
% e.i: [0, 1, 0, 0, 1, 0, 1, 0]; The bit index of the first 1 in
% this barcode row is 2.
bitIndex = 1;

% pos is the robot's real position
pos = 0; % Initialize to 0
R = 63; % Radius in mm.
l = 53;

for i = 1:4 % The number of barcodes received will be 4 as per the
            % Pellet Dispenser Engineering Specs    
    tic;
    while (toc < 5) 
    end

    while (bitIndex <= 8) % Every barcode (row) has 8 bits (binary digits)
        start(motor);
        resetRotation(motor);
        while (pos < l) % Where l is the distance to the next bit

            % R (radius of feeder wheel) * degree of rotation in radians =
            % arclength. pi/180 helps convert from readRotation's output to
            % radians.
            pos = R * (pi/180 * double(readRotation(motor)));

        end
        stop(motor);
        pause(0.5);
        pos = 0; % Reset the robot's rotation counter

        % Read bit
        if (readLightIntensity(cs, 'reflected') < blackMax)
            bit = 1;
            %playTone(brick2, 800, 0.2, 40);
        else
            bit = 0;
            %playTone(brick2, 400, 0.2, 40);
        end

        % Store the bit in the barcode array
        barcode(i, bitIndex) = bit;

        % Increment the bit index
        bitIndex = bitIndex + 1;

        % Rinse, repeat ;)
    end
    [converted_barcode] = convert_barcode(barcode, converted_barcode);
    % Reset the bit index;
    bitIndex = 1;
end

end

% Functions

% Convert the barcodes
function [converted_barcode] = convert_barcode(barcode, converted_barcode)

    % Barcodes have to be flipped because of input method
    % A code of 00001 actually means a 10000. Check document to ensure this
    % is accuate.
    material = binaryCalc(flip((barcode(1, 1:3))));
    [large, small] = code_size_numbers(binaryCalc(flip((barcode(1, 4:8)))) - 1);
    
    
    % b, B, r, R, w, W, t, s, l, T
    % 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    switch material
        case 1 % white
            converted_barcode(5) = converted_barcode(5) + small;
            converted_barcode(6) = converted_barcode(6) + large;
        case 2 % red
            converted_barcode(3) = converted_barcode(3) + small;
            converted_barcode(4) = converted_barcode(4) + large;
        case 3 % blue
            converted_barcode(1) = converted_barcode(1) + small;
            converted_barcode(2) = converted_barcode(2) + large;
        case 4 % steel/HDPE
            converted_barcode(8) = converted_barcode(8) + small;
            converted_barcode(9) = converted_barcode(9) + large;
        otherwise
            %Sorry Seth
            %tts('There was an error converting the barcode. Please reinsert the barcode');
    end    

end

% binaryCalc takes an array 'code' and converts it to a base
% 10 digit. code must follow convention (e.g. 10000 = 16 not 1)
function [digit] = binaryCalc (code)

    n = length(code);
    digit = 0;

    for i = 1:length(code)
        % By starting at length(code) (e.g. leftmost digit), we're
        % essentially reading a binary sequence from left to right.
        digit = digit + code(n-i+1)*2^(i-1);
    end

end

% code_size_numbers takes in a base ten no. and outputs the number of
% small and large pellets required
function [large, small] = code_size_numbers(code, data)

    large = mod(code, 4); 
    small = code / 4;

end
