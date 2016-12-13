-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")
local scaleZoom = 4

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local kirk = {}
kirk.isBeam = true
kirk.beamLevel = 1
kirk.maxPercent = 60
kirk.image = nil
kirk.x = 0
kirk.y = 0

local sndTransporteur = love.audio.newSource("voyager_transporter.wav")

function love.load()
  
  love.graphics.setBackgroundColor(101,177,166)
  
  largeur = love.graphics.getWidth() /scaleZoom
  hauteur = love.graphics.getHeight() /scaleZoom
  
  kirk.image = love.graphics.newImage("kirk.png")
  kirk.x = math.floor(largeur/2) - math.floor(kirk.image:getWidth() / 2)
  kirk.y = math.floor(hauteur/2) - math.floor(kirk.image:getHeight() / 2)
  
  love.audio.play(sndTransporteur)
    
end

function love.update(dt)
 if kirk.isBeam then
   local coef = 0.4 * 60 * dt
   kirk.beamLevel = kirk.beamLevel + coef
   
   if kirk.beamLevel >= kirk.maxPercent then 
     
     kirk.isBeam = false
     kirk.beamLevel = 1
   end
   
   
   
  end
  
end

local mask_shader = love.graphics.newShader[[
   vec4 effect (vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).rgba == vec4(0.0)) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]

local function myStencilFunction()
  love.graphics.setShader(mask_shader)
  love.graphics.draw(kirk.image, kirk.x, kirk.y)
  love.graphics.setShader()
end

function love.draw()
    love.graphics.scale(scaleZoom, scaleZoom)
    
  if kirk.isBeam == false then
        love.graphics.draw(kirk.image, kirk.x, kirk.y)
  else
      -- kirk en filigramme
      love.graphics.setColor(255,255,255,255*( kirk.beamLevel / kirk.maxPercent))
      love.graphics.draw(kirk.image, kirk.x, kirk.y)
      
      local percent
      if kirk.beamLevel <= kirk.maxPercent / 2 then
        percent = (kirk.beamLevel * 2) / 100 
      else
        percent = ((kirk.maxPercent - kirk.beamLevel) * 2) / 100
      end
    
    local l, h = kirk.image:getWidth(), kirk.image:getHeight()
    local nbPoints = (l*h) * percent
    
    love.graphics.stencil(myStencilFunction, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    love.graphics.setColor(253, 251, 212,255)
    local np  
    for np=1,nbPoints do 
      local rx, ry = math.random(0,l-1), math.random(0, h-1)
      love.graphics.rectangle("fill", kirk.x+rx, kirk.y+ry, 1, 1) 
    end
    love.graphics.setStencilTest()
    
  end
  
  
end

function love.keypressed(key)
  
 
  
end
  