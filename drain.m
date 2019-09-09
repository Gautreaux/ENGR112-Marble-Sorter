function tubelist = drain(reqList, tubeList, revolver, retreiver)
    %the drain function
    %perhaps the best thing here
    %does not ensure that reqList can be satisfied by tubeList

    %retreiver is used within the doretreive Script
    
    %Concepteually, drains the request list one element at a time
    
    %while there are any nonzero requests left;
    while(sum(reqList) > 0)
       %find the index of the first non-zero element
       a = find(reqList);
       a = a(1);

       %move to the right place
       moveMotorToDegree(revolver, getRetreivalLocationByID(a));

       %while the index has requests
       while(reqList(a) > 0)
           %drain a marble, update lists
           doRetreive;
           reqList(a) = reqList(a)-1;
           tubeList(a) = tubeList(a)-1;
       end
    end
    
    %return the updated tubeList
    tubelist = tubeList;
end