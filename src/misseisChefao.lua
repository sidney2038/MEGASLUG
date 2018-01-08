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

