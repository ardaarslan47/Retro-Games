TetrisPlayState = Class {
    __includes = BaseState
}

function TetrisPlayState:enter(params)
    self.brick = Brick(0.3)
    self.grid = Grid()
    self.score = 0
    self.highScores = params.highScores
    self.moveDelay = 0.3

    push:setupScreen(TETRIS_VIRTUAL_WIDTH, TETRIS_VIRTUAL_HEIGHT, TETRIS_WINDOW_WIDTH, TETRIS_WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function TetrisPlayState:update(dt)
    -- pause logic
    if self.paused then
        if love.keyboard.wasPressed('return') then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('return') then
        self.paused = true
        return
    end

    self.brick:update(dt)
    self.grid:update(dt)

    if self:isCollideBottom() then
        self.brick:freeze(self.grid)
    end

    if not self.brick.alive then

        local scoreMultiply = 0
        -- if last brick's row full when it freeze clear row  
        for _, segment in ipairs(self.brick.body) do
            if self.grid:isRowFull(segment.row) then
                self.grid:triggerExplosion(segment.row)
                scoreMultiply = scoreMultiply + 1
            end
        end

        self.score = self.score + math.pow(3, scoreMultiply) * 10
        scoreMultiply = 0

        -- create new brick
        self.moveDelay = self.moveDelay * 0.98
        self.brick = Brick(self.moveDelay)  -- Keep consistent initial speed for each brick
    end

    if love.keyboard.wasPressed('space') then
        self.brick:rotate(self.grid)
    end

    if (not self:isCollideSide()) and self.brick.alive then
        for _, segment in ipairs(self.brick.body) do
            segment.row = segment.row + self.brick.moveRow
            segment.column = segment.column + self.brick.moveCol
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function TetrisPlayState:render()
    love.graphics.draw(tetrisTextures['background'])
    local playgroundWidth = tetrisTextures['play-ground']:getWidth()
    local playgroundHeight = tetrisTextures['play-ground']:getHeight()
    love.graphics.draw(tetrisTextures['play-ground'], -0.5, 23.5, 0, TETRIS_VIRTUAL_WIDTH / (playgroundWidth - 1),
        TETRIS_VIRTUAL_HEIGHT / (playgroundHeight - 1))


    self.brick:render()

    self.grid:render()

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1, 1, 1, 1) -- white with full opacity
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 30, TETRIS_VIRTUAL_WIDTH, 'center')

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, TETRIS_VIRTUAL_HEIGHT / 2 - 16, TETRIS_VIRTUAL_WIDTH, 'center')
    end
end

function TetrisPlayState:isCollideSide()
    for _, segment in ipairs(self.brick.body) do
        if self.grid:isOccupied(segment.column + self.brick.moveCol, segment.row) then
            return true
        end
    end

    return false
end

function TetrisPlayState:isCollideBottom()
    for _, segment in ipairs(self.brick.body) do
        if self.grid:isOccupied(segment.column, segment.row + self.brick.moveRow) then
            if segment.row == 0 then
                tetrisSounds['high_score']:play()
                gStateMachine:change('tetris-game-over', {
                    score = self.score,
                    highScores = self.highScores
                })
            end
            return true
        end
    end

    return false
end