import wollok.game.*
import juego.*
import papita.*

object juegoMenu {
	
	const musicaMenu = game.sound("musica/plantsVsZombiesMainMenu.mp3")
	const property musicaOpciones = game.sound("musica/mainGame.mp3")

	method configurar() {
		game.boardGround("fondos/menu.png")
		game.addVisual(flecha)
		keyboard.up().onPressDo{ flecha.subir()}
		keyboard.down().onPressDo{ flecha.bajar()}
		keyboard.enter().onPressDo{ self.cambiar(flecha.opcion())} // abre la opcion del menu en el que está parada la flecha
	}

	method empezar() {
		self.configurar()
		musicaMenu.shouldLoop(true)
		musicaOpciones.shouldLoop(true)
		game.schedule(500, { musicaMenu.play()})
		game.schedule(1, { musicaOpciones.play()
			musicaOpciones.pause()
		}) // empieza y pausa la musica de las opciones para poder usar resume
	}

	method cambiar(opcion) {
		game.sound("musica/selection.mp3").play()
		game.clear()
		game.addVisual(opcion)
		musicaMenu.pause()
		musicaOpciones.resume()
		opcion.iniciar()
			// aparece la imagen o empieza el juego
		keyboard.shift().onPressDo{=>
			opcion.parar()
			self.volverAlMenu()
			musicaOpciones.pause()
		} // apretar 'shift' para volver al menu, pausa la musica
	}

	method volverAlMenu() {
		game.clear()
		self.configurar() // vuelve a poner la flecha y las configuraciones de teclas
		game.sound("musica/selection.mp3").play()
		musicaMenu.resume()
	}

}

object flecha {

	var property numero = 2
	const property opciones = [ creditos, instrucciones, juego ] // opciones que tiene el menu

	method image() = "fondos/flecha.png"

	method subir() {
		numero = 2.min(numero + 1)
	}

	method bajar() {
		numero = 0.max(numero - 1)
	}

	method position() {
		return game.at(3, numero)
	}

	method opcion() = opciones.get(numero)

}

class OpcionesMenu {

	var property position = self.posicionInicial()
	var property image

	method posicionInicial() = game.at(game.width(), game.height()) // para que no se vea

	method iniciar() {
		position = game.origin()
	// mueve la imagen para que se vea
	}

	method parar() {
		position = self.posicionInicial()
	// vuelvo a esconder
	}

}

const instrucciones = new OpcionesMenu(image = "fondos/instrucciones.png")

const creditos = new OpcionesMenu(image = "fondos/creditos.png")

