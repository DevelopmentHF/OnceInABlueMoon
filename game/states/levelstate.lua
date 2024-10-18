require("states.gameoverstate")
require("components.state")
require("components.moon")
require("components.entity")

LevelState = Class('LevelState', State)

function LevelState:initialize(numMoons)
	self.numMoons = numMoons
end


function LevelState:enter()
    Entities = {}
	local width, height = love.graphics.getWidth()/ScalingFactor, love.graphics.getHeight()/ScalingFactor -- Get screen dimensions
	local moonRadius = 8 
	local count = 0

	math.randomseed(os.time())

    while count < self.numMoons do
        local x = math.random(moonRadius, width - moonRadius)  -- Random X position
        local y = math.random(moonRadius, height - moonRadius)  -- Random Y position

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
            local newMoon = Moon:new(x, y, 1, 4, 1, 8, 8, 0.1)  -- Create a new Moon instance
            table.insert(Entities, newMoon)  -- Add the moon to the moons table
			count = count + 1
			print("new moon at " .. x .." " .. y)
        end
    end

	-- Collect all moon instances in a separate table
	local moons = {}

	for _, entity in ipairs(Entities) do
		if entity:isInstanceOf(Moon) then
			table.insert(moons, entity)
		end
	end

	-- Ensure there is at least one moon
	if #moons > 0 then
		-- Randomly select one moon to be the blue moon
		local randomIndex = math.random(1, #moons)
		moons[randomIndex].isBlueMoon = true
	end

end

function LevelState:update(dt)
    -- Update all entities
    for _, value in ipairs(Entities) do
		value:update(dt)
    end

    -- Switch to GameOverState if no blue moon remain
    if GameOverFlag then
        stateManager:switch(GameOverState:new())
    end
end

function LevelState:draw()
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

