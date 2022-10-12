SoundController = Class{__includes = Base}

function SoundController:init()
    self.backLoop = love.audio.newSource("sounds/background-loop.mp3", "stream")
    self.backLoop:setLooping(true)
    self.backLoop:play()

    self.crashSound = love.audio.newSource("sounds/crash.mp3", "static")
    self.scoreSound = love.audio.newSource("sounds/score.mp3", "static")
    -- self.jumpSound = love.audio.newSource("sounds/jump.mp3", "static")
    
    self:registerEvents();
end

function SoundController:registerEvents()
    
    Signal.register("bird_collision", function (bird, pipe)
        self.crashSound:play()
        self.backLoop:pause()
    end)

    Signal.register("bird_passed", function (bird, pipe)
        self.scoreSound:play()
    end)

    Signal.register("bird_jump", function ()
        -- local sound = love.audio.newSource("sounds/jump.mp3", "static")
        -- sound:play()
    end)
end

function SoundController:reset()
    self.backLoop:play()
end