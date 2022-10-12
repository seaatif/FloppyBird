Pipe = Class{}

local IMG = love.graphics.newImage("images/pipe.png")

function Pipe:init(orientation, x, y)
    self.x = x
    self.y = y

    self.isUpper = orientation == "upper"

    self.height = IMG:getHeight()
    self.width = IMG:getWidth()
end

function Pipe:updateXY(x, y)
    self.x = x
    self.y = y
end

function Pipe:draw()
    if(self.isUpper) then
        love.graphics.draw(IMG, self.x, self.y+self.height, 0, 1, -1)
    else
        love.graphics.draw(IMG, self.x, self.y)
    end
end

function Pipe:isCollision(bird)
    if(bird.x + bird.width > self.x + bird.collissionMargin and bird.x + bird.collissionMargin < self.x + self.width) then
        if (self.isUpper and bird.y + bird.collissionMargin < self.y + self.height) then
            return true
        elseif(not self.isUpper and bird.y + bird.height > self.y + bird.collissionMargin) then
            return true
        end
    end
    return false
end

function Pipe:isBirdPassed(bird)
    return (bird.x + bird.collissionMargin > self.x + self.width/2)
end