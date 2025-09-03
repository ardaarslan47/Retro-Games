SnakeBackground = Class {}

topBarHeight = 16
margin = 8
borderWidth = 8

colors = {
    background = {0.2, 0.6, 0.3}, -- green base
    topBar = {0.1, 0.4, 0.2}, -- darker green
    border = {0.05, 0.2, 0.1}, -- very dark green
    field = {0.15, 0.5, 0.25} -- inside rectangle
}

function SnakeBackground:init()
    self.canvas = love.graphics.newCanvas(432, 243)
    love.graphics.setCanvas(self.canvas)
    self:renderToCanvas()
    love.graphics.setCanvas()
end

function SnakeBackground:renderToCanvas()
    -- Fill Snakebackground
    love.graphics.clear(colors.background)

    -- Top bar
    love.graphics.setColor(colors.topBar)
    love.graphics.rectangle("fill", 0, 0, 432, topBarHeight)

    -- Outer rectangle border
    local x = margin
    local y = topBarHeight + margin
    local w = 432 - 2 * margin
    local h = 243 - topBarHeight - 2 * margin - 3

    love.graphics.setColor(colors.border)
    love.graphics.rectangle("fill", x, y, w, h)

    -- Inner field
    local tileSize = 16
    local startX = x + borderWidth
    local startY = y + borderWidth
    local fieldWidth = w - 2 * borderWidth
    local fieldHeight = h - 2 * borderWidth
    local cols = math.floor(fieldWidth / tileSize)
    local rows = math.floor(fieldHeight / tileSize)

    for row = 0, rows - 1 do
        for col = 0, cols - 1 do
            local isLight = (row + col) % 2 == 0
            if isLight then
                love.graphics.setColor(0.15, 0.5, 0.25) -- field base
            else
                love.graphics.setColor(0.13, 0.45, 0.22) -- slightly darker
            end
            love.graphics.rectangle("fill", startX + col * tileSize, startY + row * tileSize, tileSize, tileSize)
        end
    end
end

function SnakeBackground:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, 0, 0)
end
