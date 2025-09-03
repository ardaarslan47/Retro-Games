StartState = Class {
    __includes = BaseState
}

local highlighted = 1

function StartState:enter()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
        select:stop()
        select:play()
        highlighted = highlighted == 1 and 5 or highlighted - 1
    elseif love.keyboard.wasPressed('down') then
        select:stop()
        select:play()
        highlighted = highlighted == 5 and 1 or highlighted + 1
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            gStateMachine:change('pong')
        elseif highlighted == 2 then
            gStateMachine:change('breakout-serve', {
                paddle = BreakoutPaddle(1),
                bricks = BreakoutLevelMaker.createMap(1),
                health = 3,
                score = 0,
                level = 1,
                highScores = loadHighScores('breakout')
            })
        elseif highlighted == 3 then
            gStateMachine:change('snake-play', {
                highScores = loadHighScores('snake'),
                apple = Apple(),
                snake = Snake(),
                score = 0
            })
        elseif highlighted == 4 then
            gStateMachine:change('tetris-play', {
                highScores = loadHighScores('tetris')
            })
        else
            gStateMachine:change('high-scores', {
                breakoutHighScores = loadHighScores('breakout'),
                snakeHighScores = loadHighScores('snake'),
                tetrisHighScores = loadHighScores('tetris')
            })
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("RETRO GAMES", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    -- instructions
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("Pong", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("Breakout", 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 3 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("Snake", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 4 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("Tetris", 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 5 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("High Scores", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end