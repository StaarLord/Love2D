debug = {}
debug.activate = true
debug.desactivate = false

mouse = {}

function love.load()
  
  -- Compteur
  counter = {}
  counter.block = 0
  
  -- Aléatoire
  randomBlockShape = love.math.random (50, 100)
  randomdensity = love.math.random (1, 9)
  
  -- Couleur aléatoire
  randomBlocksColorR = love.math.random (0, 255)
  randomBlocksColorG = love.math.random (0, 255)
  randomBlocksColorB = love.math.random (0, 255)
  
  randomBallColorR = love.math.random (0, 255)
  randomBallColorG = love.math.random (0, 255)
  randomBallColorB = love.math.random (0, 255)
  
  randomSquareColorR = love.math.random (0, 255)
  randomSquareColorG = love.math.random (0, 255)
  randomSquareColorB = love.math.random (0, 255)

  -- taille écran
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
   
  gravity = {}
  gravity.horizontal = 0
  gravity.vertical = 9.81*64
  gravity.vertical_reverse = -9.81*64
 
  -- Monde
  love.physics.setMeter(64)
  world = love.physics.newWorld(gravity.horizontal, gravity.vertical, true)
  
  -- table pour contenir tous nos objets physiques
  objects = {} 
 
  -- Sol
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, width/2, height) -- Position de l'objet
  objects.ground.shape = love.physics.newRectangleShape(width, 50) -- Largeur et hauteur de l'objet
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape, 1); -- Création d'un corp physique
  
  --Mur Gauche
  objects.wall_left = {}
  objects.wall_left.body = love.physics.newBody(world, width, height/2) -- Position de l'objet
  objects.wall_left.shape = love.physics.newRectangleShape(50, height) -- Largeur et hauteur de l'objet
  objects.wall_left.fixture = love.physics.newFixture(objects.wall_left.body, objects.wall_left.shape); -- Création d'un corp physique
  
  --Mur Droite
  objects.wall_right = {}
  objects.wall_right.body = love.physics.newBody(world, 0, height/2) -- Position de l'objet
  objects.wall_right.shape = love.physics.newRectangleShape(50, height) -- Largeur et hauteur de l'objet
  objects.wall_right.fixture = love.physics.newFixture(objects.wall_right.body, objects.wall_right.shape); -- Création d'un corp physique
 
  -- Plafond
  objects.ceiling = {}
  objects.ceiling.body = love.physics.newBody(world, width/2, 0) -- Position de l'objet
  objects.ceiling.shape = love.physics.newRectangleShape(width, 50) -- Largeur et hauteur de l'objet
  objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape); -- Création d'un corp physique
  
  -- Création d'une balle
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, width/2, height/2, "dynamic") -- Soumis à la gravitée avec l'argument "dynamic"
  objects.ball.shape = love.physics.newCircleShape(20) -- Rayon de 20
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Création d'un corp physique avec une densitée de 1
  objects.ball.fixture:setRestitution(0.9) -- Rebond
  
  -- Création d'une table pour les bloques
  objects.blocks = {}
  
  
  randomNumberBlock = love.math.random (1, 8)
  for i = 1,randomNumberBlock do
  objects.block = {}
  randomBlockX = love.math.random (51, 749)
  randomBlockY = love.math.random (51, 749)
  objects.block.body = love.physics.newBody(world, randomBlockX, randomBlockY, "dynamic")
  objects.block.shape = love.physics.newRectangleShape(50,100)
  objects.block.fixture = love.physics.newFixture(objects.block.body, objects.block.shape, 5) -- Une densité plus élevée donne plus de masse.  
  table.insert(objects.blocks, objects.block)
  counter.block = counter.block + 1
  end
  
  --Création d'une table pour les carrés
  objects.squares = {}
  
end
 
function love.update(dt)
  world:update(dt) -- Ce qui met le monde en mouvement
  mouse.x, mouse.y = love.mouse.getPosition()
  
  -- Déplacement de la balle avec le clavier
  if love.keyboard.isDown("right") then -- Appuie à droite pour que la balle se déplace a droite
    objects.ball.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then --Appuie à gauche pour que la balle se déplace a gauche
    objects.ball.body:applyForce(-400, 0)
  elseif love.keyboard.isDown("up") then -- test
    objects.ball.body:setLinearVelocity(0, -400)
  elseif love.keyboard.isDown("down") then
    objects.ball.body:setLinearVelocity(0, 600) 
  
  end
  
  function love.mousepressed( mouseX, mouseY, button, istouch ) 
     
    if button == 1 then
			objects.block = {}
      objects.block.body = love.physics.newBody(world, mouseX, mouseY, "dynamic")
			objects.block.shape = love.physics.newRectangleShape(100, 50)
			objects.block.fixture = love.physics.newFixture(objects.block.body, objects.block.shape)
			table.insert(objects.blocks, objects.block)
			objects.block.body:setLinearVelocity(1, 0)  
      counter.block = counter.block + 1
    
    elseif button == 2 then
      objects.square = {}
      objects.square.body = love.physics.newBody(world, mouseX, mouseY, "dynamic")
      objects.square.shape = love.physics.newRectangleShape(50, 50)
      objects.square.fixture = love.physics.newFixture(objects.square.body, objects.square.shape)
      table.insert(objects.squares, objects.square)
      objects.square.body:setLinearVelocity(1, 0)
      counter.block = counter.block + 1
      
		end
    
	end
  
end

function love.draw()

  -- Debug
  if debug.activate then 
    -- Compteur du nombre d'images par seconde
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 30, 30) 
    -- Quadrillage
    love.graphics.setColor(255, 255, 255, 60)
    love.graphics.line(width/2, 0, width/2, height)
    love.graphics.line(0, height/2, width, height/2)
    love.graphics.setColor(255, 255, 255)
    -- Affiche les coordonnées de la souris 
    love.graphics.print("Mouse Coordinates: " .. mouse.x .. ", " .. mouse.y, 30, 50)
    -- Affiche les coordonnées de la balle
    love.graphics.print("Ball Coordinates: " .. objects.ball.body:getX() .. ", " .. objects.ball.body:getY(), 30, 70)
    -- Affiche le nombre de bloque
    love.graphics.print("Block: " .. counter.block, 30, 90)
  
  end
  
  -- Sol
  love.graphics.setColor(208, 223, 198) 
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) 
  
  -- Plafond
  love.graphics.setColor(208, 223, 198) 
  love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints())) 
  
  -- Mur gauche 
  love.graphics.setColor(208, 223, 198) 
  love.graphics.polygon("fill", objects.wall_left.body:getWorldPoints(objects.wall_left.shape:getPoints())) 
  
  -- Mur droite 
  love.graphics.setColor(208, 223, 198) 
  love.graphics.polygon("fill", objects.wall_right.body:getWorldPoints(objects.wall_right.shape:getPoints())) 
  
  -- Balle
  love.graphics.setColor(randomBallColorR, randomBallColorG, randomBallColorB) 
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
 
  -- Bloque
  love.graphics.setColor(randomBlocksColorR, randomBlocksColorG, randomBlocksColorB) 
  love.graphics.polygon("fill", objects.block.body:getWorldPoints(objects.block.shape:getPoints()))
  
  -- Ajout d'un nouveau bloque
  love.graphics.setColor(randomBlocksColorR, randomBlocksColorG, randomBlocksColorB)
  for _, block in pairs(objects.blocks) do
  love.graphics.polygon("fill", block.body:getWorldPoints(block.shape:getPoints())) 
  end
    
  -- Ajout d'un nouveau carré
  for _, square in pairs(objects.squares) do
  love.graphics.setColor(randomSquareColorR, randomSquareColorG, randomSquareColorB)
  love.graphics.polygon("fill", square.body:getWorldPoints(square.shape:getPoints())) 
  end
  
end

function love.keypressed(k)
  
  if k == 'escape' then
    love.event.quit()
  elseif k == 'd' then
    if debug.activate then debug.activate = false; debug.desactivate = true
    elseif debug.desactivate then debug.activate = true end   

  end
  
end



