--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- particleEmitter.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- lua class that holds functionality for particle emission

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
require("physics")
math.randomseed(os.time())

auraEmitterLib = {}
 
local Random = math.random
local msqrt = math.sqrt
local Rad = math.rad
local Sin = math.sin
local Cos = math.cos
local colors ={
            ['white'] = {1,1,1},
            ['red'] = {1,0.5,0.5}, 
            ['green'] = {0.5,1,0.5},
            ['blue'] = {0.5,0.5,1}
          }


--------------------------------------------------------------------------------
-- Create Emitter - function that creates particle emitter
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function auraEmitterLib:createEmitter(radiusRange, particleDuration, initAlpha, endAlpha, inParticleImage, inParticleImageWidth, inParticleImageHeight)
  local customEmitter = {}
  local particles = {}
   
  customEmitter.radiusRange = radiusRange
  customEmitter.particleDuration = particleDuration
  customEmitter.initAlpha = initAlpha
  customEmitter.endAlpha = endAlpha
  customEmitter.particleImage = inParticleImage
  customEmitter.particleImageWidth = inParticleImageWidth
  customEmitter.particleImageHeight = inParticleImageHeight
  customEmitter.isactive = true
  customEmitter.particle = nil
  for i=1, 20 do
    local randX 
    local randY
    local randRange = false
    local maxDist = 30
    local minDist = 10
    while randRange == false do
      randY =Random(currPlayer.imageObject.y - maxDist, currPlayer.imageObject.y + maxDist)
      randX =Random(currPlayer.imageObject.x - maxDist, currPlayer.imageObject.x + maxDist)
      if (randY > currPlayer.imageObject.y + minDist or randY < currPlayer.imageObject.y - minDist) and (randX > currPlayer.imageObject.x + minDist or randX < currPlayer.imageObject.x - minDist)then
        randRange = true
      end
    end
    randRange=false
    p=emit(levelGroup, randX, randY, currPlayer, physics)
    particles.append(p)
  end


  
  --------------------------------------------------------------------------------
  -- VecFromAngleFixed - function that gets angle and velcity of particle
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:VecFromAngleFixed(inAngle, inVelocity)
    local vx = Cos(Rad(inAngle+90))
    local vy = Sin(Rad(inAngle+90))

    if(inVelocity ~= nil)then
      vx = vx * inVelocity
      vy = vy * inVelocity
    end
    return vx,vy
  end

  --------------------------------------------------------------------------------
  -- Activate - function that starts emitter
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:Activate()
    self.isactive = true
  end
  
  --------------------------------------------------------------------------------
  -- Deactivate - function that stops emitter from emitting particles
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:Deactivate()
    self.isactive = false
  end
  
  --------------------------------------------------------------------------------
  -- Set Color - function that sets color of particle
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:setColor(red, green, blue)  
    customEmitter.colorR = red or -1
    customEmitter.colorG = green or -1
    customEmitter.colorB = blue  or -1
  end
  
  --------------------------------------------------------------------------------
  -- Destroy - destroys particle emitter
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:Destroy()
    self:Deactivate()
    self = nil
  end

  function customEmitter:moveParticles()
    local circleD = 320
    local circle = display.newCircle(display.contentWidth/2,display.contentHeight/2,circleD)
    circle:setReferencePoint(display.CenterReferencePoint)
    local circleC = math.pi * circleD




  --------------------------------------------------------------------------------
  -- Emit - function that emits particles
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function emit(inGFXGroup, ex, ey, player, physics)
      local radrange = self.radiusRange
      local mod_radrange = radrange * .3      
      local na = Random(0,359)
      local rr = Random(radrange - mod_radrange, radrange + mod_radrange)      
      local nvx,nvy = self:VecFromAngleFixed(na, rr)
      nvx = nvx + ex
      nvy = nvy + ey
      
      local particle = nil
      -- set particle circle
      particle = display.newCircle(ex, ey, 5)
      particle.x = ex
      particle.y = ey
      particle.alpha = self.initAlpha
      local c = colors[player.color]
      particle:setFillColor( c[1], c[2], c[3])
      
      -- move particle and destroy it once finish point is reached
      physics.addBody(particle)
      particle.isSensor = true
      local distanceJoint = physics.newJoint( "distance", particle, player.field, particle.x, particle.y, player.field.x, player.field.y )
      distanceJoint.frequency = 5
      distanceJoint.dampingRatio = .1
      distanceJoint.length = math.sqrt((player.field.y-particle.y)*(player.field.y-particle.y) + (player.field.y-particle.y)*(player.field.y-particle.y))
      if (player.field.y-particle.y) >= 0 then
        particle:applyForce( .8, 0, particle.x, particle.y )
      else
        particle:applyForce( -.8, 0, particle.x, particle.y )
      end
      particle.name = "auraParticle"
      particle.collType = "passThru"
      particle.func = "auraParticleCollision"
      local eTrans = transition.to(particle, {time = self.particleDuration, alpha = self.endAlpha, transition = easing.outQuad, onComplete=function()
        nvx = nil
        nvy = nil
        nv = nil
        na = nil
        ex = nil
        ey = nil
        eTrans = nil
        distanceJoint:removeSelf()
        distanceJoint=nil
        particle:removeSelf()
        particle = nil
      end})
      return particle
  end 
-- end of particleEmitter.lua
  
  return customEmitter
end
end
