larguraTela=love.graphics.getWidth()
alturaTela=love.graphics.getHeight()
require("src/movimentos")
require("src/colisoes")
require("src/bombasDoChao")
require("src/misseisChefao")
require("src/elementosMenu")
local activeStartMenu=true 

function love.load()
--fundo do cenario
fundo={}
fundo.imagem=love.graphics.newImage("Imagens/ilo.png")
--boneco principal
imgMegamen=love.graphics.newImage("Imagens/megamen.png")
megamen={
x=(larguraTela/2),
y=(alturaTela/2)+280,
velocidade=400,
veloY=0,
direcao=true,
alturaPulo=400,
gravidade=800
}
estaVivo=true
pontos=0
--chefão
imgChefao=love.graphics.newImage("Imagens/chefenave.png")
chefao={
x=70,
y=40,
atirar=true
}
--BOMBA DO CHEFAO
delayTiro=0.9
tempoAtirar=delayTiro
imgBombaChefao=love.graphics.newImage("Imagens/m.png")
tirosChefao={}
--ELEMENTO EXTRA BOMBA
---BOMBA DO CHAO
bombas={}
bomba={
X=1400,
Y=(alturaTela/2)+280,
velocidade=0
}
delay=0.9
tempoCriarBomba=delay
imgBombaChao=love.graphics.newImage("Imagens/bomb.png")
--retirar mouse da tela
love.mouse.setVisible(true)
----GAME OVER ------
vidas=3
pontos=1
gameOver=false
imgGameOver=love.graphics.newImage("Imagens/gameover.jpg")
musicaGameOver=love.audio.newSource("Musics/gameover.mp3")
-------menu------------------------
ImgMenu=love.graphics.newImage("Imagens/imgMenu.jpg")
moldura=love.graphics.newImage("Imagens/moldura.png")
----------------------------------------------------
--SONS
musica=love.audio.newSource("Musics/trilhaSonoraPrincipal.mp3")
musica:setLooping(true)
musicaMenu=love.audio.newSource("Musics/somMenu.mp3")
musicaMenu:setLooping(true)
SomPulo=love.audio.newSource("Musics/pulo.mp3")
--SomPulo:setLooping(true)
----------------------------------------------------

end
function love.update(dt)
	inimigo(dt)
	atirar(dt)
	colisao()
	reset()
	movimentos(dt)
	movimentosChefao(dt)--movimentacao do chefao
end

function love.draw()

---laço que conytrola o inicio e chama o menu
	if (activeStartMenu==true) then
		drawBackGroundImg()
		nomeDoJogo()
		estaVivo=false
		musica:pause()
		musicaMenu:play()

		if love.keyboard.isDown("y")then 
			activeStartMenu=false
			estaVivo=true
			musica:play()
			musicaMenu:pause()

		end
		if love.keyboard.isDown("q")then
			love.event.quit()
		end 
---condição que inicia o jogo 
	else
		love.graphics.setFont(love.graphics.newFont(21))
		love.graphics.draw(fundo.imagem)
		love.graphics.draw(imgChefao,chefao.x,chefao.y)
		love.graphics.draw(imgBombaChao,bomba.X,bomba.Y,bomba.velocidade)
		---condicao que controla o jogo enquanto o boneco esta vivo
		if estaVivo then 
			pontos=(pontos+1)
			love.graphics.print("Score: "..pontos.." Pontos" , 130,10)
			if megamen.direcao then
				love.graphics.draw(imgMegamen,megamen.x,megamen.y,0,1,1,imgMegamen:getWidth()/2,imgMegamen:getHeight()/2)
			else
				love.graphics.draw(imgMegamen,megamen.x,megamen.y,0,-1,1,imgMegamen:getWidth()/2,imgMegamen:getHeight()/2)
			end 
			love.graphics.print("vidas :"..vidas , 10, 10)
		end 
		---condicao que funciona enquanto houver vidas
		if estaVivo==false then
			love.graphics.print("tente novamente pressione R",larguraTela/3,alturaTela/2)
			love.graphics.print("Sua pontuação foi: "..pontos.." Pontos",500,300)
			
		end 
		---controle de vidas
		if vidas==0 then
			musicaGameOver:play()
			musicaGameOver:setLooping(false)

			love.graphics.draw(imgGameOver,0,0,0,1.7,1.7)
			love.graphics.setColor(255,255,255)
			love.graphics.setFont(love.graphics.newFont(30))         	
			love.graphics.print("SUA PONTUAÇÃO TOTAL FOI: "..pontos.." PONTOS",450,100,0)
			table.remove(tirosChefao,i)
			musica:stop()
			table.remove(bombas,i)
			if love.keyboard.isDown("escape")then
				activeStartMenu=true
				vidas=3
				pontos=0
			end 
		end 





----laco de geração das das imagens da bomba do chão e miseeis do chefão
for i,inimigo in ipairs(bombas) do
	love.graphics.draw(inimigo.imgMegamen,inimigo.x,inimigo.y)
end
 for i,tiro in ipairs(tirosChefao)do 
	love.graphics.draw(tiro.imgMegamen,tiro.x+160,tiro.y+160,0,1,1,imgBombaChefao:getWidth()/2,imgBombaChefao:getHeight()/2)
 end
 end 
end





---------------------------------------------------------------------------------------------
