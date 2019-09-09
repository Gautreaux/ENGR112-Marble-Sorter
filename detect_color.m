% ///////////////detect_color\\\\\\\\\\\\\\\
% Authors: Davis Kirchhofer
%
% Updated: 04/08/18
% Version: 3.0
%
% This code runs the color sensor data collection portion of the project.
% The values are calibrated and subject to change.

function [mtype] = detect_color (mysensor)
% returns the type of marble and updates the n_marbles
  i = 0;
  while(i<10) %measure color 10 times very quickly
    i=i+1;
    pellet_color(i,:) = readColorRGB(mysensor);
    pause(.25)
    %light(i) = readLightIntensity(mysensor,'reflected');
  end
  
  n_marbles = 1;

  %create individual variables for the average measured red, green, and
  %blue values
  red = sum(pellet_color(:, 1) / i);
  green = sum(pellet_color(:, 2) / i);
  blue = sum(pellet_color(:, 3) / i);
  %light_sum = sum(light/i);
  fprintf('red = %f\ngreen = %f\nblue = %f\n',red,green,blue);
  %fprintf('light = %f\n',light_sum)

  %checek for big white marble
      n_marbles = n_marbles + 1;
  if(red>100 && green>100 && blue>90)
      fprintf('This pellet is a white pellet')
      mtype = 'w';
      return
  end

  %check for small white marble
  if(red>90 && green>70 && blue>70)
      fprintf('This pellet is a white pellet')
      mtype = 'w';
      n_marbles = n_marbles + 1;
      return
  end

  %check for big red marble
  if(red>50 && green<15 && blue<15)
      fprintf('This pellet is a red pellet')
      mtype = 'r';
      n_marbles = n_marbles + 1;
      return
  end

    %check for small red marble
  if(red>50 && green<25 && blue<15)
      fprintf('This pellet is a red pellet')
      mtype = 'r';
      n_marbles = n_marbles + 1;
      return
  end
  
   %check for big blue marble
  if((red<35 && red>10 && green<45 && green>15 && blue>5 && blue<75) || (red<10 && green<15 && blue<35 && blue>8))
      fprintf('This pellet is a blue pellet')
      mtype = 'b';
      n_marbles = n_marbles + 1;
      return
  end


  %check for small blue marble
  if((red<30 && red>8 && green<40 && green>17 && blue>40 && blue<55) || (red<10 && green>6 && green<17 && blue>8 && blue<25)) 
      fprintf('This pellet is a blue pellet')
      mtype = 'b';
      n_marbles = n_marbles + 1;
      return
  end

  %check for a translucent marble 
  if(red>35 && red<68 && green<85 && green>40 && blue>20 && blue<70)
      fprintf('This pellet is a translucent pellet')
      mtype = 'l';
      n_marbles = n_marbles + 1;
      return
  end

  %check for steel marble
  if(red>19 && red<45 && green>25 && green<61 && blue>20 && blue<40)
      fprintf('This pellet is a steel pellet')
      mtype = 's';
      n_marbles = n_marbles + 1;
      return
  end

 %check for no marble
  if(red<10 && green<10 && blue<7)
      fprintf('There is no marble currently under the sensor')
      mtype = 'n';
      return
  end
%}
  fprintf('This pellet is a trash pellet')
  mtype = 't';
  n_marbles = n_marbles + 1;

end
