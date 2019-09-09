function doesIT = doesBSatisfyA(A,B)
%used for checking elementwise if B >=A
%this wouls be used in checking barcodes
%withe B being the sotorage Array
%and A being the current request
%
%also returns false if the request is not 10 elements long

if((length(A) ~= 10)||(length(B) ~= 10))
    doesIT = false;
    return;
end

if(sum(B>=A) == 10)
    doesIT = true;
else
    doesIT = false;
end

end

