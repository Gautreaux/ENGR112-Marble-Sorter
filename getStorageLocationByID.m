function rot = getStorageLocationByID(id)
%returns the storage location in degrees provided a marble ID

    switch id
        case 1
            rot = -36;
        case 2
            rot = 0;
        case 3
            rot = 36;
        case 4
            rot = 72;
        case 5
            rot = 108;
        case 6
            rot = 144;
        case 7
            rot = 180;
        case 8
            rot = -144;
        case 9
            rot = -108;
        case 10
            rot = -72;
        otherwise
            disp("Invalid id provided to getLocation");
            rot = 4000000;
    end
end

