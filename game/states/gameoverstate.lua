require("components.state")

GameOverState = Class('GameOverState', State)

function GameOverState:enter()
    -- Initialize game over data
end

function GameOverState:update(dt)
    -- Restart the game by pressing space
    if love.keyboard.isDown("space") then
		GameOverFlag = false
        stateManager:switch(LevelState:new(10, 5))
    end
end

function GameOverState:draw()
	if GameOverFlag then
    	love.graphics.printf("Game over, you lose! Press Space to Restart", Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
	else
    	love.graphics.printf("You win! Press Space to Restart", Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
	end
end

