require("Models.Pipe")
PipePair = Class{}


function PipePair:init(scroll_speed, lastY)
    self.scroll_speed = scroll_speed
    self.baseX = 0
    self.safetyGap = 32
    self.lastY = lastY
    
    self.baseX = self.baseX + VIRTUAL_WIDTH + self.safetyGap
    self.x = self.baseX

    self.yMaxDiff = 100 -- Y difference of two paralall pipes
    self.y = math.random(math.max(self.lastY - self.yMaxDiff, -470), math.min(self.lastY + self.yMaxDiff, -50))

    self.gap_height = math.random(250, 350) -- adjust upper and lower difference
    self.expired = false
    self.birdPassSignaled = false

    self.pipes = {}
    self.pipes['upper'] = Pipe("upper", self.x, self.y)
    self.pipes['lower'] = Pipe("lower", self.x, self.y + self.gap_height + self.pipes.upper.height)
end

function PipePair:update(dt)
    self.x = self.x - self.scroll_speed * dt

    self.pipes.lower.x = self.x
    self.pipes.upper.x = self.x

    if(self.x < -self.pipes.lower.width - self.safetyGap) then
        self.expired = true;
    end
end

function PipePair:draw()
    self.pipes.upper:draw()
    self.pipes.lower:draw()
end


function PipePair:signalBirdPassed(bird)
    if not self.birdPassSignaled and self.pipes.upper:isBirdPassed(bird) then
        self.birdPassSignaled = true
        return true
    end

    return false
end

function PipePair:isCollision(bird)
    return (self.pipes.upper:isCollision(bird) or self.pipes.lower:isCollision(bird))
end

function PipePair:getCollisionPipe(bird)
    if (self.pipes.upper:isCollision(bird)) then
        return self.pipes.upper
    elseif(self.pipes.lower:isCollision(bird)) then
        return self.pipes.lower
    else
        return false;
    end
end