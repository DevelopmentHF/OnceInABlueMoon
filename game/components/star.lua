Star = Class("Star", Entity)

function Star:initialize(x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
	Entity.initialize(self, x, y, startFrame, endFrame, spriteRow, spriteWidth, spriteHeight, animationDuration)
end

function Star:update(dt)

end

function Star:draw()
	Entity.draw(self)
end
