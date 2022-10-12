Bird = Class{__includes = Base}

local IMG = love.graphics.newImage("images/bird.png")
local Gravity = 10

function Bird:init()
    self.height = IMG:getHeight()
    self.width = IMG:getWidth()

    self.collissionMargin = 12 -- Margin to ignore in pixels

    self:reset()

    -- RegisterEvents
    Signal.register("love.keypressed_space", function ()
        self:jump()
    end)

    Signal.register("love.mousepressed", function (button)
        self:jump()
    end)

    Signal.register("bird_passed", function ()
        if not self.birdAlive then
            self:jump()
        end
    end)
end

function Bird:update(dt)
    if self.birdAlive then
        -- apply gravity to velocity
        self.dy = self.dy + Gravity * dt
        
        -- apply current velocity to Y position
        self.y = self.y + self.dy

        self.y = math.max(self.y, 0)
        self.y = math.min(self.y, VIRTUAL_HEIGHT - self.height)
    end
end

function Bird:jump()
    self.dy = -4
    self.birdAlive = true
    Signal.emit("bird_jump")
end

function Bird:draw()
    love.graphics.draw(IMG, self.x, self.y)
end

function Bird:reset()
    -- Center Screen
    self.x = (VIRTUAL_WIDTH / 2) - (self.width / 2)
    self.y = (VIRTUAL_HEIGHT / 2) - (self.height / 2)

    -- Y velocity; gravity
    self.dy = 0
    self.birdAlive = false
end
