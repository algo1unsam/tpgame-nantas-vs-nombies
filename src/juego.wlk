import wollok.game.*

object juegoMenu{
	const property opciones=[juego,instrucciones,creditos]
	
	method empezar(){
		game.boardGround("assets/menu.png")
		game.addVisual(flecha)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{flecha.seleccionar()}
	}
	
	method cambiar(numero){
		const opcion=self.opciones().get(numero)
		game.removeVisual(flecha)
		game.addVisual(opcion)
		keyboard.a().onPressDo{self.volverAlMenu(numero)} //apretar a para volver al menu
	}
	
	method volverAlMenu(numero){
		const opcion=self.opciones().get(numero)
		game.removeVisual(opcion)
		game.addVisual(flecha)
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