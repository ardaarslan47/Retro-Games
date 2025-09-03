Brick = Class {}

function Brick:init(params)
    self.type = BRICK_TYPES[math.random(7)]
    self.skin = math.random(8)
    self.alive = true
    
    -- array[4][2] with column and row coordinates
    self.body = Brick:createBrick(self.type, self.skin)
    
    self.moveDelay = params
    self.resetDelay = params
    
    self.moveCol = 0
    self.moveRow = 0
end

function Brick:update(dt)
    self.moveCol = 0
    self.moveRow = 0
    self.moveDelay = self.moveDelay - dt

    if self.moveDelay <= 0 then
        self.moveRow = 1
        self.moveDelay = self.resetDelay
    end

    if love.keyboard.wasPressed('left') then
        tetrisSounds['move']:stop()
        tetrisSounds['move']:play()
        self.moveCol = -1
    elseif love.keyboard.wasPressed('right') then
        tetrisSounds['move']:stop()
        tetrisSounds['move']:play()
        self.moveCol = 1
    elseif love.keyboard.wasPressed('down') then
        tetrisSounds['move']:stop()
        tetrisSounds['move']:play()
        self.moveRow = 1
    end
end

function Brick:render()
    for _, segment in ipairs(self.body) do
        if segment.row > 0 then
            love.graphics.draw(tetrisTextures['bricks'], tetrisFrames['bricks'][self.skin], (segment.column * TETRIS_GRID_SIZE) + 24,
                segment.row * TETRIS_GRID_SIZE + 60)
        end
    end
end

function Brick:rotate(grid)
    -- O tipi taş dönmez
    if self.type == 'O' then
        return
    end

    -- referans olarak ortadaki segmenti (2. parça) al
    local cx = self.body[2].column
    local cy = self.body[2].row

    for _, segment in ipairs(self.body) do
        local x = segment.column
        local y = segment.row

        local dx = x - cx
        local dy = y - cy

        if grid:isOccupied(cx - dy, cy + dx) then
            return
        end
    end

    for _, segment in ipairs(self.body) do
        local x = segment.column
        local y = segment.row

        -- saat yönünde döndürme formülü:
        local dx = x - cx
        local dy = y - cy

        segment.column = cx - dy
        segment.row = cy + dx
    end

    tetrisSounds['rotate']:stop()
    tetrisSounds['rotate']:play()
end

function Brick:freeze(grid)
    for _, segment in ipairs(self.body) do
        grid:occupy(segment.column, segment.row)
    end

    tetrisSounds['place']:play()
    self.alive = false
end

function Brick:createBrick(type)
    if type == 'I' then
        return {{
            column = 7,
            row = -3
        }, {
            column = 7,
            row = -2
        }, {
            column = 7,
            row = -1
        }, {
            column = 7,
            row = 0
        }}
    elseif type == 'L' then
        return {{
            column = 7,
            row = -2
        }, {
            column = 7,
            row = -1
        }, {
            column = 7,
            row = 0
        }, {
            column = 8,
            row = 0
        }}
    elseif type == 'J' then
        return {{
            column = 7,
            row = -2
        }, {
            column = 7,
            row = -1
        }, {
            column = 7,
            row = 0
        }, {
            column = 6,
            row = 0
        }}
    elseif type == 'O' then
        return {{
            column = 7,
            row = -1
        }, {
            column = 8,
            row = -1
        }, {
            column = 7,
            row = 0
        }, {
            column = 8,
            row = 0
        }}
    elseif type == 'S' then
        return {{
            column = 7,
            row = -1
        }, {
            column = 8,
            row = -1
        }, {
            column = 6,
            row = 0
        }, {
            column = 7,
            row = 0
        }}
    elseif type == 'Z' then
        return {{
            column = 6,
            row = -1
        }, {
            column = 7,
            row = -1
        }, {
            column = 7,
            row = 0
        }, {
            column = 8,
            row = 0
        }}
    elseif type == 'T' then
        return {{
            column = 6,
            row = -1
        }, {
            column = 7,
            row = -1
        }, {
            column = 8,
            row = -1
        }, {
            column = 7,
            row = 0
        }}
    end
end
