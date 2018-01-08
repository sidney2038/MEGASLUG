--elementos do menu
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

