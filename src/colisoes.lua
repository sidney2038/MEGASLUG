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
----colisão contra as bombas do chao
function checaColisao(x1,y1,w1,h1,x2,y2,w2,h2)
	return(x1 < x2+w2/2 and x2 < x1+w1/2 and y1 < y2+h2/2 and y2 < y1+h1/2 )

end
-----colisão contras os misseis do chefão
function checaColisao2(x1,y1,w1,h1,x2,y2,w2,h2)
	return y1 <y2 + (h2 / 5) and y1> y2- (h2 / 5) and x1- (w1+w2/5 ) <x2 + w2 and x1> x2

end
---função pra voltar ao jogo e zerar o jogo qndo as vidas zerarem
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
