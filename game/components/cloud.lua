Cloud = Class("Cloud", Entity)

function Cloud:initialize(x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
	Entity.initialize(self, x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
	
	self.speed = math.random(2, 10)
	
	-- start at a random frame so all clouds are differnet
	math.randomseed(os.time())
	self.animation:gotoFrame(math.random(startFrame, endFrame))
end

function Cloud:update(dt)
	Entity.update(self, dt)

	-- move to the right of the screen then wrap around to the left
    self.position.x = self.position.x + self.speed * dt
    
    if self.position.x > love.graphics.getWidth()/ScalingFactor then
        self.position.x = -self.spriteWidth
    end
end

function Cloud:draw()
	Entity.draw(self)
end
