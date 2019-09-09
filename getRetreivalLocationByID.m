function rot = getRetreivalLocationByID(id)
%return a retreival location in degrees given a marble id

    switch id
        case 1 
            rot = 0;
        case 2
            rot = 36;
        case 3
            rot = 72;
        case 4
            rot = 108;
        case 5
            rot = 144;
        case 6
            rot = -180;
        case 7
            rot = -144;
        case 8
            rot = -108;
        case 9
            rot = -72;
        case 10
            rot = -36;
        otherwise
            disp("Invalid ID Provided")
            rot = "";
    end
end

