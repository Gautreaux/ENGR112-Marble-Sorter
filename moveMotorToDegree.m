function rot = moveMotorToDegree(motor,rotTarg)
%moves a motor to a target rotation

%TODO: diagnose why things are hanging -- probably resolved 10:20pm 4/13/18
%TODO: fix the hang loop that occurs sometimes -- probably resolved ^

stop(motor);

%constants defining the behavior of the rotation
%depreciation constant should always be heigher than appreciation constant
appreciationConst = 1;
depreciationConst = 15; %myChange: was 5

%the constant used to unstick the motor if it stalls
powerModifier = 0;

%fprintf('Moving motor to %d, mod: %d\n', rotTarg, mod(rotTarg,36));

%setup the last rotation to be behind the motor before it moves
if(rotTarg - readRotation(motor))  < 0
    lastRot = readRotation(motor) + 1;
else
    lastRot = readRotation(motor) - 1;
end

%loop until the motor is in the right place
while(readRotation(motor) ~= rotTarg)    
    
    %calculate the power to get to a rotation,
    p = rotTarg - readRotation(motor);
    
    %log the negative state then strip it
    %this makes the following math simpler
    neg = false;
    if(p <0)
        neg = true;
        p = p*-1;
    end
    
    %if stalled, boost the motor power
    if(readRotation(motor) == lastRot)
        %disp("appreciating");
        powerModifier = powerModifier + appreciationConst;
    else
        %if moving, reduce the boost
        %disp("depreciating");
        powerModifier = powerModifier - depreciationConst;
    end
    
    %make sure the boost modifier is inside 0<pM<99
    if(powerModifier < 0)
        powerModifier = 0;
    elseif(powerModifier > 99)
        %at this point, the motor will alwyas be at max power, and thus
        %no power will unstick it. 
        %todo: Consider backing up the trying to move foreward again
        disp("Motor running at maximum power!");
        powerModifier = 99;
        
        %change 2
        powerModifier = powerModifier - 5*depreciationConst;
        
        shimmyConstant = 15;
        
        if(neg)
           moveMotorToDegree(motor, readRotation(motor) + shimmyConstant);
        else
           moveMotorToDegree(motor, readRotation(motor) - shimmyConstant);
        end
        
        %change 2
        
    end
    
    %apply the power modifer to the motor power
    p = p + powerModifier;
    
    %if the motor power is above 100, the library gets mad
    %so we never let the power go above 100
    if(p > 99)
        p = 99;
    end
    
    %apply the negation modifier if necessary
    if(neg)
        p = p*-1;
    end
    
    %Very useful degbug info
    %fprintf("Rot: %8f, Targ: %8f, P: %8f, Mod: %8f\n", readRotation(motor), rotTarg, p, powerModifier);
    
    %update the motor speed to the new speed
    motor.Speed = p;
    start(motor);
    
    %update the rotation as it changed during the loop
    lastRot = readRotation(motor);
end

%stop the motor
stop(motor, 1);
rot = readRotation(motor);

%if we're not at the right degreee, run again, else return
if(rot ~= rotTarg)
    rot = moveMotorToDegree(motor, rotTarg);
end

