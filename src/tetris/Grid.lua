Grid = Class {}

function Grid:init()
    self.body = {}

    self.column = 14
    self.row = 28

    for i = 1, self.column do
        self.body[i] = {}
        for j = 1, self.row do
            self.body[i][j] = false
        end
    end

    self.explodingRows = {}
    self.explosionDuration = 0.1 -- saniye
    self.frame = 1
end

function Grid:update(dt)
    if #self.explodingRows > 0 then
        self.explosionDuration = self.explosionDuration - dt

        if self.explosionDuration <= 0 then
            self.explosionDuration = 0.05
            self.frame = self.frame + 1

            if self.frame > #tetrisFrames['explode'] then
                self.frame = 1
                self:clearRows()
            end
        end
    else
        self:checkFullRows() -- <=== yeni eklendi
    end
end

function Grid:render()
    for i = 1, self.column do
        for j = 1, self.row do
            if tableContains(self.explodingRows, j) then
                love.graphics.draw(tetrisTextures['explode'], tetrisFrames['explode'][self.frame], (i * TETRIS_GRID_SIZE) + 24,
                    j * TETRIS_GRID_SIZE + 60)
            end
            if self.body[i][j] and not tableContains(self.explodingRows, j) then
                love.graphics.draw(tetrisTextures['explode'], tetrisFrames['explode'][3], (i * TETRIS_GRID_SIZE) + 24, j * TETRIS_GRID_SIZE + 60)
            end
        end
    end
end

function Grid:isRowFull(row)
    for i = 1, self.column do
        if self.body[i][row] == false then
            return false
        end
    end

    return true
end

function Grid:clearRows()
    table.sort(self.explodingRows)

    for row = 1, #self.explodingRows do
        for col = 1, self.column do
            for i = self.explodingRows[row], 2, -1 do
                self.body[col][i] = self.body[col][i - 1]
            end
        end
    end

    self.explodingRows = {}
end

function Grid:isOccupied(column, row)
    if column > 14 or column < 1 or row > 28 then
        return true
    end

    return self.body[column][row]
end

function Grid:occupy(column, row)
    self.body[column][row] = true
end

function Grid:triggerExplosion(row)
    tetrisSounds['explode']:stop()
    tetrisSounds['explode']:play()
    table.insert(self.explodingRows, row)
end

function Grid:checkFullRows()
    for row = 1, self.row do
        if self:isRowFull(row) and not tableContains(self.explodingRows, row) then
            self:triggerExplosion(row)
        end
    end
end
