Powerup = Class("Powerup", Entity)

function Powerup:initialize(x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration, level)
	Entity.initialize(self, x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)

	self.isDestroyed = false
	self.level = level
	self.animation:pauseAtStart()
end

function Powerup:update(dt)
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

-- TODO: Duplicated code with moon.lua
function Powerup:isMouseOver(mouseX, mouseY)
	local x = self.position.x * ScalingFactor
	local y = self.position.y * ScalingFactor
	local width = self.spriteWidth * ScalingFactor
	local height = self.spriteHeight * ScalingFactor

	return mouseX >= x and mouseX <= x + width and
	       mouseY >= y and mouseY <= y + height 
end

-- TODO: Duplicated code with moon.lua
function Powerup:destroy()
	self.isDestroyed = true -- Mark for destruction
	self.animation:resume() -- Resume the animation
	self.animation:gotoFrame(1) -- Restart the animation from the first frame
end

function Powerup:draw()
	Entity.draw(self)
end

-- TODO: Duplicated code with moon.lua
function Powerup:removeFromEntities()
	-- Remove the powerup from the Entities table
	for i, entity in ipairs(Entities) do
		if entity == self then
			table.remove(Entities, i)
			break
		end
	end

	local sound = love.audio.newSource("assets/sfx/powerUp.wav", "static")
	sound:setVolume(0.4)
	sound:play()
end

