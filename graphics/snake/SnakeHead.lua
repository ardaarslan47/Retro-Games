SnakeHead = Class{}

function SnakeHead:init()
    self.size = 16
    self.canvas = love.graphics.newCanvas(self.size, self.size)

    self.eye1 = {
        x = 6,
        y = 3
    }
    self.eye2 = {
        x = 6,
        y = 11
    }

    self.mouth = {
        x = 12,
        y = 6
    }

    love.graphics.setCanvas(self.canvas)
    self:renderToCanvas()
    love.graphics.setCanvas()
end

function SnakeHead:renderToCanvas()
    love.graphics.clear(0, 0, 0, 0) -- transparent background

    love.graphics.setColor(0.0, 0.8, 0.0) -- bright green
    love.graphics.rectangle("fill", 0, 0, self.size, self.size)

    -- Simple eyes (white pixels)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.eye1.x, self.eye1.y, 2, 2)
    love.graphics.rectangle("fill", self.eye2.x, self.eye2.y, 2, 2)
end

function SnakeHead:draw(x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
end
