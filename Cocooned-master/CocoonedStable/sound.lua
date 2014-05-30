
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- sound.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Require(s) / Global Variables
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
local gameData = require("Core.gameData")

local sound = {
	backgroundMusic = {},
	soundEffects = {},
}

local name
local sfx, bgm, narrator

-- Reserve 3 main channels (SFX, Narration, BGM)
audio.reserveChannels(5)

-- Channel 1 = SFX, Channel 2 = Narration, Channel 3 = BGM
audio.setVolume(0.5, {channel = 1} )
audio.setVolume(0.5, {channel = 2} )
audio.setVolume(0.5, {channel = 3} )
audio.setVolume(0.5, {channel = 4} )
audio.setVolume(0.5, {channel = 5} )

--------------------------------------------------------------------------------
-- Load Sounds (Menu, In-Game)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function loadMenuSounds()
	-- BGM
	-- Menu Music 
	sound.backgroundMusic[1] = audio.loadStream("sounds/music/Soliloquy.mp3") -- or FallOfArcana.mp3
	-- Menu buttons click
	sound.soundEffects[1] = audio.loadSound("sounds/menu_tone.wav")
	-- Snow "ballin" [Note: this is a steam]
	sound.soundEffects[2] = audio.loadSound("sounds/rolling.wav")
	
	return backgroundMusic, soundEffects
end

---------------------------------------------------------------------------
--- loadGameSounds() - Load all sounds that are going to be used in game
---------------------------------------------------------------------------
local function loadGameSounds()
	if gameData.debugMode then
		print("LOADED SOUNDS")
	end
	-- BGM
	-- World 1 music 
	sound.backgroundMusic[1] = audio.loadStream("sounds/music/FallOfArcana.mp3")
	-- World 2 music
	sound.backgroundMusic[2] = audio.loadStream("sounds/music/ArtemisMenu.mp3")
	-- World 3 music
	sound.backgroundMusic[3] = audio.loadStream("sounds/music/Spiritwatcher.mp3")
	-- Level Complete Music
	sound.backgroundMusic[4] = audio.loadStream("sounds/music/levelComplete.mp3")

	-- Menu buttons click
	sound.soundEffects[1] = audio.loadSound("sounds/menuButton.wav")
	-- New Aura Pickup - pending review to replace old sound
	sound.soundEffects[2] = audio.loadSound("sounds/auraPickupNew.wav")
	-- Wind (pane transition)
	sound.soundEffects[3] = audio.loadSound("sounds/wind.wav")
	-- Water splash
	sound.soundEffects[4] = audio.loadSound("sounds/splash.wav")
    -- Rushing water sound - pending review to replace ice cracking sound
	sound.soundEffects[5] = audio.loadSound("sounds/rushingWater.wav")
	-- Wall collision
	sound.soundEffects[6] = audio.loadSound("sounds/wallHit.wav")
	-- Snow "ballin" [Note: this is a steam]
	sound.soundEffects[7] = audio.loadSound("sounds/rolling.wav")
	-- Pick up "key" (used for wisps)
	sound.soundEffects[8] = audio.loadSound("sounds/wispPickup.wav")
	-- Wall Breaking Rune Pickup
	sound.soundEffects[9] = audio.loadSound("sounds/runePickupWallBreak.wav")
	-- Time Slowing Rune Pickup
	sound.soundEffects[10] = audio.loadSound("sounds/runePickupTimeSlow.wav")
	-- Movable walls Rune Pickup
	sound.soundEffects[11] = audio.loadSound("sounds/runePickupMovableWalls.wav")
	--Level exit portal sound
	sound.soundEffects[12] = audio.loadSound("sounds/enterPortal.wav")
	--Fish sound
	sound.soundEffects[13] = audio.loadSound("sounds/fish.wav")
	-- Stars end transition sound
	sound.soundEffects[14] = audio.loadSound("sounds/balloon_pop.wav")
	
	return backgroundMusic, soundEffects
end

--------------------------------------------------------------------------------
-- Sound controller
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function setVolume(chan, int)
	local sim = (int/10)
	audio.setVolume(sim, { channel=chan })
	
	if chan == 1 then
		gameData.sfxVolume = sim
		audio.setVolume(sim, { channel=4 })
		audio.setVolume(sim, { channel=5 })
	elseif chan == 3 then
		gameData.bgmVolume = sim
	end
end

--------------------------------------------------------------------------------
-- Pause & Stop Sounds
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function resumeSound(int)
	if int == 1 then
		audio.resume(sfx)
	elseif int == 2 then
		audio.resume(narrator)
	elseif int == 3 then
		audio.resume(bgm)
	end
end

local function pauseSound(int)
	if int == 1 then
		audio.pause(sfx)
	elseif int == 2 then
		audio.pause(narrator)
	elseif int == 3 then
		audio.pause(bgm)
	end
end

-- Stop specific channel
local function stopChannel(int)
	-- SFX
	if int == 1 then
		audio.stop(sfx)
	-- Narration/Ball Rolling
	elseif int == 2 then
		audio.stop(narrator)
	-- BGM
	elseif int == 3 then
		audio.fade(bgm)
		audio.stopWithDelay(100, {channel = 3})
	end
end

-- Stop all channels
local function stop()
	audio.stop()
end

--------------------------------------------------------------------------------
-- Play Sounds (SFX, Narration, BGM)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- Sound Effects Music [Channel: 1]
local function playSound(name)
	sfx = audio.play(name, {channel = 1, loops = 0})
	-- print("play sound:", name)	
	return sfx
end

-- Narration/Ball rolling [Channel: 2]
local function playNarration(name)
	--audio.setVolume(0.5, { channel=2 })
	narrator = audio.play(name, {channel = 2, loops=0})
	-- print("play narration:", name)
	
	return narrator
end

-- Background Music [Channel: 3]
local function playBGM(name)
	bgm = audio.play(name, {channel = 3, loops=-1})
	-- print("play BGM:", name)
	
	return bgm
end

--------------------------------------------------------------------------------
-- Clean out sounds
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function soundClean()
	if audio.isChannelPlaying(3) or audio.isChannelPlaying(2) or audio.isChannelPlaying(1)then
		audio.stop()
	end	
	
	if sound.soundEffects then
		for i=1, #sound.soundEffects do		
			audio.dispose(sound.soundEffects[i])
			sound.soundEffects[i] = nil
			--print(sound.soundEffects[i])
		end
	end
	
	if sound.backgroundMusic then
		for i=1, #sound.backgroundMusic do		
			audio.dispose(sound.backgroundMusic[i])		
			sound.backgroundMusic[i] = nil
		end
	end
end
--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
sound.playSound = playSound
sound.playNarration = playNarration
sound.playBGM = playBGM
sound.setVolume = setVolume
sound.resumeSound = resumeSound
sound.pauseSound = pauseSound
sound.stopChannel = stopChannel
sound.loadMenuSounds = loadMenuSounds
sound.loadGameSounds = loadGameSounds
sound.soundClean = soundClean
sound.stop = stop
			
return sound
-- end of sound.lua