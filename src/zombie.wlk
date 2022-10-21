import wollok.game.*
import papita.*
import juego.*

class Zombie {

	var numero = 1
	var property vida
	var property position = self.posicionInicial()
	var seMueve = false

	method image() = "personajes/zombie" + numero.toString() + ".png"

	method posicionInicial() = game.at(game.width() + 1, 1.randomUpTo(6))

	// al principio estan en un lugar random entre las celdas 1 y 6
	// un casillero la derecha para que no se vea
	method aparecer() {
		game.onTick(1000, "moverZombie" + self.identity().toString(), { self.mover()})
	}

	method mover() {
		seMueve = true
		position = position.left(1) // muevo para izq un casillero
		if (position.x() == 0) {
			juego.gameOver() // perdes cuando un zombie recorrio todo el tablero sin morir
		}
		numero = 3.min(numero + 1) // para el movimiento
		if (numero == 3) numero = 1 // loop
	}

	method chocar() {
		vida -= 1
		self.desaparecer()
		puntaje.subirPuntaje(30)
	} // ganas puntos

	method chocar(contraOtroZombie) {
	} // no hace nada

	method estaVivo() = vida != 0

	method desaparecer() {
		if (seMueve) {
			game.removeTickEvent("moverZombie" + self.identity().toString())
			seMueve = false
		}
		
		game.removeVisual(self)
	}

}

class ZombieEnojado inherits Zombie {

	override method image() = "personajes/zombieEnojado" + numero.toString() + ".png"

	override method chocar() {
		puntaje.subirPuntaje(40) // ganas puntos
		vida -= 1
		if (!self.estaVivo()) {
			self.desaparecer()
		}
	}

}

