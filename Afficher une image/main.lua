local image
local largeur
local hauteur

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  image = love.graphics.newImage("images/pixel50.png")
  
end

function love.update(dt)

end


function love.draw()
  
  love.graphics.line(largeur/2,0,largeur/2,hauteur)
  love.graphics.line(0,hauteur/2,largeur,hauteur/2)
  
  local Lheros = image:getWidth()
  local Hheros = image:getHeight()
  
  
  
  love.graphics.draw(image, largeur/2 - Lheros/2, hauteur/2 - Hheros/2)

end