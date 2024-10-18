require("components.state")

GameOverState = Class('GameOverState', State)

function GameOverState:enter()
    -- Initialize game over data
end

function GameOverState:update(dt)
    -- Restart the game by pressing space
    if love.keyboard.isDown("space") then
		GameOverFlag = false
        stateManager:switch(Level1State:new())
    end
end

function GameOverState:draw()
    love.graphics.printf("Game Over! Press Space to Restart", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
end

