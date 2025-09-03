Food = Class{}

function Food:init()
    self.size = 16
    self.canvas = love.graphics.newCanvas(self.size, self.size)

    love.graphics.setCanvas(self.canvas)
    self:renderToCanvas()
    love.graphics.setCanvas()
end

function Food:renderToCanvas()
    love.graphics.clear(0, 0, 0, 0)

    -- red apple or orb
    love.graphics.setColor(0.8, 0.1, 0.1)
    love.graphics.circle("fill", self.size / 2, self.size / 2, 6)

    -- small shine
    love.graphics.setColor(1, 1, 1, 0.4)
    love.graphics.circle("fill", self.size / 2 - 3, self.size / 2 - 3, 2)
end

function Food:draw(x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
end
