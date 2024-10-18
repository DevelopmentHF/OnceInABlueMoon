require("entity")

Moon = Class("Moon", Entity)

function Moon:initialize(x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
	Entity.initialize(self, x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
	self.isBlueMoon = false
	self.isDestroyed = false

	self.animation:pauseAtStart()
end

function Moon:update(dt)
	Entity.update(self, dt)

	-- Check for mouse click
	if love.mouse.isDown(1) and not self.isDestroyed then -- 1 for left mouse button
		local mouseX, mouseY = love.mouse.getPosition()

		if self:isMouseOver(mouseX, mouseY) then
			self:destroy()
		end
	end

	-- Remove the moon after the animation plays once
	if self.isDestroyed and self.animation.position == #self.animation.frames then
		self:removeFromEntities()
	end
end

function Moon:draw()
	if self.isBlueMoon then
		love.graphics.setColor(0, 0, 1, 0.8)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end
	
	Entity.draw(self)
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
	self.isDestroyed = true -- Mark for destruction
	self.animation:resume() -- Resume the animation
	self.animation:gotoFrame(1) -- Restart the animation from the first frame
end

function Moon:removeFromEntities()
	-- Remove the moon from the Entities table
	for i, entity in ipairs(Entities) do
		if entity == self then
			table.remove(Entities, i)
			break
		end
	end
end
