local image
local largeur
local hauteur

local image_x
local image_y
local vitesse = 4



function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  image_x = 100
  image_y = 100
  
  
  image = love.graphics.newImage("images/pixel50.png")
  
  Lheros = image:getWidth()
  local Hheros = image:getHeight()

end

function love.update(dt)
  
  image_x = image_x + vitesse
  
  if image_x > largeur - Lheros and vitesse > 0 then 
    
    vitesse = - 4
    
  end
  
  if image_x < 0 and vitesse < 0 then 
    
    vitesse =  4
    
  end
  

end


function love.draw()
  
  love.graphics.line(largeur/2,0,largeur/2,hauteur)
  love.graphics.line(0,hauteur/2,largeur,hauteur/2)
  
    
  love.graphics.draw(image, image_x,image_y)

end