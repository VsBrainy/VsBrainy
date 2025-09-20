function onUpdate(elapsed)
	songPos = getSongPosition()/2
	local currentBeat = (songPos/5000)*(curBpm/18)
	noteTweenY("defaultPlayerStrumY3", 4, defaultPlayerStrumX3 - 390 + 720*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenY("defaultPlayerStrumY1", 5, defaultPlayerStrumX1 - 390 + 720*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenY("defaultPlayerStrumY0", 6, defaultPlayerStrumX0 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
	noteTweenY("defaultPlayerStrumY2", 7, defaultPlayerStrumX2 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)

	noteTweenY("defaultOpponentStrumY3", 0, defaultOpponentStrumX3 + 390 - 720*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenY("defaultOpponentStrumY1", 1, defaultOpponentStrumX1 + 390 - 720*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenY("defaultOpponentStrumY0", 2, defaultOpponentStrumX0 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
	noteTweenY("defaultOpponentStrumY2", 3, defaultOpponentStrumX2 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)

	noteTweenX(defaultPlayerStrumX3, 4, defaultPlayerStrumX3 - 390 + 1280*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenX(defaultPlayerStrumX1, 5, defaultPlayerStrumX1 - 390 + 1280*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenX(defaultPlayerStrumX0, 6, defaultPlayerStrumX0 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
	noteTweenX(defaultPlayerStrumX2, 7, defaultPlayerStrumX2 - 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)

	noteTweenX(defaultOpponentStrumX3, 0, defaultOpponentStrumX3 + 390 - 1280*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenX(defaultOpponentStrumX1, 1, defaultOpponentStrumX1 + 390 - 1280*math.sin((currentBeat+10*1.5)*math.pi), 1.35)
	noteTweenX(defaultOpponentStrumX0, 2, defaultOpponentStrumX0 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
	noteTweenX(defaultOpponentStrumX2, 3, defaultOpponentStrumX2 + 210*math.sin((currentBeat+8*1.75)*math.pi), 0.00001)
end