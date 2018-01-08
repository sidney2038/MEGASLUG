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