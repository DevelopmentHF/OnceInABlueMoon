require("states.gameoverstate")
require("components.state")
require("components.level")
require("components.moon")
require("components.entity")

Level1State = Class('Level1State', State)


function Level1State:enter()
    Entities = {}
    Level_1 = Level:new(10)
    Level_1:load()
end

function Level1State:update(dt)
	local isBlueMoonPresent = false 

    -- Update all entities
    for _, value in ipairs(Entities) do
		value:update(dt)
    end

    -- Switch to GameOverState if no blue moon remain
    if GameOverFlag then
        stateManager:switch(GameOverState:new())
    end
end

function Level1State:draw()
    love.graphics.push()
    love.graphics.scale(ScalingFactor, ScalingFactor)
    
    love.graphics.setColor(0, 0, 1, 0.7)
    love.graphics.draw(Bg)
    love.graphics.setColor(1, 1, 1, 1)

    -- Draw all entities
    for _, value in ipairs(Entities) do
        value:draw()
    end

    love.graphics.pop()
end

