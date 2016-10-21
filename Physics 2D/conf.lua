function love.conf(t)
  
	t.title = "Project"         -- The title of the window the game is in (string)
	t.author = "Martin David"   -- The author
  t.version = "0.10.1"        -- The LÖVE version this game was made for (string)
	t.window.width = 800       -- The window width (number)
	t.window.height = 800       -- The window height (number)
  
  --Windows
  t.window.resizable = false   -- Let the window be user-resizable (boolean)
  t.window.minwidth = 400     -- Minimum window width if the window is resizable (number)
  t.window.minheight = 400    -- Minimum window height if the window is resizable (number)
  
end
