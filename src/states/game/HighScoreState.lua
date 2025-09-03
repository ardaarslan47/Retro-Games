--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the screen where we can view all high scores previously recorded.
]] HighScoreState = Class {
    __includes = BaseState
}

local highlighted = 1

function HighScoreState:enter(params)
    self.breakoutHighScores = params.breakoutHighScores
    self.snakeHighScores = params.snakeHighScores
    self.tetrisHighScores = params.tetrisHighScores
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('left') then
        select:stop()
        select:play()
        highlighted = highlighted == 1 and 3 or highlighted - 1
    elseif love.keyboard.wasPressed('right') then
        select:stop()
        select:play()
        highlighted = highlighted == 3 and 1 or highlighted + 1
    end
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('escape') then
        -- gSounds['wall-hit']:play()

        gStateMachine:change('start')
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['medium'])

    if highlighted == 1 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf('Breakout', -78, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf('Snake', 10, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 3 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf('Tetris', 83, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 1 then
        -- iterate over all high score indices in our high scores table
        for i = 1, 10 do
            local name = self.breakoutHighScores[i].name or '---'
            local score = self.breakoutHighScores[i].score or '---'

            -- score number (1-10)
            love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 60 + i * 13, 50, 'left')

            -- score name
            love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 13, 50, 'right')

            -- score itself
            love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 13, 100, 'right')
        end
    elseif highlighted == 2 then
        for i = 1, 10 do
            local name = self.snakeHighScores[i].name or '---'
            local score = self.snakeHighScores[i].score or '---'

            -- score number (1-10)
            love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 60 + i * 13, 50, 'left')

            -- score name
            love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 13, 50, 'right')

            -- score itself
            love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 13, 100, 'right')
        end
    else
        for i = 1, 10 do
            local name = self.tetrisHighScores[i].name or '---'
            local score = self.tetrisHighScores[i].score or '---'

            -- score number (1-10)
            love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 60 + i * 13, 50, 'left')

            -- score name
            love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 13, 50, 'right')

            -- score itself
            love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 13, 100, 'right')
        end
    end
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press Escape to return to the main menu!", 0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end


