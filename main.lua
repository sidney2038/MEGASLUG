larguraTela=love.graphics.getWidth()
alturaTela=love.graphics.getHeight()
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
	

 ---------------------------------------------------------------------------------------------------


 -----------------------------------------------------------------------------------------------------
end

function love.draw()


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
	else
		love.graphics.setFont(love.graphics.newFont(21))
		love.graphics.draw(fundo.imagem)
		love.graphics.draw(imgChefao,chefao.x,chefao.y)
		love.graphics.draw(imgBombaChao,bomba.X,bomba.Y,bomba.velocidade)
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
		if estaVivo==false then
			love.graphics.print("tente novamente pressione R",larguraTela/3,alturaTela/2)
			love.graphics.print("Sua pontuação foi: "..pontos.." Pontos",500,300)
			
		end 
		if vidas==0 then
			musicaGameOver:play()
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





-----------------------------------------------------------------------------------------------

for i,inimigo in ipairs(bombas) do
	love.graphics.draw(inimigo.imgMegamen,inimigo.x,inimigo.y)
end
for i,tiro in ipairs(tirosChefao)do 
	love.graphics.draw(tiro.imgMegamen,tiro.x+160,tiro.y+160,0,1,1,imgBombaChefao:getWidth()/2,imgBombaChefao:getHeight()/2)
end
 end ---nn
 
end

function inimigo(dt)
  --função que gera as bombas do chão
  
  tempoCriarBomba = tempoCriarBomba-(5*dt)
  if tempoCriarBomba<-8 then
  	tempoCriarBomba=delay

  	numeroAleatorio=math.random(1,100) 
  	novoInimigo={x=1280,y=650,imgMegamen=imgBombaChao}
  	table.insert(bombas,novoInimigo)
  end
  for i ,inimigo in pairs (bombas)do 
  	--velocidade de deslocamento das bombas do chão
  	k=500
  	for k=500,100,100 do
  		k=k+300
  	end 
  	inimigo.x=inimigo.x-(k*dt)
  	if inimigo.x<10 then 
  		table.remove(bombas,i)
  	end 
  end
end

------------------------------------------------------------------------------
---funcao que gera os misseis do chefão
function atirar(dt)
	tempoAtirar=tempoAtirar-((5*dt))
 --tempo que gera os misseis do chefão
 if tempoAtirar<-4 then
 	tempoAtirar=delayTiro
 	numeroAleatorio1=math.random(1,300)
 	novoTiro={x=chefao.x,y=chefao.y,imgMegamen=imgBombaChefao}
 	chefao.atirar=true
 	tempoAtirar=delayTiro
 	table.insert(tirosChefao,novoTiro)
 end
 for i,atirar in pairs (tirosChefao) do 
 	atirar.y=atirar.y+(200*dt)
 	if atirar.y >530 then
 		table.remove(tirosChefao,i)
 	end  
 end 
end


-----------------------------------------------------------------------------------------
function colisao()
	for i,inimigo in ipairs(bombas)do
		if checaColisao(megamen.x,megamen.y,imgMegamen:getWidth(),imgMegamen:getHeight(),inimigo.x+(imgBombaChao:getWidth()),
			inimigo.y,imgBombaChao:getWidth(),imgBombaChao:getHeight()) and estaVivo then
		table.remove(bombas,i)
		estaVivo=false
		vidas=vidas-1
	end
end 
for i,atirar in pairs (tirosChefao) do 
	if checaColisao2(megamen.x,megamen.y,imgMegamen:getWidth(),imgMegamen:getHeight(),atirar.x+(imgBombaChefao:getWidth()),atirar.y+(imgBombaChefao:getHeight()),
		imgBombaChefao:getWidth(),atirar.y,atirar.y,imgBombaChefao:getHeight()) and estaVivo then
	table.remove(tirosChefao,i)
	estaVivo=false
	vidas=vidas-1
end
end  
end
function checaColisao(x1,y1,w1,h1,x2,y2,w2,h2)
	return(x1 < x2+w2/2 and x2 < x1+w1/2 and y1 < y2+h2/2 and y2 < y1+h1/2 )

end
function checaColisao2(x1,y1,w1,h1,x2,y2,w2,h2)
	return y1 <y2 + (h2 / 5) and y1> y2- (h2 / 5) and x1- (w1+w2/5 ) <x2 + w2 and x1> x2

end
function reset()
	if not estaVivo and  not gameOver then
		tirosChefao={}
		bombas={}
		
		estaVivo=false
	end
	if vidas>0 then
		if not estaVivo and love.keyboard.isDown('r')then
			tirosChefao={}
			bombas={}
			delay=0.4
			tempoCriarBomba=delay
			megamen.x=(larguraTela/2)
			megamen.y=(alturaTela/2)+280
			estaVivo=true
		end
	end
end  
function movimentos(dt)
 --controle movimentacao do boneco 
 if megamen.veloY ~= 0 then
 	megamen.y=megamen.y-megamen.veloY*(2*dt)
 	megamen.veloY=megamen.veloY-megamen.gravidade*(2*dt)
 	if megamen.y>(alturaTela/2)+280 then
 		megamen.veloY=0
 		megamen.y=(alturaTela/2)+280
 	end 
 end
 if love.keyboard.isDown("d","right") then
 	if megamen.x<(larguraTela-imgMegamen:getWidth()/2)then
 		megamen.x=megamen.x+megamen.velocidade*dt
 		megamen.direcao=true
 	end
 end
 if love.keyboard.isDown("a","left") then
 	if megamen.x>(0 + imgMegamen:getWidth()/2)then
 		megamen.x=megamen.x-megamen.velocidade*dt
 		megamen.direcao=false
 	end
 end
end
function love.keypressed(key)
	if key == "space" then 
		if estaVivo then 
			SomPulo:pause()
			SomPulo:play()
		end 
		if megamen.veloY == 0 then
			megamen.veloY=megamen.alturaPulo
		end
	end
end
function movimentosChefao(dt)
	if (chefao.x>=10 or chefao.x <= 10)then
		chefao.x=chefao.x+100*dt
	end
	if(chefao.x>=1700)then
		chefao.x=-10
	end  
end
---------------------------------------------------------------------------
function drawBackGroundImg()
	love.graphics.draw(ImgMenu,0,0,0,0.8,0.8)
end
function nomeDoJogo()
	local initX=500
	local initY=690
	local nX=100
	local nY=240
	love.graphics.setFont(love.graphics.newFont(30))
	love.graphics.draw(moldura,40,200,0,1,0.25)
	comecarJogo=love.graphics.print("Pressione".." 'Y' ".."Para Iniciar O Game",nX,nY)
	love.graphics.draw(moldura,40,360,0,1,0.25)
	sairJogo=love.graphics.print("Presssione 'Q' Para Fechar O Jogo",100,400)
	love.graphics.setFont(love.graphics.newFont(50))
	love.graphics.setColor(0,0,255,255)
	love.graphics.print("MegaSlug®©",initX,initY)
	love.graphics.setColor(255,255,255,255)
	
end 



---------------------------------------------------------------------------------------------
