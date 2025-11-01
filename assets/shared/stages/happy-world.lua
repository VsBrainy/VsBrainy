function onCreate()
	-- background shit
	makeLuaSprite('happy-world', 'happy-world', -100, 150);
	setScrollFactor('happy-world', 0.9, 0.9);

	addLuaSprite('happy-world', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
        end