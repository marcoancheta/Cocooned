
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
	backgroundMusic = nil,
	soundEffects = {},
}
local name

local sfx, bgm, narrator

-- Reserve 3 main channels (SFX, Narration, BGM)
audio.reserveChannels(3)

-- Channel 1 = SFX, Channel 2 = Narration, Channel 3 = BGM
audio.setVolume(1, {channel = 1} )
audio.setVolume(0.5, {channel = 2} )
audio.setVolume(0.5, {channel = 3} )
--------------------------------------------------------------------------------
-- Load Sounds (Menu, In-Game)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function loadMenuSounds()
	-- BGM
	sound.backgroundMusic = audio.loadStream("sounds/bgm.mp3")
	-- Menu buttons click
	sound.soundEffects[1] = audio.loadSound("sounds/menu_tone.wav")
	
	return backgroundMusic, soundEffects
end

local function loadGameSounds()
	-- BGM
	--sound.backgroundMusic = audio.loadStream("sounds/bgm.mp3")

	-- Menu buttons click
	sound.soundEffects[1] = audio.loadSound("sounds/menu_tone.wav")
	-- Aura
	sound.soundEffects[2] = audio.loadSound("sounds/auraPickup.wav")
	-- Ice Cracking (NEEDS TO BE RE-ENCODED)
	--sound.soundEffects[2] = audio.loadSound("sounds/ice_cracking.wav")
	-- Orb Pickup
	sound.soundEffects[3] = audio.loadSound("sounds/orbPickup.wav")
	-- Water splash
	sound.soundEffects[4] = audio.loadSound("sounds/splash.wav")
	-- Rune pickup
	sound.soundEffects[5] = audio.loadSound("sounds/runePickup.wav")
	-- Wall collision
	sound.soundEffects[6] = audio.loadSound("sounds/wallHit.wav")
	-- Snow "ballin"
	sound.soundEffects[7] = audio.loadStream("sounds/rollSnow.wav")
	
	return soundEffects
end


--------------------------------------------------------------------------------
-- Play Sounds (SFX, Narration, BGM)
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
-- Sound Effects Music [Channel: 1]
local function playSound(name)
	sfx = audio.play(name, {channel = 1, loops = 0})
	print("play sound:", name)
	
	return sfx
end

-- Narration [Channel: 2]
local function playNarration(name)
	narrator = audio.play(name, {channel = 2, loops=0})
	print("play narration:", name)
	
	return narrator
end

-- Background Music [Channel: 3]
local function playBGM(name)
	bgm = audio.play(name, {channel = 3, loops=-1})
	print("play BGM:", name)
	
	return bgm
end

--------------------------------------------------------------------------------
-- Pause & Stop Sounds
--------------------------------------------------------------------------------
-- Updated by: Derrick
--------------------------------------------------------------------------------
local function pauseSound(chan)
	audio.pause(chan)
	print("pause sound on channel:", chan)
end

local function stop(chan, name)	
	print("stop sound on channel: ", chan)
	if chan == 1 then
		audio.stopWithDelay(100, {channel = chan})
	elseif chan == 2 then
		audio.stopWithDelay(100, {channel = chan})
	elseif chan == 3 then
		audio.stopWithDelay(100, {channel = chan})
	end
	
	--audio.dispose(name)
	--print("dispose: ", name)
	--name = nil
	--print("sound name: ", name)
end

local function soundClean()
	for i=1, #sound.soundEffects do
		audio.dispose(sound.soundEffects[i])
		sound.soundEffects[i] = nil
	end
	
	if sound.backgroundMusic then
		audio.dispose(sound.backgroundMusic)
	end
end
--------------------------------------------------------------------------------
-- Finish up
--------------------------------------------------------------------------------
-- Updated by: John
--------------------------------------------------------------------------------
sound.playSound = playSound
sound.pauseSound = pauseSound
sound.playBGM = playBGM
sound.stop = stop
sound.loadMenuSounds = loadMenuSounds
sound.loadGameSounds = loadGameSounds
sound.soundClean = soundClean
			
return sound
-- end of sound.lua