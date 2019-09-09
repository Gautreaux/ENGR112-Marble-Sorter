function printRequest(myRequest)
%Print a request to the console
    
    %some warnings
    if(length(myRequest) ~= 10)
        disp("The Request Provided may be invalid");
    elseif(sum(myRequest < 0))
        disp("The request Provided may be invalid");
    end
    
    fprintf("Current Request:\n")
    for i =1:10
        
        %pretty printing
        if(myRequest(i) ~= 0)
            fprintf("\t%d x %s\n", myRequest(i), getMarbleNameByID(i));
        end
    end        
end

