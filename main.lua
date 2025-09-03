love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src.Dependencies'

function love.load()
    math.randomseed(os.time())

    love.window.setTitle('Retro Games')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['start'] = function()
            return StartState()
        end,
        ['pong'] = function()
            return PongPlayState()
        end,
        ['breakout-play'] = function()
            return BreakoutPlayState()
        end,
        ['breakout-serve'] = function()
            return BreakoutServeState()
        end,
        ['breakout-victory'] = function()
            return BreakoutVictoryState()
        end,
        ['breakout-game-over'] = function()
            return BreakoutGameOverState()
        end,
        ['snake-play'] = function()
            return SnakePlayState()
        end,
        ['snake-game-over'] = function()
            return SnakeGameOverState()
        end,
        ['tetris-play'] = function()
            return TetrisPlayState()
        end,
        ['tetris-game-over'] = function()
            return TetrisGameOverState()
        end,
        ['high-scores'] = function()
            return HighScoreState()
        end,
        ['enter-high-score'] = function()
            return EnterHighScoreState()
        end
    }
    gStateMachine:change('start')

    music = love.audio.newSource('sounds/music.wav', 'static')
    select = love.audio.newSource('sounds/rotate.wav', 'static')
    music:setVolume(0.0)
    music:play()
    music:setLooping(true)

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' and gStateMachine.current == 'start' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply('start')

    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], -- draw at coordinates 0, 0
    0, 0, -- no rotation
    0, -- scale factors on X and Y axis so it fills the screen
    VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    gStateMachine:render()
    displayFPS()
    push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end