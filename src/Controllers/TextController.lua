TextController = Class{__includes = Base}

-- initialize our nice-looking retro text fonts
local smallFont = love.graphics.newFont('fonts/FirstSchool.ttf', 80)
local normalFont = love.graphics.newFont('fonts/FirstSchool.ttf', 100)
local largeFont = love.graphics.newFont('fonts/GloomyThings.ttf', 140)
local scoreFont = love.graphics.newFont('fonts/GloomyThings.ttf', 90)

function TextController:init()
    love.graphics.setFont(normalFont)
end

function TextController:update(dt)

end

function TextController:draw()
    if( not love:pauseState() ) then
        -- love.graphics.setColor(0, 112, 32)
        love.graphics.setFont(scoreFont)
        love.graphics.print("Score: " .. tostring(SCORE), 50, 50)

    elseif(love:pauseState()) then
        love.graphics.setColor(0,0,0,0.5)
        love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(largeFont)

        if(gamePause) then
            love.graphics.printf(
                "PAUSE",          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 - 70,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
        elseif gameOver then
            love.graphics.setFont(normalFont)
            love.graphics.printf(
                "GAME OVER",          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 - 250,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
            
            love.graphics.setFont(largeFont)
            love.graphics.printf(
                "Your Score: " .. tostring(SCORE),          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 - 100,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
                
            love.graphics.setFont(smallFont)
            love.graphics.printf(
                "Press Enter key to continue",          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 + 100,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
        else
            love.graphics.setFont(largeFont)
            love.graphics.printf(
                "Do you want to exit ?",          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 - 100,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
                
            love.graphics.setFont(smallFont)
            love.graphics.printf(
                "Press Enter to confirm",          -- text to render
                0,                      -- starting X (0 since we're going to center it based on width)
                VIRTUAL_HEIGHT / 2 + 100,  -- starting Y (halfway down the screen)
                VIRTUAL_WIDTH,           -- number of pixels to center within (the entire screen here)
                'center')               -- alignment mode, can be 'center', 'left', or 'right'
        end
    end
end