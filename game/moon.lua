require("entity")

Moon = Class("Moon", Entity)

function Moon:initialize(x, y, spriteRow, spriteCol, spriteWidth, spriteHeight)
	Entity.initialize(self, x, y, spriteRow, spriteCol, spriteWidth, spriteHeight)
	self.isBlueMoon = false
end

function Moon:update(dt)
	-- Check for mouse click
	if love.mouse.isDown(1) then -- 1 for left mouse button
		local mouseX, mouseY = love.mouse.getPosition()

		if self:isMouseOver(mouseX, mouseY) then
			self:destroy()
		end
	end
end

function Moon:draw()
	if self.isBlueMoon then
		love.graphics.setColor(0, 0, 1, 0.8)
		Entity.draw(self)
	else
		love.graphics.setColor(1, 1, 1, 1)
		Entity.draw(self)
	end
	
	love.graphics.setColor(1, 1, 1, 1)
end

function Moon:isMouseOver(mouseX, mouseY)
	-- Calculate the boundaries of the moon
	local moonX = self.position.x * ScalingFactor
	local moonY = self.position.y * ScalingFactor
	local moonWidth = self.spriteWidth * ScalingFactor
	local moonHeight = self.spriteHeight * ScalingFactor

	return mouseX >= moonX and mouseX <= moonX + moonWidth and
	       mouseY >= moonY and mouseY <= moonY + moonHeight
end

function Moon:destroy()
	-- Remove the moon from the Entities table
	for i, entity in ipairs(Entities) do
		if entity == self then
			table.remove(Entities, i)
			break
		end
	end
end
