function love.conf( t )
    --caminho bd
	t.identity= nil
	t.version="0.10.1"
    --testes
	t.console=true
	--correção de gama
    t.gammacorrect=true
    t.window.title="MAN-2038"
    --tamanho da tela
    t.window.width=1366
    t.window.height=769
    t.window.fullscreentype="desktop"
    t.window.vsync=true
    --recuros
    t.modules.audio=true
    t.modules.event=true
    t.modules.graphics=true
    t.modules.image=true
    t.modules.keyboard=true
    t.modules.window=true
    t.modules.timer=true
    t.modules.physics=true
    t.modules.mouse=true
end
