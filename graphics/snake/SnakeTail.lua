SnakeTail = Class{}

function SnakeTail:init()
    self.size = 16
    self.canvas = love.graphics.newCanvas(self.size, self.size)

    love.graphics.setCanvas(self.canvas)
    self:renderToCanvas()
    love.graphics.setCanvas()
end

function SnakeTail:renderToCanvas()
    love.graphics.clear(0, 0, 0, 0)

    love.graphics.setColor(0.0, 0.7, 0.0)
    love.graphics.rectangle("fill", 0, 0, self.size, self.size)

    -- taper effect (diagonal cut)
    love.graphics.setColor(0.0, 0.5, 0.0)
    love.graphics.polygon("fill", self.size, 0, self.size, self.size, 0, self.size)
end

function SnakeTail:draw(x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
end
