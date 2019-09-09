function jigglyPuff(motor, amount)
%JIGGLYPUFF moves motor forewards and backwards by an amount
% passing no second arg defualts to 20;
%
%    ,..__
%   |  _  `--._                                  _.--"""`.
%   |   |._    `-.        __________         _.-'    ,|' |
%   |   |  `.     `-..--""_.        `""-..,-'      ,' |  |
%   L   |    `.        ,-'                      _,'   |  |
%    .  |     ,'     ,'            .           '.     |  |
%    |  |   ,'      /               \            `.   |  |
%    |  . ,'      ,'                |              \ /  j
%    `   "       ,                  '               `   /
%     `,         |                ,'                  '+
%     /          |             _,'                     `
%    /     .-"""'L          ,-' \  ,-'""""`-.           `
%   j    ,' ,.+--.\        '    ',' ,.,-"--._`.          \
%   |   / .'  L    `.        _.'/ .'  |      \ \          .
%  j   | | `--'     |`+-----'  . j`._,'       L |         |
%  |   L .          | |        | |            | |         |
%  |   `\ \        / j         | |            | |         |
%  |     \ `-.._,.- /           . `         .'  '         |
%  l      `-..__,.-'             `.`-.....-' _.'          '
%  '                               `-.....--'            j
%   .                  -.....                            |
%    L                  `---'                            '
%     \                                                 /
%      ` \                                        ,   ,'
%       `.`.    |                        /      ,'   .
%         . `._,                        |     ,'   .'
%          `.                           `._.-'  ,-'
%     _,-""""`-,                             _,'"-.._
%   ,'          `-.._                     ,-'        `.
%  /             _,' `"-..___     _,..--"`.            `.
% |         _,.-'            `"""'         `-._          \
% `-....---'                                   `-.._      |
%                                                   `--...'
if(nargin  < 2)
    amount = 20;
end

moveMotorToDegree(motor, readRotation(motor) + amount);
pause(.1);
moveMotorToDegree(motor, readRotation(motor) - amount);
pause(.1);

end

