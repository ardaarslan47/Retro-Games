SnakeGameOverState = Class{__includes = BaseState}

function SnakeGameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function SnakeGameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- see if score is higher than any in the high scores table
        local highScore = false
        
        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            breakoutSounds['high-score']:play()
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex,
                game = 'snake'
            }) 
        else 
            gStateMachine:change('start') 
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function SnakeGameOverState:render()
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("SCORE: " .. tostring(self.score), 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("PRESS ENTER TO START", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end
