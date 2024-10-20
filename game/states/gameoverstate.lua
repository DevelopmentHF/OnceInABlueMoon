require("components.state")

GameOverState = Class('GameOverState', State)

function GameOverState:enter()
	State.enter(self)
end

function GameOverState:update(dt)
    -- Restart the game by pressing space
    if love.keyboard.isDown("space") then
		love.audio.newSource("assets/sfx/pickupCoin.wav", "static"):play()
		GameOverFlag = false
		Difficulty = Difficulty * 0.9 -- 10% harder each level
        stateManager:switch(LevelState:new(10, 10))
    end
end

function GameOverState:draw()
	love.graphics.push()
    love.graphics.scale(ScalingFactor, ScalingFactor)

    love.graphics.setColor(0.1, 0.1, 0.5, 0.7)
    love.graphics.draw(Bg)
	love.graphics.pop()

	love.graphics.setColor(1,1,1,1)
	if GameOverFlag then
    	love.graphics.printf("Game over, you lose! Press Space to Restart", Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    	love.graphics.printf("You had " .. WinCount .. " wins", Font, 0, love.graphics.getHeight() - (love.graphics.getHeight() / 3), love.graphics.getWidth(), "center")
	else
    	love.graphics.printf("Next level! Press Space to Continue", Font, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
	end
end

