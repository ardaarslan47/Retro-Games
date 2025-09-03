SnakeBody = Class{}

function SnakeBody:init()
    self.size = 16
    self.canvas = love.graphics.newCanvas(self.size, self.size)

    love.graphics.setCanvas(self.canvas)
    self:renderToCanvas()
    love.graphics.setCanvas()
end

function SnakeBody:renderToCanvas()
    love.graphics.clear(0, 0, 0, 0)

    love.graphics.setColor(0.0, 0.7, 0.0) -- green segment
    love.graphics.rectangle("fill", 0, 0, self.size, self.size)
end

function SnakeBody:draw(x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
end
