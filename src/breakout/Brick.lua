--[[
    GD50
    Breakout Remake

    -- Brick Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a brick in the world space that the ball can collide with;
    differently colored bricks have different point values. On collision,
    the ball will bounce away depending on the angle of collision. When all
    bricks are cleared in the current map, the player should be taken to a new
    layout of bricks.
]]

BreakoutBrick = Class{}

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}

function BreakoutBrick:init(x, y)
    -- used for coloring and score calculation
    self.tier = 0
    self.color = 1
    
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    
    -- used to determine whether this Breakoutbrick should be rendered
    self.inPlay = true

    self.pSystem = love.graphics.newParticleSystem(breakoutTexture['particle'], 64)

    self.pSystem:setParticleLifetime(0.5, 1)
    self.pSystem:setLinearAcceleration(-15, 0, 15, 80)
    self.pSystem:setAreaSpread('normal', 10, 10 )
end

--[[
    Triggers a hit on the Breakoutbrick, taking it out of play if at 0 health or
    changing its color otherwise.
]]
function BreakoutBrick:hit()
    self.pSystem:setColors(
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        55 * (self.tier + 1) / 255,
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        0
    )
    self.pSystem:emit(64)

    -- sound on hit
    breakoutSounds['brick-hit-2']:stop()
    breakoutSounds['brick-hit-2']:play()

    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    if not self.inPlay then
        breakoutSounds['brick-hit-1']:stop()
        breakoutSounds['brick-hit-1']:play()
    end
end

function BreakoutBrick:update(dt)
    self.pSystem:update(dt)
end

function BreakoutBrick:render()
    if self.inPlay then
        love.graphics.draw(breakoutTexture['main'], 
            -- multiply color by 4 (-1) to get our color offset, then add tier to that
            -- to draw the correct tier and color brick onto the screen
            breakoutFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
            self.x, self.y)
    end
end

function BreakoutBrick:renderParticles()
    love.graphics.draw(self.pSystem, self.x + 16, self.y + 8)
end