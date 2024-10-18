Gamestate = require 'utils.gamestate'
Class = require 'utils.middleclass'
Anim8 = require 'utils.anim8'
require("components.statemanager")
require("states.startstate")

function love.load()
    TileWidth = 8
    TileHeight = 8
    TileSheet = love.graphics.newImage("assets/spritesheet.png")
    TileSheet:setFilter("nearest", "nearest")
    ScalingFactor = 4

    AnimationGrid = Anim8.newGrid(8, 8, TileSheet:getWidth(), TileSheet:getHeight())

    Entities = {}
    UIElements = {}

    -- Background
    Bg = love.graphics.newImage("assets/bg.png")
    Bg:setFilter("nearest", "nearest")

    -- Initialize the StateManager and switch to the start state
	GameOverFlag = false
    stateManager = StateManager:new()
    stateManager:switch(StartState:new())
end

function love.update(dt)
    stateManager:update(dt)
end

function love.draw()
    stateManager:draw()
end

