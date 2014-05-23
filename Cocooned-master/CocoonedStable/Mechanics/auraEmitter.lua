--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- auraEmitter.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for particle emission
local auraEmitterLib = {}
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
local physics = require("physics")
local auraGroup 
local Random = math.random
local msqrt = math.sqrt
local Rad = math.rad
local Sin = math.sin
local Cos = math.cos
local pi = math.pi

math.randomseed(os.time())

local colors ={
            ['white'] = {1,1,1},
            ['red'] = {238*0.0039216,81*0.0039216,88*0.0039216}, 
            ['green'] = {71*0.0039216,224*0.0039216,89*0.0039216},
            ['blue'] = {57*0.0039216,197*0.0039216,202*0.0039216}
          }
		  
--------------------------------------------------------------------------------
-- Emit - function that emits particles
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function emit(ex, ey, player, radiusRange, initAlpha, endAlpha, particleDuration, gui)
    local particle = nil
    -- set particle circle
    particle = display.newCircle(ex, ey, 5)
    --set a random starting position
    particle.iDegreeRotation = Random(0, 359)
    --set a random speed
    particle.speed = Random(1, 8)
    --calculate the random radius given to the particle
    particle.rad = msqrt(((player.imageObject.x-ex)*(player.imageObject.x-ex))+((player.imageObject.y-ey)*(player.imageObject.y-ey)))
    --insert and place particle
    --auraGroup:insert(particle)
	gui.front:insert(particle)
    particle.x = ex
    particle.y = ey
    particle.alpha = initAlpha
    local c = colors[player.color]
    particle:setFillColor( c[1], c[2], c[3])
    return particle
end 

--------------------------------------------------------------------------------
-- Create Emitter - function that creates particle emitter
--------------------------------------------------------------------------------
-- Updated by: Andrew
--------------------------------------------------------------------------------
function auraEmitterLib:createEmitter(radiusRange, particleDuration, currPlayer, initAlpha, endAlpha, inParticleImage, inParticleImageWidth, inParticleImageHeight, particleNum, gui)
	auraGroup = display.newGroup()
 
	local customEmitter = {}
		customEmitter.particles = {} 
		customEmitter.particleNum = particleNum 
		customEmitter.radiusRange = radiusRange
		customEmitter.particleDuration = particleDuration
		customEmitter.initAlpha = initAlpha
		customEmitter.endAlpha = endAlpha
		customEmitter.particleImage = inParticleImage
		customEmitter.particleImageWidth = inParticleImageWidth
		customEmitter.particleImageHeight = inParticleImageHeight
		customEmitter.isactive = true
		customEmitter.particle = nil
  
	--emit particles, since they will just be reused
	for i=1, particleNum do
		local randX 
		local randY
		local randRange = false
		local maxDist = 40
		local minDist = 25
		
		while randRange == false do
			randY =Random(currPlayer.imageObject.y - maxDist, currPlayer.imageObject.y + maxDist)
			randX =Random(currPlayer.imageObject.x - maxDist, currPlayer.imageObject.x + maxDist)
			if (randY > currPlayer.imageObject.y + minDist or randY < currPlayer.imageObject.y - minDist) and 
				(randX > currPlayer.imageObject.x + minDist or randX < currPlayer.imageObject.x - minDist) then
					randRange = true
			end
		end
		
		local p = emit(randX, randY, currPlayer, radiusRange, initAlpha, endAlpha, particleDuration, gui)
		
		p.transition = transition.to(particle, {time=Random(300, 5000), alpha = 0})
		table.insert(customEmitter.particles, p)
		--p.isVisible = false
	end

	--------------------------------------------------------------------------------
	-- Activate - function that starts emitter
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:Activate()
		self.isactive = true
	end
  
	--------------------------------------------------------------------------------
	-- Deactivate - function that stops emitter from emitting particles
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:Deactivate()
		self.isactive = creat
	end
  
	--------------------------------------------------------------------------------
	-- Set Color - function that sets color of particle
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:setColor(red, green, blue)  
		customEmitter.colorR = red or -1
		customEmitter.colorG = green or -1
		customEmitter.colorB = blue  or -1
	end
  
	--------------------------------------------------------------------------------
	-- Destroy - destroys particle emitter
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:destroy()
		self:Deactivate()
		for i=1, self.particleNum do
			if self.particles[i].transition ~= nil then
				self.particles[i].transition.cancel()
				self.particles[i].transition = nil
			end			
			self.particles[i]:removeSelf()
			self.particles[i] = nil
		end
		auraGroup:removeSelf()
		auraGroup = nil
		self = nil
	end

	--------------------------------------------------------------------------------
	-- Hide Particle - hides particles when they aren't being used
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:hideParticles()
		for i=1, self.particleNum do
			self.particles[i].isVisible = false
		end
	end

	--------------------------------------------------------------------------------
	-- Move Particle - updates particles color, alpha, and location
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:moveParticles(playerX, playerY, color) 
		for i=1, self.particleNum do
			local particle = self.particles[i]
			particle.isVisible = true
			particle.x, particle.y = playerX + particle.rad * Cos( particle.iDegreeRotation * pi / 180 ), playerY + particle.rad * Sin( particle.iDegreeRotation * pi / 180 )
			particle.iDegreeRotation = particle.iDegreeRotation+particle.speed
			
			local c = colors[color]
			
			if particle.alpha == 0 then
				particle.alpha = 1
				particle.transition = transition.to(particle, {time=Random(300, 5000), alpha = 0})
			end
		end
	end
	
	--------------------------------------------------------------------------------
	-- Change radius- changes the radius of the particles for when the ball changes size
	--------------------------------------------------------------------------------
	-- Updated by: Andrew
	--------------------------------------------------------------------------------
	function customEmitter:changeRadius(addBy)
		for i=1, self.particleNum do
			local particle = self.particles[i]
			particle.rad = particle.rad+addBy
		end
	end
	 
	return customEmitter
end

return auraEmitterLib