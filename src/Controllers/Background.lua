Background = Class{__includes=Base}

local BG_IMG = love.graphics.newImage("images/background.jpg")
local GROUND_IMG = love.graphics.newImage("images/ground.jpg")
local backgroundScroll = 0
local backgroundScroll2 = 0
local groundScroll = 0
local groundScroll2 = 0

function Background:init(bg_speed, grd_speed)
    self.bg_speed = bg_speed
    self.grd_speed = grd_speed

    backgroundScroll2 = BG_IMG:getWidth()
end

function Background:draw()
    love.graphics.draw(BG_IMG, -backgroundScroll, 0)
    love.graphics.draw(BG_IMG, -backgroundScroll2, 0)
    love.graphics.draw(GROUND_IMG, -groundScroll, VIRTUAL_HEIGHT - GROUND_IMG:getHeight())
    love.graphics.draw(GROUND_IMG, -groundScroll2, VIRTUAL_HEIGHT - GROUND_IMG:getHeight())
end

function Background:update(dt)
    backgroundScroll = (backgroundScroll + self.bg_speed * dt) % BG_IMG:getWidth()
    backgroundScroll2 = backgroundScroll - BG_IMG:getWidth()
    
    groundScroll = (groundScroll + self.grd_speed * dt) % GROUND_IMG:getWidth()
    groundScroll2 = groundScroll - GROUND_IMG:getWidth()
end

function Background:updateGameLevel(level, speed)
    self.grd_speed = speed
end
