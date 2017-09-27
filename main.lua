tela = {
	largura = love.graphics.getWidth(),
	altura = love.graphics.getHeight()
}
tirosConf = {
	podeAtirar = true,
	tempo = 0.5,
	projeteis = {},
	porjetilSprite = love.graphics.newImage('img/tiro.png')
}

aliensConfig = {
	delay = 0.5,
	sprite = love.graphics.newImage('img/alien.png'),
	aliens = {}
}

tempoEntreAliens = aliensConfig.delay

function love.load()
	naveSprite = love.graphics.newImage("img/nave.png")
	naveConf = {
		x = tela.largura/2,
		y = tela.altura/2,
		velocidade = 200
	}
	fundo = love.graphics.newImage('img/fundo.jpg')
end

function love.update(dt)
	if love.keyboard.isDown("right") then
		if naveConf.x < (tela.largura - naveSprite:getWidth()/2) then
			naveConf.x = naveConf.x + naveConf.velocidade * dt
		end
	end
	if love.keyboard.isDown("left") then
		if naveConf.x > (0 + naveSprite:getWidth()/2) then
		naveConf.x = naveConf.x - naveConf.velocidade * dt
		end
	end
	if love.keyboard.isDown("up") then
		if naveConf.y > (0 + naveSprite:getHeight()/2) then
			naveConf.y = naveConf.y - naveConf.velocidade * dt
		end
	end
	if love.keyboard.isDown("down") then
		if naveConf.y < (tela.altura - naveSprite:getHeight()/2) then
			naveConf.y = naveConf.y + naveConf.velocidade * dt
		end
	end
	atirar(dt)
	aliens(dt)
end

function love.draw()
	love.graphics.draw(fundo,0,0)
	love.graphics.draw(naveSprite, naveConf.x, naveConf.y,0,0.3,0.3,naveSprite:getWidth()/2,naveSprite:getHeight()/2)
	for i, tiro in ipairs(tirosConf.projeteis) do
		love.graphics.draw(tiro.sprite, tiro.x, tiro.y,0,0.2,0.2,tiro.sprite:getWidth()/2,tiro.sprite:getHeight()/2)
	end
	for i, alien in ipairs(aliensConfig.aliens) do
		love.graphics.draw(alien.sprite, alien.x, alien.y,0,0.4,0.4)
	end
end

tempoAtirar = tirosConf.tempo

function atirar(dt)
	tempoAtirar = tempoAtirar - (1*dt)
	if tempoAtirar < 0 then
		tirosConf.podeAtirar = true
	end
	if love.keyboard.isDown("space") and tirosConf.podeAtirar then
		tiro = {x = naveConf.x, y = naveConf.y, sprite = tirosConf.porjetilSprite}
		table.insert(tirosConf.projeteis, tiro)
		tirosConf.podeAtirar = false
		tempoAtirar = tirosConf.tempo
	end
	for i, tiro in ipairs(tirosConf.projeteis) do
		tiro.y = tiro.y - (200 * dt)
		if tiro.y < 0 then
			table.remove(tirosConf.projeteis, i)
		end
	end
end

function aliens(dt)
	tempoEntreAliens = tempoEntreAliens - (1*dt)
	if tempoEntreAliens < 0 then
		tempoEntreAliens = aliensConfig.delay
		posicao = math.random(4, tela.largura - ((aliensConfig.sprite:getWidth()/2)+10))
		alien = {x = posicao, y = -aliensConfig.sprite:getWidth(), sprite = aliensConfig.sprite}
		table.insert(aliensConfig.aliens, alien)
	end
	for i, alien in ipairs(aliensConfig.aliens) do
		alien.y = alien.y + (200*dt)
		if alien.y > 850 then
			table.remove(aliensConfig.aliens, i)
		end
	end
end
