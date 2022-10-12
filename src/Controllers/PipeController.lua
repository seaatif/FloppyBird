require("Models.PipePair")

PipeController = Class{__includes=Base}

function PipeController:init(scrollSpeed, gameLevel, bird)
    self.scrollSpeed = scrollSpeed
    self.gameLevel = gameLevel
    self.bird = bird

    self:reset()
end

function PipeController:update(dt)
    if self.lastPair.baseX - self.lastPair.x > self.horizontalGap then
        self.lastPair = PipePair(self.scrollSpeed, self.lastPair.y)
        table.insert(self.pipePairs, self.lastPair)
    end

    for index, pipePair in ipairs(self.pipePairs) do
        if pipePair.expired then
            table.remove(self.pipePairs, index)
        else
            pipePair:update(dt)
            
            if pipePair:isCollision(self.bird) then
                Signal.emit("bird_collision", self.bird, pipePair:getCollisionPipe(self.bird))
            end

            if pipePair:signalBirdPassed(self.bird) then
                Signal.emit("bird_passed", self.bird, pipePair)
            end
        end
    end
end

function PipeController:draw()
    for index, pipePair in ipairs(self.pipePairs) do
        pipePair:draw()
    end
end

function PipeController:reset()
    self.pipePairs = {}
    self.lastPair = PipePair(self.scrollSpeed, 0)
    table.insert(self.pipePairs, self.lastPair)
    self.horizontalGap = 400
end

function PipeController:updateGameLevel(level, speed)
    self.scrollSpeed = speed
    self.gameLevel = level

    if(self.horizontalGap > 150) then
        self.horizontalGap = self.horizontalGap - 50
    end

    for index, pipePair in ipairs(self.pipePairs) do
        pipePair.scroll_speed = self.scrollSpeed
    end
end
