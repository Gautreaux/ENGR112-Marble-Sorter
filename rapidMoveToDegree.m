function rot = rapidMoveToDegree(motor, degree)
%a stripped down version of moveMotorToDegree
%should be much faster but prone to stalling

    stop(motor,1);
    motor.Speed = 0;
    
    if(readRotation(motor) < degree)
        start(motor);
        tic
        while((readRotation(motor) < degree)&&(toc  <.5))
           p = degree - readRotation(motor); 
           if(p >= 100)
               p = 99;
           end
           motor.Speed = p;
        end
    elseif(readRotation(motor) > degree)
        start(motor);
        tic
        while((readRotation(motor) > degree)&&(toc  <.5))
           p = degree - readRotation(motor); 
           if(p <= -100)
               p = -99;
           end
           motor.Speed = p;
        end
    else
        disp('Fell through if-else block');
   end

   stop(motor, 1);
    rot = readRotation(motor);
end

