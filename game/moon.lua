require("entity")

Moon = Class("Moon", Entity)

function Moon:initialize(x, y, spriteRow, spriteCol, spriteWidth, spriteHeight)
	Entity.initialize(self, x, y, spriteRow, spriteCol, spriteWidth, spriteHeight)	
end

function Moon:update(dt)
	-- if moon clicked, destory
end
