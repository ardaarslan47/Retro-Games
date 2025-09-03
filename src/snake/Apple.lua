Apple = Class{}

function Apple:init()
    self.x = 13
    self.y = 8

    self.image = Food()
end

function Apple:update(dt)
    
end

function Apple:render()
    self.image:draw(self.x * GRID_SIZE, self.y * GRID_SIZE)
end

function Apple:reset(snake)
    repeat
        self.x = math.random(1, 25)
        self.y = math.random(2, 13)

        local valid = true
        for _, segment in ipairs(snake.body) do
            if segment.x == self.x and segment.y == self.y then
                valid = false
                break
            end
        end
    until valid
end