function id = getMarbleIDByColorSize(CID,isLarge)
%aggregates the CID and isLarge to return a marble id

    switch CID
        case 0
            %Not a Marble
            id = 0;
        case 1
            %Blue
            id = 0;
            if(isLarge)
                id = 4;
            end
        case 2
            %Red
            id = 2;
            if(isLarge)
                id = 5;
            end
        case 3
            %White
            id = 3;
            if(isLarge)
                id = 6;
            end
        case 4
            %Trash (green)
            id = 7;
            if(isLarge)
                id = 10;
            end
        case 5
            %trash (yellow)
            id = 7;
            if(isLarge)
                id = 10;
            end
        case 6
            %steel
            id = 8;
        case 7
            %HDPE
            id = 9;        
        otherwise
            fprintf("Unknown Color, Size Combination: %d, %s\n" , CID, isLarge);
            id = -1;
    end
end

