local BRIQUE_LARGEUR = 64
local BRIQUE_HAUTEUR = 32

local camera = {}
camera.x = (love.graphics.getWidth() / 2) - BRIQUE_LARGEUR/2
camera.y = 0

local _MapSol = {}

local _ImgTiles = {}
_ImgTiles["A"] = love.graphics.newImage("img/tile_grass.png")
_ImgTiles["B"] = love.graphics.newImage("img/tile_rock.png")

function LoadMap(  )
  
  _MapSol[1]  = "AAAAAAAAAA"
  _MapSol[2]  = "AAAAAAAAAA"
  _MapSol[3]  = "AAAAAAAAAA"
  _MapSol[4]  = "AAAAAAAAAA"
  _MapSol[5]  = "AAAAAAAAAA"
  _MapSol[6]  = "AABBBBBBAA"
  _MapSol[7]  = "AAA AAAAAA"
  _MapSol[8]  = "AAAAAAAAAA"
  _MapSol[9]  = "BAAAA AAAA"
  _MapSol[10] = "BBAAAA AAA"
  
end

function love.load()
  
  love.window.setTitle( "ISOMETRIQUE TEST" )
  love.window.setMode(800, 600, {fullscreen=false, vsync=true, minwidth=800, minheight=600})
  LoadMap()
  
end

function love.update(dt)

  if love.keyboard.isDown("right") then
    camera.x = camera.x - 5
  end
  if love.keyboard.isDown("left") then
    camera.x = camera.x + 5
  end
  if love.keyboard.isDown("up") then
    camera.y = camera.y + 5
  end
  if love.keyboard.isDown("down") then
    camera.y = camera.y - 5
  end

end

function love.draw()
  
  local ligne,colonne,char
  for ligne=1,10 do
    for colonne=1,10 do
      char = string.sub(_MapSol[ligne],colonne,colonne)
      if _ImgTiles[char] ~= nil then
        local x = (colonne - ligne) * BRIQUE_LARGEUR/2;
        local y = (colonne + ligne) * BRIQUE_HAUTEUR/2;
        love.graphics.draw(_ImgTiles[char], x + camera.x, y + camera.y)
      end
    end
  end
  
end

function love.keypressed(key)
  
  if key == "escape" then
    love.event.quit()
    return
  end
  
end
