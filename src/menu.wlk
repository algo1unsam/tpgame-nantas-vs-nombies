import wollok.game.*

object juegoMenu{
	const property opciones=[juego,instrucciones,creditos]
	const musicaMenu=game.sound("musica/plantsVsZombiesMainMenu.mp3")
	
	
	
	
	method empezar(){
		game.boardGround("assets/menu.png")
		game.addVisual(flecha)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{flecha.seleccionar()}
		musicaMenu.shouldLoop(true)
		game.schedule(500, { musicaMenu.play()})
	}
	
	
	method cambiar(numero){
		const opcion=self.opciones().get(numero)
		const musicaOpciones=game.sound("musica/mainGame.mp3")
		game.removeVisual(flecha)
		musicaMenu.pause()
		game.addVisual(opcion)
		musicaOpciones.play()
		keyboard.a().onPressDo{=>self.volverAlMenu(numero)
			musicaOpciones.stop()
		} //apretar a para volver al menu, tambien frena la musica que esta sonando
	}
	
	method volverAlMenu(numero){
		const opcion=self.opciones().get(numero)
		game.removeVisual(opcion)
		game.sound("musica/selection.mp3").play()
		game.addVisual(flecha)
		musicaMenu.resume()
	}
}

object flecha{
	const posicionesY= [8,4,1]
 	var numero=0
 	
 	method image()="assets/flecha.png"
	
	method subir(){
		numero=0.max(numero-1)
	}
	
	method bajar(){
		numero=2.min(numero+1)
	}	
	
	method position(){
		return game.at(14, posicionesY.get(numero))
	}
	
	method seleccionar(){
		//abro la opcion del menu dependiendo la posicion de la flecha
		game.sound("musica/selection.mp3").play()
		juegoMenu.cambiar(numero) }
}

object juego{
	method image()="assets/fondoJuego.png"
	method position()=game.origin()

}

object instrucciones{
	method image()="assets/instrucciones.png"
	method position()=game.origin()
}

object creditos{
	method image()="assets/creditos.png"
	method position()=game.origin()
}