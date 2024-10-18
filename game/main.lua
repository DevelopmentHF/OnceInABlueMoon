Class = require 'utils.middleclass'
Anim8 = require 'utils.anim8'
require("entity")
require("ui.button")
require("moon")
require("level")

function love.load()
	-- load up sprite stuff -> globals 
	TileWidth = 8
	TileHeight = 8
	TileSheet = love.graphics.newImage("assets/spritesheet.png")
	TileSheet:setFilter("nearest", "nearest") -- pixel perfect
	ScalingFactor = 4 -- how much bigger do we actually want to see stuff

	AnimationGrid = Anim8.newGrid(8, 8, TileSheet:getWidth(), TileSheet:getHeight())

	Entities = {}
	Level_1 = Level:new(10)
	Level_1:load()

	UIElements = {}

	-- background
	Bg = love.graphics.newImage("assets/bg.png")
	Bg:setFilter("nearest", "nearest")
end

function love.update(dt)
	-- update all entities
	for _, value in ipairs(Entities) do
		value:update(dt)
	end

	-- update all ui elements
	for _, value in ipairs(UIElements) do
		value:update(dt)
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(ScalingFactor, ScalingFactor)
	
	love.graphics.setColor(0, 0, 1, 0.7)
	love.graphics.draw(Bg)
	love.graphics.setColor(1,1,1,1)

	-- draw all entities
	for _, value in ipairs(Entities) do
		value:draw()
	end

	love.graphics.pop()

	-- draw all ui elements last!
	for _, value in ipairs(UIElements) do
		value:draw()
	end
end
