emitterLib = {}

require("physics")
math.randomseed(os.time())
 
local Random = math.random
local msqrt = math.sqrt
local Rad = math.rad
local Sin = math.sin
local Cos = math.cos

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
  
  function customEmitter:VecFromAngleFixed(inAngle, inVelocity)
    local vx = Cos(Rad(inAngle+90))
    local vy = Sin(Rad(inAngle+90))

    if(inVelocity ~= nil)then
      vx = vx * inVelocity
      vy = vy * inVelocity
    end
    return vx,vy
  end

  function customEmitter:Activate()
    self.isactive = true
  end
  
  function customEmitter:Deactivate()
    self.isactive = false
  end
  
  function customEmitter:setColor(red, green, blue)  
    customEmitter.colorR = red or -1
    customEmitter.colorG = green or -1
    customEmitter.colorB = blue  or -1
  end
   
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
      
      if(self.particleImage) then
        particle = display.newImage("mapdata/art/particle.png")        
        particle.x = ex
        particle.y = ey
        particle.rotation = na
        particle:setFillColor(self.colorR, self.colorG, self.colorB)
      else
        particle = display.newImage("mapdata/art/particle.png") 
        --particle:scale(0.5,0.5)
        physics.addBody(particle)
        --particle:applyTorque( 50 )
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
  
  function customEmitter:Destroy()
    self:Deactivate()
    self = nil
  end
  
  return customEmitter
end