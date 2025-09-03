Snake = Class {}

function Snake:init()
    -- x ==> min 1, max 25
    -- y ==> min 2, max 13
    self.body = {{
        x = 11,
        y = 8
    }, {
        x = 10,
        y = 8
    }, {
        x = 9,
        y = 8
    }}

    self.headImage = SnakeHead()
    self.bodyImage = SnakeBody()
    self.tailImage = SnakeTail()

    self.timer = 0
    self.speed = 10

    self.dx = 1
    self.dy = 0

    self.nextDx = 1
    self.nextDy = 0

    self.grow = false
    self.alive = true
end

function Snake:update(dt)
    if love.keyboard.wasPressed('up') and self.dy == 0 then
        self:turnUp()
    elseif love.keyboard.wasPressed('right') and self.dx == 0 then
        self:turnRight()
    elseif love.keyboard.wasPressed('down') and self.dy == 0 then
        self:turnDown()
    elseif love.keyboard.wasPressed('left') and self.dx == 0 then
        self:turnLeft()
    end

    self.timer = self.timer + dt
    if self.timer > 2 / self.speed then
        self.timer = 0
        self:move()
    end
end

function Snake:render()
    for i, segment in ipairs(self.body) do
        local img = self.bodyImage
        if i == 1 then
            img = self.headImage
        end
        if i == #self.body then
            img = self.tailImage
        end
        img:draw(segment.x * GRID_SIZE, segment.y * GRID_SIZE)
    end
end

function Snake:move()
    self.dx = self.nextDx
    self.dy = self.nextDy

    local head = self.body[1]

    local newX = head.x + self.dx
    local newY = head.y + self.dy

    -- hit border
    if newX > 25 or newX < 1 or newY > 13 or newY < 2 then
        self.alive = false
    end

    -- hit itself
    for i = 1, #self.body do
        local segment = self.body[i]
        if segment.x == newX and segment.y == newY then
            self.alive = false
        end
    end

    table.insert(self.body, 1, {
        x = newX,
        y = newY
    })

    if not self.grow then
        table.remove(self.body)
    else
        self.grow = false
    end
end

function Snake:collects(apple)
    return apple.x == self.body[1].x and apple.y == self.body[1].y
end

function Snake:turnRight()
    snakeSounds['turn']:stop()
    snakeSounds['turn']:play()
    self.nextDx = 1
    self.nextDy = 0
    self.headImage.eye1 = {
        x = 6,
        y = 3
    }
    self.headImage.eye2 = {
        x = 6,
        y = 11
    }
    love.graphics.setCanvas(self.headImage.canvas)
    self.headImage:renderToCanvas()
    love.graphics.setCanvas()
end

function Snake:turnUp()
    snakeSounds['turn']:stop()
    snakeSounds['turn']:play()
    self.nextDx = 0
    self.nextDy = -1
    self.headImage.eye1 = {
        x = 3,
        y = 8
    }
    self.headImage.eye2 = {
        x = 11,
        y = 8
    }
    love.graphics.setCanvas(self.headImage.canvas)
    self.headImage:renderToCanvas()
    love.graphics.setCanvas()
end

function Snake:turnDown()
    snakeSounds['turn']:stop()
    snakeSounds['turn']:play()
    self.nextDx = 0
    self.nextDy = 1
    self.headImage.eye1 = {
        x = 3,
        y = 6
    }
    self.headImage.eye2 = {
        x = 11,
        y = 6
    }
    love.graphics.setCanvas(self.headImage.canvas)
    self.headImage:renderToCanvas()
    love.graphics.setCanvas()
end

function Snake:turnLeft()
    snakeSounds['turn']:stop()
    snakeSounds['turn']:play()
    self.nextDx = -1
    self.nextDy = 0
    self.headImage.eye1 = {
        x = 8,
        y = 3
    }
    self.headImage.eye2 = {
        x = 8,
        y = 11
    }
    love.graphics.setCanvas(self.headImage.canvas)
    self.headImage:renderToCanvas()
    love.graphics.setCanvas()
end