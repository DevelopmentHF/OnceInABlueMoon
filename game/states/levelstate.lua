require("components.state")
require("components.cloud")
require("components.moon")
require("components.entity")
require("components.star")
require("components.powerups.freeze")
require("states.endstate")

LevelState = Class('LevelState', State)

Tint = {1, 1, 1, 1}
Difficulty = 1.7
WinCount = 0

function LevelState:initialize(numMoons, duration)
	self.numMoons = numMoons
	self.duration = duration
	self.elapsedTime = 0

	self.nightColour = {0.1, 0.1, 0.5, 0.7}
	self.dawnColour = {1, 0.6, 0.2, 1}
	self.currentColour = self.nightColour
	Tint = self.currentColour

	self.tickTimer = 0
	self.tickInterval = 1  -- Start with 1 second between ticks

	self.tickSound = love.audio.newSource("assets/sfx/timeRunningOut.wav", "static")
end

local function generateSpawnPosition()
	local width, height = love.graphics.getWidth()/ScalingFactor, love.graphics.getHeight()/ScalingFactor -- Get screen dimensions
	local x = math.random(8, width - 8)
	local y = math.random(8, height - 8)
	
	return x, y
end

local function getAllMoons()
	-- Collect all moon instances in a separate table
	local moons = {}

	for _, entity in ipairs(Entities) do
		if entity:isInstanceOf(Moon) then
			table.insert(moons, entity)
		end
	end

	return moons
end

function LevelState:enter()
    Entities = {}

	-- load up clouds and stars for ambiance
	for i = 1, math.random(5, 15), 1 do
		local starX, starY = generateSpawnPosition()
		local newStar = Star:new(starX, starY, 1, 1, 3, 8, 8, 0.1)
		table.insert(Entities, newStar)
	end
	for i = 1, math.random(2, 7), 1 do
		local cloudX, cloudY = generateSpawnPosition()
		local newCloud = Cloud:new(cloudX, cloudY, 1, 4, 2, 8, 8, 0.4)
		table.insert(Entities, newCloud)
	end
	


	local moonRadius = 8 
	local count = 0

	math.randomseed(os.time())

    while count < self.numMoons do
		local x,y = generateSpawnPosition()
        -- Check for overlap with existing moons
        local overlap = false
        for _, moon in ipairs(Entities) do
			if moon:isInstanceOf(Moon) then
				local distance = math.sqrt((moon.position.x - x) ^ 2 + (moon.position.y - y) ^ 2)
				if distance < moonRadius * 2 then  -- Check if distance is less than the diameter
					overlap = true
					break
				end
			end
        end

        -- If no overlap, create and add the moon to the table
        if not overlap then
			local rng = math.random(1,10)
			local newMoon
			if rng % 2 == 0 then
            	newMoon = Moon:new(x, y, 1, 4, 1, 8, 8, 0.1)  -- Create a new Moon instance
			else
				newMoon = Moon:new(x, y, 1, 4, 4, 8, 8, 0.1)
			end
            table.insert(Entities, newMoon)  -- Add the moon to the moons table
			count = count + 1
			print("new moon at " .. x .." " .. y)
        end
    end

	local moons = getAllMoons()

	-- Ensure there is at least one moon
	if #moons > 0 then
		-- Randomly select one moon to be the blue moon
		local randomIndex = math.random(1, #moons)
		moons[randomIndex].isBlueMoon = true
	end

end


local function lerp(t, color1, color2)
	return {
        color1[1] + t * (color2[1] - color1[1]),
        color1[2] + t * (color2[2] - color1[2]),
        color1[3] + t * (color2[3] - color1[3]),
        color1[4] + t * (color2[4] - color1[4]),
    }
end

function LevelState:potentialPowerup(probabilty)
	math.randomseed(os.time())
	local x,y = generateSpawnPosition()
	if math.random(1, 100) <= probabilty then
		local newPowerup = Freeze:new(x, y, 1, 3, 5, 8, 8, 0.1, self)
		table.insert(Entities, newPowerup)
	end
end

function LevelState:update(dt)
	-- update timing for level 
	self.elapsedTime = self.elapsedTime + dt
	self.currentColour = lerp(math.min(self.elapsedTime/self.duration, 1), self.nightColour, self.dawnColour)
	Tint = self.currentColour

	-- Potentially spawn a powerup
	self:potentialPowerup(5) -- 5% chance per update

    -- Update all entities
    for _, value in ipairs(Entities) do
		value:update(dt)
    end

	if self.elapsedTime > self.duration then
		GameOverFlag = true
	end

	self.tickInterval = math.max(0.1, 1 - (self.elapsedTime / self.duration))
	self.tickTimer = self.tickTimer + dt

    -- If the timer exceeds the current interval, play the tick sound
    if self.tickTimer >= self.tickInterval then
        -- Play the tick sound
        if self.tickSound:isPlaying() then
            self.tickSound:stop()
        end
        self.tickSound:play()

        -- Reset the tick timer
        self.tickTimer = 0
    end	

    -- Switch to GameOverState if no blue moon remain
    if GameOverFlag then
        stateManager:switch(EndState:new())
		love.audio.newSource("assets/sfx/gameOver.mp3", "static"):play()
		Difficulty = 1.5
	elseif  #getAllMoons() == 1 then
		WinCount = WinCount + 1
        stateManager:switch(EndState:new())
    end
end


function LevelState:draw()
    love.graphics.push()
    love.graphics.scale(ScalingFactor, ScalingFactor)
   	
	-- use self.elapsedTime/self.duration to transition from night to day
    love.graphics.setColor(self.currentColour)
    love.graphics.draw(Bg)

    -- Draw all entities
    for _, value in ipairs(Entities) do
        value:draw()
    end

    love.graphics.pop()
end

