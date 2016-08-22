-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

heros = {}
sprites = {}

function CreeSprite(pNomImage, pX, pY)
  
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.l = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()

  
  
  table.insert(sprites, sprite)
  
  return sprite
  
end


function love.load()
  
  love.window.setMode(1024,768)
  love.window.setTitle("Atelier Shooter Gamecodeur")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  heros = CreeSprite("heros", largeur/2, hauteur/2)
  heros.y = hauteur - (heros.h*2)
  
end

function love.update(dt)
  
  if love.keyboard.isDown("right") and heros.x < largeur then heros.x = heros.x + 2
  end

  if love.keyboard.isDown("left") and heros.x > 0 then heros.x = heros.x - 2
  end

  if love.keyboard.isDown("up") and heros.y > 0 then heros.y = heros.y - 2
  end

  if love.keyboard.isDown("down") and heros.y < hauteur then heros.y = heros.y + 2
  end

end

function love.draw()
  
  local n
  for n=1,#sprites do 
    local s = sprites[n]
    love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
  end
  
  love.graphics.line(largeur/2,0,largeur/2,hauteur)
  love.graphics.line(0,hauteur/2,largeur,hauteur/2)
  
end


-- Pour les touches qu'on presse une seule fois comme echap par exemple
function love.keypressed(key)
    
end