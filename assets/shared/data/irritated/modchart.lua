--Code generated using Brainy Engine ModChart Editor
--This is a little laggy, so i'm removing all X call

local easeTime

function onCreatePost()
    easeTime = ((60/curBpm)/4) * 8
end


function onStepHit()
run = curStep % 16
if run == 0  or curStep == 1 then
    noteTweenX('defaultOpponentStrumX0', 0, defaultOpponentStrumX0 + 100, easeTime, 'linear')
    noteTweenX('defaultOpponentStrumX1', 1, defaultOpponentStrumX1 + 100, easeTime, 'sineInOut')
    noteTweenX('defaultOpponentStrumX2', 2, defaultOpponentStrumX2 + 100, easeTime, 'linear')
    noteTweenX('defaultOpponentStrumX3', 3, defaultOpponentStrumX3 + 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX0', 4, defaultPlayerStrumX0 + 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX1', 5, defaultPlayerStrumX1 + 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX2', 6, defaultPlayerStrumX2 + 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX3', 7, defaultPlayerStrumX3 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY0', 0, defaultOpponentStrumY0 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY1', 1, defaultOpponentStrumY1 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY2', 2, defaultOpponentStrumY2 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY3', 3, defaultOpponentStrumY3 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2 + 100, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3 + 100, easeTime, 'sineInOut')
end
if run == 9 then
    noteTweenX('defaultOpponentStrumX0', 0, defaultOpponentStrumX0 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultOpponentStrumX1', 1, defaultOpponentStrumX1 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultOpponentStrumX2', 2, defaultOpponentStrumX2 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultOpponentStrumX3', 3, defaultOpponentStrumX3 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX0', 4, defaultPlayerStrumX0 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX1', 5, defaultPlayerStrumX1 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX2', 6, defaultPlayerStrumX2 - 100, easeTime, 'sineInOut')
    noteTweenX('defaultPlayerStrumX3', 7, defaultPlayerStrumX3 - 100, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY0', 0, defaultOpponentStrumY0, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY1', 1, defaultOpponentStrumY1, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY2', 2, defaultOpponentStrumY2, easeTime, 'sineInOut')
    --noteTweenY('defaultOpponentStrumY3', 3, defaultOpponentStrumY3, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2, easeTime, 'sineInOut')
    --noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3, easeTime, 'sineInOut')
end
end