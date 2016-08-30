function love.load()
  cursor = love.graphics.newImage("cursor.png")
  love.mouse.setVisible(false)
end

function love.draw()
  love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)
end