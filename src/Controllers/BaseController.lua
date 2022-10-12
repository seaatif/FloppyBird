Base = Class{}
function Base:init() end
function Base:update(dt) end
function Base:draw() end
function Base:reset() end
function Base:keypressed(key) end
function Base:updateGameLevel(level, speed) end

BaseController = Class{__includes = Base}

function BaseController:init()
    self.controllers = {}
end

function BaseController:update(dt)
    for index, controller in ipairs(self.controllers) do
        controller:update(dt)
    end
end

function BaseController:draw()
    for index, controller in ipairs(self.controllers) do
        controller:draw()
    end
end

function BaseController:keypressed(key)
    for index, controller in ipairs(self.controllers) do
       controller:keypressed(key)
    end
end

function BaseController:reset()
    for index, controller in ipairs(self.controllers) do
       controller:reset()
    end
end

function BaseController:addController(controller)
    if controller then
        table.insert(self.controllers, controller)
    end
end

function BaseController:updateGameLevel(level, speed)
    for index, controller in ipairs(self.controllers) do
        controller:updateGameLevel(level, speed)
    end
end

