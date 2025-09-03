SnakePlayState = Class{__includes = BaseState}

function SnakePlayState:enter(params)
    self.apple = params.apple
    self.snake = params.snake
    self.score = params.score
    self.highScores = params.highScores

    self.background = SnakeBackground()
end

function SnakePlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        snakeSounds['pause']:play()
        return
    end

    self.apple:update(dt)
    self.snake:update(dt)

    if self.snake:collects(self.apple) then
        snakeSounds['eat']:play()
        self.score = self.score + 1
        self.snake.grow = true
        self.snake.speed = self.snake.speed * 1.03
        self.apple:reset(self.snake)
    end

    if not self.snake.alive then
        snakeSounds['game-over']:play()
        gStateMachine:change('snake-game-over', {
            score = self.score,
            highScores = self.highScores
        })
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function SnakePlayState:render()
    self.background:draw()
    self.apple:render()
    self.snake:render()


    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('score: ' .. tostring(self.score), 0, 5, VIRTUAL_WIDTH - 5, 'right')

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
