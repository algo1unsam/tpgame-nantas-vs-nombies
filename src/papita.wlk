import wollok.game.*

class Papita {

	var numero = 1
	var property position = self.posicionInicial()
	var property estaBajando = false
	var property estaRodando=false

	method image() = "personajes/papita" + numero.toString() + ".png"

	method posicionInicial() = game.at(2.randomUpTo(4), game.height() + 1)

	// la papita aparece en un lugar random entre las celdas 2 y 4 
	// un casillero arriba para que no se vea
	method aparecer() {
		position = self.posicionInicial()
		self.bajarPapita()
	}

	method bajarPapita() {
		game.onTick(300, "bajarPapita", { self.bajar()})
	} // cada 300 milisegundos se mueve la papita

	method bajar() {
		estaBajando = true
		position = position.down(1) // muevo para abajo un casillero
		if (position.y() == -1) // si se fue del cuadro vuelvo a la pos inicial
		position = self.posicionInicial()
	}

	method rodar() {
		if (estaBajando) {
			self.dejarDeBajar()
		}
		if (!estaRodando)
			self.girarPapita()
	}

	method girarPapita() {
		game.onTick(350, "girarPapita", { self.girar()})
		estaRodando=true
	}

	method girar() {
		numero = 4.min(numero + 1) // "movimiento" de la imagen
		if (numero == 4) numero = 1 // loop
		position = position.right(1) // muevo uno a la derecha
		if (position.x() > game.width()) { // si desaparece de la pantalla deja de girar y vuelve a aparecer
			self.borrar()
		}
	}

	method chocar(contraQuien) {
		contraQuien.chocar()
		self.borrar()
	}

	method borrar() {
		self.dejarDeGirar()
		self.dejarDeBajar()
		numero = 1
		self.aparecer()
	}

	method desaparecer() {
		if (estaBajando) self.dejarDeBajar() else self.dejarDeGirar()
		position = self.posicionInicial() // para que no se vea cuando termina el juego
	}

	method chocar() {
	} // si se chocan las papitas entre si no para nada

	method dejarDeGirar() {
		if (estaRodando){
			game.removeTickEvent("girarPapita")
			estaRodando=false}
	}

	method dejarDeBajar() {
		if (estaBajando){
			game.removeTickEvent("bajarPapita")
			estaBajando = false}
	}

}

object papitaViolenta inherits Papita { //para que me deje inicializar otraPapa en el archivo juego

	override method image() = "personajes/papitaEnojada" + numero.toString() + ".png"

	override method posicionInicial() = game.at(1, game.height() + 1)

	override method girarPapita() {
		game.onTick(200, "girarPapitaViolenta", { self.girar()})
		estaRodando=true
	}

	override method bajarPapita() {
		game.onTick(300, "bajarPapitaViolenta", { self.bajar()})
	}

	override method chocar(contraQuien) {
		if (contraQuien.vida() == 2) {
			contraQuien.chocar()
			contraQuien.chocar()
		} else contraQuien.chocar()
	}

	override method dejarDeGirar() {
		estaRodando=false
		game.removeTickEvent("girarPapitaViolenta")
	}

	override method dejarDeBajar() {
		game.removeTickEvent("bajarPapitaViolenta")
		estaBajando=false
	}

}

