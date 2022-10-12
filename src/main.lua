
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'libraries.push'


-- size we're trying to emulate with push
VIRTUAL_WIDTH = 1742
VIRTUAL_HEIGHT = 980

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'libraries.hump.class'
Signal = require 'libraries.hump.signal'

require("Controllers.BaseController")
require("Controllers.Background")
require("Controllers.PipeController")
require("Controllers.TextController")
require("Controllers.SoundController")

require("Models.Bird")

BG_SPEED = 30
GAME_SPEED = 60
Controllers = BaseController()
SCORE = 0
LEVEL = 1

gameOver = false
gamePause = false
exitConfirm = false

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.window.setTitle('Floppy Bird Returns')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())



    local window_width,window_height = love.window.getDesktopDimensions()

    local isFullScreen = false

    if  (not isFullScreen) then
        ---@diagnostic disable-next-line: cast-local-type
        window_width = window_width - 142 
        ---@diagnostic disable-next-line: cast-local-type
        window_height = window_height - 80
    end

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, window_width, window_height, {
        fullscreen = isFullScreen,
        resizable = true,
        vsync = true,
        canvas = false
    })

    Controllers:addController(Background(BG_SPEED, GAME_SPEED))
    local bird = Bird()
    Controllers:addController(PipeController(GAME_SPEED, 1, bird))
    Controllers:addController(bird)
    Controllers:addController(TextController())
    Controllers:addController(SoundController())

    Signal.register("bird_collision", function (bird, pipe)
        gameOver = true
    end)

    Signal.register("bird_passed", function (bird, pipePair)
        SCORE = SCORE + 1

        if SCORE % 10 == 0 then
            GAME_SPEED = GAME_SPEED * 1.2
            LEVEL = LEVEL + 1
            Controllers:updateGameLevel(LEVEL, GAME_SPEED)
        end
    end)
end

-- Callback whenever the key is pressed.
function love.keypressed(key)
    if (key == 'return' and exitConfirm) or (key == "escape" and gameOver) then
        love.event.quit()
    elseif key == "return" and not gameOver then
        gamePause = not gamePause
        Signal.emit("game_pause", gamePause)
    elseif key == 'return' and gameOver then
        love:resetGame()
    elseif key == "escape" then
        exitConfirm = not exitConfirm
    elseif key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end

    Signal.emit("love.keypressed", key)
    Signal.emit("love.keypressed_" .. key)
end

function love.mousepressed(x, y, button)
    Signal.emit('love.mousepressed', button)
    Signal.emit('love.mousepressed_btn_' .. button)
end

function love.update(dt)
    if(not love:pauseState()) then
        Controllers:update(dt)
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    push:start()

    love.graphics.setColor(255,255,255)
    Controllers:draw()

    push:finish()
end

function love.resize(w, h)
    return push:resize(w, h)
end

function love:resetGame()
    gameOver = false
    gamePause = false
    SCORE = 0
    LEVEL = 1
    GAME_SPEED = 60
    LEVEL = 1
    Controllers:updateGameLevel(LEVEL, GAME_SPEED)
    Controllers:reset()
end

function love:pauseState()
    if(gamePause or gameOver or exitConfirm) then
        return true
    end
    return false
end