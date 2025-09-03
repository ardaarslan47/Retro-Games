-- lib
Class = require 'lib.class'
push = require 'lib.push'

-- util
require 'src.Constants'
require 'src.StateMachine'
require 'src.Util'

-- states
require 'src.states.BaseState'
require 'src.states.game.StartState'
require 'src.states.game.HighScoreState'
require 'src.states.game.EnterHighScoreState'

-- global
gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png')
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

-- PONG

require 'src.pong.Ball'
require 'src.pong.Paddle'

require 'src.states.pong.PongPlayState'

pongSounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/pong/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/pong/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/pong/wall_hit.wav', 'static')
}

-- BreakOut

require 'src.breakout.Ball'
require 'src.breakout.Brick'
require 'src.breakout.LevelMaker'
require 'src.breakout.Paddle'

require 'src.states.breakout.GameOverState'
require 'src.states.breakout.PlayState'
require 'src.states.breakout.ServeState'
require 'src.states.breakout.VictoryState'

breakoutSounds = {
    ['paddle-hit'] = love.audio.newSource('sounds/breakout/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/breakout/score.wav', 'static'),
    ['wall-hit'] = love.audio.newSource('sounds/breakout/wall_hit.wav', 'static'),
    ['confirm'] = love.audio.newSource('sounds/breakout/confirm.wav', 'static'),
    ['select'] = love.audio.newSource('sounds/breakout/select.wav', 'static'),
    ['no-select'] = love.audio.newSource('sounds/breakout/no-select.wav', 'static'),
    ['brick-hit-1'] = love.audio.newSource('sounds/breakout/brick-hit-1.wav', 'static'),
    ['brick-hit-2'] = love.audio.newSource('sounds/breakout/brick-hit-2.wav', 'static'),
    ['hurt'] = love.audio.newSource('sounds/breakout/hurt.wav', 'static'),
    ['victory'] = love.audio.newSource('sounds/breakout/victory.wav', 'static'),
    ['recover'] = love.audio.newSource('sounds/breakout/recover.wav', 'static'),
    ['high-score'] = love.audio.newSource('sounds/breakout/high_score.wav', 'static'),
    ['pause'] = love.audio.newSource('sounds/breakout/pause.wav', 'static')
}

breakoutTexture = {
    ['main'] = love.graphics.newImage('graphics/breakout/breakout.png'),
    ['hearts'] = love.graphics.newImage('graphics/breakout/hearts.png'),
    ['particle'] = love.graphics.newImage('graphics/breakout/particle.png')
}

breakoutFrames = {
    ['paddles'] = GenerateQuadsPaddles(breakoutTexture['main']),
    ['balls'] = GenerateQuadsBalls(breakoutTexture['main']),
    ['bricks'] = GenerateQuadsBricks(breakoutTexture['main']),
    ['hearts'] = GenerateQuads(breakoutTexture['hearts'], 10, 9)
}

-- snake

require 'graphics.snake.Background'
require 'graphics.snake.Food'
require 'graphics.snake.SnakeBody'
require 'graphics.snake.SnakeHead'
require 'graphics.snake.SnakeTail'

require 'src.snake.Apple'
require 'src.snake.Snake'

require 'src.states.snake.GameOverState'
require 'src.states.snake.PlayState'

snakeSounds = {
    ['game-over'] = love.audio.newSource('sounds/snake/hurt.wav', 'static'),
    ['eat'] = love.audio.newSource('sounds/snake/confirm.wav', 'static'),
    ['pause'] = love.audio.newSource('sounds/snake/pause.wav', 'static'),
    ['turn'] = love.audio.newSource('sounds/snake/brick-hit-2.wav', 'static')
}

-- tetris
require 'src.states.tetris.PlayState'
require 'src.states.tetris.GameOverState'

require 'src.tetris.Brick'
require 'src.tetris.Grid'

tetrisSounds = {
    ['place'] = love.audio.newSource('sounds/tetris/place.wav', 'static'),
    ['explode'] = love.audio.newSource('sounds/tetris/explode.wav', 'static'),
    ['high_score'] = love.audio.newSource('sounds/tetris/high_score.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/tetris/music.mp3', 'static'),
    ['rotate'] = love.audio.newSource('sounds/tetris/rotate.wav', 'static'),
    ['move'] = love.audio.newSource('sounds/tetris/move.wav', 'static')
}

tetrisTextures = {
    ['background'] = love.graphics.newImage('graphics/tetris/background.png'),
    ['bricks'] = love.graphics.newImage('graphics/tetris/Bricks.png'),
    ['play-ground'] = love.graphics.newImage('graphics/tetris/Playground.png'),
    ['explode'] = love.graphics.newImage('graphics/tetris/explode.png')
}

tetrisFrames = {
    ['bricks'] = GenerateQuads(tetrisTextures['bricks'], 12, 12),
    ['explode'] = GenerateQuads(tetrisTextures['explode'], 12, 12)
}
