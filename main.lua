require "parallax"

function love.load()
	parallax_load(2)
	parallax_add_level(1, "stars640.png", 50, 50)
	parallax_add_level(2, "nebula640.png", 100, 100)
	
	px = 0
	py = 0
end

function love.keypressed(key, isrepeat)
	if key == "d" then px = -1 end
	if key == "a" then px = 1 end
	if key == "s" then py = -1 end
	if key == "w" then py = 1 end
end

function love.keyreleased (key)
	px = 0
	py = 0
end

function love.update(dt)
	parallax_update(dt, px, py)
end

function love.draw()
	parallax_draw()
end