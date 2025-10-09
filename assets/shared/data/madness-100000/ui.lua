local health = 'health'
local curHealth = 50

function onCreatePost()
    hideUI()
    makeLuaText(health, curHealth, 0, 10, 50, 720/2-36)
    setTextSize(health, 36)
    setTextAlignment(health, "left")
    setTextFont(health, "vcr.ttf")
    addLuaText(health)

    if not middlescroll then
        for i = 4, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') - 278)
        end
    end
    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i + 4, 'x'))
    end
end

function onUpdate()
    curHealth = getHealth()/2
    curHealth = curHealth * 100
    if curHealth > 100 then curHealth = 100 end
    if curHealth < 0 then curHealth = 0 end
    setTextString(health, "Health: " .. curHealth .. "/100")
    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.2)
    end
end

function hideUI()
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)
    setProperty('healthBarBG2.alpha', 0)
    setProperty('scoreTxt.alpha', 0)
    setProperty('timeBar.alpha', 0)
    setProperty('timeBarBG.alpha', 0)
    setProperty('timeTxt.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('misses.alpha', 0)
end