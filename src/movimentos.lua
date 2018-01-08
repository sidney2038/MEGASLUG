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