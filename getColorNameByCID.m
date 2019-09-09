function name = getColorNameByCID(cid)
%return a color name given a CID

    switch cid
        case 0
            name = "Not a Marble";
        case 1
            name = "Blue";
        case 2
            name = "Red";
        case 3
            name = "White";
        case 4
            name = "Trash (Green)";
        case 5
            name = "Trash (Yellow)";
        case 6
            name = "Steel";
        case 7
            name = "HPDE";
end

