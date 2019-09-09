function rot = getStorageLocationByCID(CID)
%returns the storage location in degrees given a CID

    switch CID
        case 0
            %not a marble
            rot = -1;
        case 1
            %blues
            rot = -36;
        case 2
            %reds
            rot = 0;
        case 3
            %whites
            rot = 36;
        case 4
            %Trash (Green)
            rot = 180;
        case 5
            %Trash (Yellow)
            rot = 180;
        case 6
            %steel
            rot = -144;
        case 7
            %HDPE
            rot = -108;      
        otherwise
            disp("Unknown CID")
            disp(CID)
            rot = -1;        
    end  
end

