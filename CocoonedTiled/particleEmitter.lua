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
emitterLib = {}
require("physics")
math.randomseed(os.time())
 
local Random = math.random
local msqrt = math.sqrt
local Rad = math.rad
local Sin = math.sin
local Cos = math.cos


--------------------------------------------------------------------------------
-- Create Emitter - function that creates particle emitter
--------------------------------------------------------------------------------
-- Updated by: Marco
--------------------------------------------------------------------------------
function emitterLib:createEmitter(radiusRange, thickness, particleDuration, initAlpha, endAlpha, inParticleImage, inParticleImageWidth, inParticleImageHeight)
  local customEmitter = {}
  customEmitter.radiusRange = radiusRange
  customEmitter.thickness = thickness
  customEmitter.particleDuration = particleDuration
  customEmitter.initAlpha = initAlpha
  customEmitter.endAlpha = endAlpha
  customEmitter.particleImage = inParticleImage
  customEmitter.particleImageWidth = inParticleImageWidth
  customEmitter.particleImageHeight = inParticleImageHeight
  customEmitter.colorR = nil
  customEmitter.colorG = nil
  customEmitter.colorB = nil
  customEmitter.isactive = true
  customEmitter.particale = nil
  
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
  -- Emit - function that emits particles
  --------------------------------------------------------------------------------
  -- Updated by: Marco
  --------------------------------------------------------------------------------
  function customEmitter:emit(inGFXGroup, ex, ey, physics)
    if (self.isactive and ex) then
      local radrange = self.radiusRange
      local mod_radrange = radrange * 0.3      
      local na = Random(0,359)
      local rr = Random(radrange - mod_radrange, radrange + mod_radrange)      
      local nvx,nvy = self:VecFromAngleFixed(na, rr)
      nvx = nvx + ex
      nvy = nvy + ey
      
      local particle = nil
      
      -- set particle image and set properties
      if(self.particleImage) then
        particle = display.newImage("mapdata/art/animation/particle.png")        
        particle.x = ex
        particle.y = ey
        particle.rotation = na
        particle:setFillColor(self.colorR, self.colorG, self.colorB)
      else
        -- set particle image
        particle = display.newImage("mapdata/art/animation/particle.png") 
        -- particle:scale(0.5,0.5)
        physics.addBody(particle)
        -- particle:applyTorque( 50 )
        particle.x = ex
        particle.y = ey
        particle.alpha = self.initAlpha
        if( self.colorR ~= nil) then
          if(self.colorR == -1) then
            particle:setFillColor( Random(0,255), Random(0,255), Random(0,255))
          else
            particle:setFillColor(self.colorR, self.colorG, self.colorB)
          end             
        end
      end
      
      -- move particle and destroy it once finish point is reached
      local eTrans = transition.to(particle, {time = self.particleDuration, x = nvx, y = nvy, alpha = self.endAlpha, transition = easing.outQuad, onComplete=function()
        nv = nil
        ex = nil
        ey = nil
        eTrans = nil 
        particle:removeSelf()
        particle = nil
      end})
    end
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
  
  return customEmitter
end

-- end of particleEmitter.lua