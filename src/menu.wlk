import wollok.game.*
import juego.*
import papita.*

object juegoMenu{
	const property opciones=[juego,instrucciones,creditos] //opciones que tiene el menu
	const musicaMenu=game.sound("musica/plantsVsZombiesMainMenu.mp3")
	const musicaOpciones=game.sound("musica/mainGame.mp3")
	
	method empezar(){
		game.boardGround("assets/menu.png") 
		game.addVisual(flecha)
		game.addVisual(instrucciones)
		game.addVisual(creditos)
		game.addVisual(juego)
		game.addVisual(papita) 
		//agrega todo pero "escondido"
		
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{self.cambiar(flecha.opcion())} 
		//abre la opcion del menu en el que está parada la flecha
		
		musicaMenu.shouldLoop(true)
		game.schedule(500, { musicaMenu.play()})
		
		game.schedule(0, { musicaOpciones.play() 
							musicaOpciones.pause()})
		//empieza y pausa la musica de las opciones para poder usar resume
	}
	
	method cambiar(numero){
		game.sound("musica/selection.mp3").play() 
		const opcion=self.opciones().get(numero) 
		//la opcion a la que cambio es  la posicion numero de opciones
		game.removeVisual(flecha)
		musicaMenu.pause()
		
		musicaOpciones.resume()
		opcion.iniciar() 
		//aparece la imagen o empieza el juego
		
		keyboard.a().onPressDo{=>self.volverAlMenu(numero)
								 musicaOpciones.pause()
		} //apretar 'a' para volver al menu, pausa la musica
	}
	
	method volverAlMenu(numero){
		const opcion=self.opciones().get(numero)
		opcion.parar()
		game.sound("musica/selection.mp3").play()
		game.addVisual(flecha)
		musicaMenu.resume()
	}
}

object flecha{
	const posicionesY= [2,1,0]
 	var numero=0
 	
 	method image()="assets/flecha.png"
	
	method subir(){
		numero=0.max(numero-1)
	}
	
	method bajar(){
		numero=2.min(numero+1)
	}	
	
	method position(){
		return game.at(4, posicionesY.get(numero))
	}
	
	method opcion()= numero
	//devuelve la opcion del menu dependiendo la posicion en la que está
}

class OpcionesMenu{
	var position=self.posicionInicial()
	method position() = position
	method posicionInicial()=game.at(game.width(),game.height()) //para que no se vea
	method iniciar(){		
		position=game.origin()
	}
	method parar(){
		position=self.posicionInicial()
		//vuelvo a esconder
	}
}

object instrucciones inherits OpcionesMenu{
	method image()="assets/instrucciones.png"
}

object creditos inherits OpcionesMenu{
	method image()="assets/creditos.png"
}