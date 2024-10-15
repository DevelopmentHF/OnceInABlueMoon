Class = require 'middleclass'
require("entity")
require("ui.button")
require("moon")

function love.load()
	-- load up sprite stuff -> globals 
	TileWidth = 8
	TileHeight = 8
	TileSheet = love.graphics.newImage("assets/spritesheet.png")
	TileSheet:setFilter("nearest", "nearest") -- pixel perfect
	ScalingFactor = 4 -- how much bigger do we actually want to see stuff

	Entities = {}
	local exampleMoon = Moon:new(12, 12, 0, 0, 8, 8)
	table.insert(Entities, exampleMoon)

	UIElements = {}

	-- background
	Bg = love.graphics.newImage("assets/bg.png")
	Bg:setFilter("nearest", "nearest")
end

function love.update(dt)
	-- update all entities
	for index, value in ipairs(Entities) do
		value:update(dt)
	end

	-- update all ui elements
	for index, value in ipairs(UIElements) do
		value:update(dt)
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(ScalingFactor, ScalingFactor)
	
	love.graphics.draw(Bg)

	-- draw all entities
	for index, value in ipairs(Entities) do
		value:draw()
	end

	love.graphics.pop()

	-- draw all ui elements last!
	for index, value in ipairs(UIElements) do
		value:draw()
	end
end
