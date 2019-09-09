function name = getMarbleNameByID(id)
%get a marble name give its marble id
    
    switch id
        case -1
            name = "Invalid Marble Id : -1. Check your code!";
        case 0 
            name = "Not a Marble";
        case 1
            name = "Blue Small";
        case 2
            name = "Red Small";
        case 3
            name = "White Small";
        case 4
            name = "Blue Large";
        case 5
            name = "Red Large";
        case 6
            name = "White Large";
        case 7
            name = "Trash Small";
        case 8
            name = "Steel";
        case 9
            name = "HPDE";
        case 10
            name = "Trash Large";
        otherwise
            name = sprintf("Unknown ID: %4f", id);
end

