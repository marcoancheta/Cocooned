windEmitterLib = {}

require("physics")
math.randomseed(os.time())
 
local Random = math.random
local msqrt = math.sqrt
local Rad = math.rad
local Sin = math.sin
local Cos = math.cos

function windEmitterLib:createEmitter(radiusRange, thickness, particleDuration, initAlpha, endAlpha, inParticleImage, inParticleImageWidth, inParticleImageHeight)
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
   
  function customEmitter:emit(inGFXGroup, ex, ey, direction, distance)
    if (self.isactive and ex) then
      local radrange = self.radiusRange
      local mod_radrange = radrange * 0.3      
      local na = Random(0,359)
      local rr =  Random(-50, 50) --Random(radrange - mod_radrange, radrange + mod_radrange)      
      local nvx,nvy = self:VecFromAngleFixed(na, rr)

      if direction == "right" then
        nvx = ex + distance 
        nvy = nvy + ey
        local exTmp = ex-80
        ex = Random(exTmp, ex)
      elseif direction == "left" then
        nvx = ex - distance 
        nvy = nvy + ey
        local exTmp = ex+80
        ex = Random(ex, exTmp)
      elseif direction == "up" then
        nvx = nvx + ex
        nvy = ey - distance
        local eyTmp = ex+80
        ey = Random(ey, eyTmp)
      elseif direction =="down" then
        nvx = nvx + ex
        nvy = ey + distance
        local eyTmp = ex-80
        ey = Random(eyTmp, ey)
      end
      
      local particle = nil
      
      if(self.particleImage) then
        particle = display.newImage("mapdata/art/wisp.png")        
        particle.x = ex
        particle.y = ey
        particle.rotation = na
        particle:setFillColor(self.colorR, self.colorG, self.colorB)
      else
        particle = display.newImage("mapdata/art/wisp.png") 
        particle.name = "wind"
        particle.func = "windCollision"
        if direction == "right" then
          particle:rotate(90)
        elseif direction == "left" then
          particle:rotate(-90)
        elseif direction == "up" then
          particle:rotate(180)
        end
        physics.addBody(particle)
        inGFXGroup:insert(particle)
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
  
  function customEmitter:destroy()
    self:Deactivate()
    self = nil
  end

  function customEmitter:endTransition()
    print("deactiving")
    self.Deactivate()
    self = nil
  end
  
  return customEmitter
end