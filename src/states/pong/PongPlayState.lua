PongPlayState = Class {
    __includes = BaseState
}

function PongPlayState:enter()
    player1score = 0
    player2score = 0
    servingPlayer = 1

    player1 = PongPaddle(10, 30, 5, 20)
    player2 = PongPaddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = PongBall(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'serve'
end

function PongPlayState:update(dt)
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        elseif servingPlayer == 2 then
            ball.dx = -math.random(140, 200)
        end
    end
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            pongSounds.paddle_hit:play()

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        elseif ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            pongSounds.paddle_hit:play()

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy

            pongSounds.wall_hit:play()
        end
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy

            pongSounds.wall_hit:play()
        end

        if ball.x < 0 then
            servingPlayer = 1
            player2score = player2score + 1

            pongSounds.score:play()
            if player2score == 5 then
                winningPlayer = 2
                gameState = 'done'
            else
                ball:reset()
                gameState = 'serve'
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1score = player1score + 1

            pongSounds.score:play()
            if player1score == 5 then
                winningPlayer = 1
                gameState = 'done'
            else
                ball:reset()
                gameState = 'serve'
            end
        end

        ball:update(dt)
    end

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt)
    player2:update(dt)

    if love.keyboard.wasPressed('space') then
        if gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gStateMachine:change('start')
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function PongPlayState.render()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    if gameState == 'serve' then
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf('Player' .. tostring(servingPlayer) .. ' to serve. Press space.', 0, 20, VIRTUAL_WIDTH,
            'center')
    end
    love.graphics.setFont(gFonts['large'])
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    if gameState == 'done' then
        love.graphics.printf('Player' .. tostring(winningPlayer) .. ' wins!!!', 0, 10, VIRTUAL_WIDTH, 'center')
    end

    player1:render()
    player2:render()

    ball:render()
end
