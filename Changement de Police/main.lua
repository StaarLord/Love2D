function love.load()
  --charge la nouvelle police dans la mémoire
  mainFont = love.graphics.newFont("blocs.ttf", 50);
 
end
 
function love.draw() 
	
  love.graphics.setFont(mainFont);
  love.graphics.print("Hello world!", 10, 10)
  
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print("Hello world!", 10, 70)
  
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.print("Hello world!", 10, 350, 0, 2, 2)
  
  love.graphics.setColor(0, 0, 255, 255)
  love.graphics.print("Hello world!", 370, 10, math.pi/2)

end

