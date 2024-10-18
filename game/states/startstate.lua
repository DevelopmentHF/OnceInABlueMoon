require("states.levelstate")
require("components.state")

StartState = Class('StartState', State)

function StartState:enter()
    -- Initialize any data for the start state
end

function StartState:update(dt)
    -- Press any key to start the game
    if love.keyboard.isDown("space") then
        stateManager:switch(LevelState:new(10, 10))
    end
end

function StartState:draw()
    love.graphics.printf("Press Space to Start", Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
end
