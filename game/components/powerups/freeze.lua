require("components.powerups.powerup")
Freeze = Class("Freeze", Powerup)


function Freeze:initialize(x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration, level)
	Powerup.initialize(self, x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration, level)
	self.message = "Freeze time!"
end

function Freeze:update(dt)
	Powerup.update(self, dt)
end

function Freeze:destroy()
	Powerup.destroy(self)
	
	-- actually apply the powerup
	self.level.elapsedTime = 0
end

function Freeze:draw()
	Powerup.draw(self)
	
	-- TODO: Can't see this. Not a priority though really
	if self.isDestroyed then
    	love.graphics.printf(self.message, Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
	end
end


