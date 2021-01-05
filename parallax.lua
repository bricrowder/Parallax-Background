function parallax_load(c)
	-- the parallax background table
	pbg = {}
	
	-- the number of parallax background levels
	pbg.count = c
	
	-- the table that holds the number of parallax level information
	pbg.levels = {}
	
	-- create the tables for each set of level information
	local i
	for i = 1, pbg.count do
		-- the level table
		pbg.levels[i] = {}
	end
end

function parallax_unload()
	local i
	
	for i = 1, pbg.count do
		pbg.levels[i].img = nil
	end
	
	pbg.levels = nil
	pbg = nil
end


function parallax_add_level(i, img, sx, sy)
	-- set the picture
	pbg.levels[i].img = love.graphics.newImage(img)
	
	-- the "speeds" of the horizontal and vertical movement
	pbg.levels[i].speed_x = sx
	pbg.levels[i].speed_y = sy
	
	-- initialize the offset
	pbg.levels[i].offset_x = 0
	pbg.levels[i].offset_y = 0
	
	
	-- figure out how many images you need to repeat to cover the window
	-- get the window dimensions
	local w, h = love.graphics.getDimensions()
	
	-- width
	-- if the image divides equally: the number of images + 1
	if w % pbg.levels[i].img:getWidth() == 0 then
		pbg.levels[i].repeat_x = w / pbg.levels[i].img:getWidth() + 1
	else
	-- if the image doesn't divide equally: the number of images + 2
		pbg.levels[i].repeat_x = math.floor(w / pbg.levels[i].img:getWidth()) + 2
	end
	
	-- height
	-- if the image divides equally: the number of images + 1
	if h % pbg.levels[i].img:getHeight() == 0 then
		pbg.levels[i].repeat_y = h / pbg.levels[i].img:getHeight() + 1
	else
	-- if the image doesn't divide equally: the number of images + 2
		pbg.levels[i].repeat_y = math.floor(h / pbg.levels[i].img:getHeight()) + 2
	end	
end

function parallax_update(dt, px, py)
	local i
	
	for i = 1, pbg.count do
		-- calculate the new offset position for the parallax layer by the layer speed, time passed (dt) and the player direction (dx, dy)
		if px ~= 0 then 
			pbg.levels[i].offset_x = pbg.levels[i].offset_x + pbg.levels[i].speed_x * dt * px
			-- reset offset - left most bounds			
			if pbg.levels[i].offset_x < pbg.levels[i].img:getWidth() * -1 then pbg.levels[i].offset_x = pbg.levels[i].offset_x + pbg.levels[i].img:getWidth() end
			-- reset offset - right most bounds
			if pbg.levels[i].offset_x > 0 then pbg.levels[i].offset_x = pbg.levels[i].img:getWidth() * -1 + pbg.levels[i].offset_x end			
		end
		
		if py ~= 0 then
			pbg.levels[i].offset_y = pbg.levels[i].offset_y + pbg.levels[i].speed_x * dt * py
			-- reset offset - left most bounds			
			if pbg.levels[i].offset_y < pbg.levels[i].img:getHeight() * -1 then pbg.levels[i].offset_y = pbg.levels[i].offset_y + pbg.levels[i].img:getHeight() end
			-- reset offset - right most bounds
			if pbg.levels[i].offset_y > 0 then pbg.levels[i].offset_y = pbg.levels[i].img:getHeight() * -1 + pbg.levels[i].offset_y end			
		end
	end
end


function parallax_draw()
	local i, j, k

	-- loop through all the parallax layers
	for i = 1, pbg.count do
		-- loop through the y axis
		for j = 0, pbg.levels[i].repeat_y - 1 do
			-- loop through the x axis
			for k = 0, pbg.levels[i].repeat_x - 1 do
				local x, y
				x = k * pbg.levels[i].img:getWidth() + pbg.levels[i].offset_x
				y = j * pbg.levels[i].img:getHeight() + pbg.levels[i].offset_y
				love.graphics.draw(pbg.levels[i].img, x, y)
			end 
		end
	end
end
