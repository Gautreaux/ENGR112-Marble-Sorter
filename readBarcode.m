function myRequest = readBarcode(motor, sensor)
%read a barcode, generate a request for marbles

    
    fprintf("Awaiting a barcode:\n");

    %TODO: fix this;
    %a random 'barcode'
    %also note, these bardose are not representative of actual barcodes.
    myRequest = floor(randi([1 4], 1, 10)/3);
    
    power = 30;
    motor.Speed = power;
    blackMax = 30;
    bitIndex = 1;
    
    % pos is the robot's real position
    pos = 0; % Initialize to 0
    R = 63; % Radius in mm.
    l = 54;
    
    barcode = zeros(1,8);
    
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
        if (readLightIntensity(sensor, 'reflected') < blackMax)
            bit = 1;
            %playTone(brick2, 800, 0.2, 40);
        else
            bit = 0;
            %playTone(brick2, 400, 0.2, 40);
        end

        % Store the bit in the barcode array
        barcode(bitIndex) = bit;

        % Increment the bit index
        bitIndex = bitIndex + 1;

        % Rinse, repeat ;)
    end
    
    disp(barcode);
    myRequest = convert_barcode(barcode, zeros(1,10));
    
end


% Convert the barcodes
function [converted_barcode] = convert_barcode(barcode, converted_barcode)

    % Barcodes have to be flipped because of input method
    % A code of 00001 actually means a 10000. Check document to ensure this
    % is accuate.
    material = binaryCalc(barcode(1:3));    
    [large, small] = code_size_numbers(binaryCalc(barcode(4:8)) - 1);
    
    
    % b, r, w, B, R, W, t, s, l, T
    % 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    switch material
        case 1 % white
            converted_barcode(3) = converted_barcode(3) + small;
            converted_barcode(6) = converted_barcode(6) + large;
        case 2 % red
            converted_barcode(2) = converted_barcode(2) + small;
            converted_barcode(5) = converted_barcode(5) + large;
        case 3 % blue
            converted_barcode(1) = converted_barcode(1) + small;
            converted_barcode(4) = converted_barcode(4) + large;
        case 4 % steel/HDPE
            converted_barcode(8) = converted_barcode(8) + large;
            converted_barcode(9) = converted_barcode(9) + small;
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
        digit = digit + code(i)*2^(i-1);
    end
    disp(digit);

end


% code_size_numbers takes in a base ten no. and outputs the number of
% small and large pellets required
function [large, small] = code_size_numbers(code)

    large = mod(code, 4); 
    small = floor(code / 4);

end
