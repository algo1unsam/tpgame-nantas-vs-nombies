import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu
import zombie.*

object juego {

	var position = self.posicionInicial()
	const zombies = []
	const papita = new Papita()

	var hayZombiesEnojados=false
	method image() = "fondos/fondoJuego.png"

	method position() = position

	method posicionInicial() = game.at(game.width(), game.height()) // para que no se vea

	method iniciar() {
		position = game.origin()
		game.addVisual(reloj)
		keyboard.enter().onPressDo{ self.empezarJuego()}
	// agregar algun cartel que diga "presione enter para iniciar" o algo asi
	}

	method empezarJuego() {
		game.clear()
		position = game.origin()
		game.addVisual(self)
			// por si aprietan enter mientras juegan
		game.addVisual(papita)
		game.addVisual(papitaViolenta)
		game.addVisual(reloj)
		game.addVisual(puntaje)
		reloj.iniciar()
		game.onTick(5000, "crearZombies", { self.crearZombies()})
		game.schedule(30000, { papitaViolenta.aparecer()})
		if (!hayZombiesEnojados) game.schedule(35000, { self.aparecerZombiesEnojados()})
		papita.aparecer()
		keyboard.space().onPressDo{ papita.rodar()} // si se aprieta espacio rueda la papa
		keyboard.a().onPressDo{ papitaViolenta.rodar()} // si se aprieta a rueda la papaViolenta
		keyboard.shift().onPressDo{=> juegoMenu.volverAlMenu()}
	}

	method crearZombies() {
		
		const nuevo = new Zombie(vida = 1)
		zombies.add(nuevo)
		game.addVisual(nuevo)
		nuevo.aparecer()
		game.onCollideDo(nuevo, { papitaCualquiera =>
			papitaCualquiera.chocar(nuevo)
			game.sound("musica/bowling.mp3").play()
			if (! nuevo.estaVivo()) zombies.remove(nuevo)
		})
	}

	method aparecerZombiesEnojados() {
		hayZombiesEnojados=true
		game.onTick(8000, "aparecerZombiesEnojados", { self.crearZombiesEnojados()})
	}

	method crearZombiesEnojados() {
		const nuevo = new ZombieEnojado(vida = 2)
		zombies.add(nuevo)
		game.addVisual(nuevo)
		nuevo.aparecer()
		game.onCollideDo(nuevo, { papitaCualquiera =>
			papitaCualquiera.chocar(nuevo)
			game.sound("musica/bowling.mp3").play()
			if (! nuevo.estaVivo()) zombies.remove(nuevo)
		})
		
	}

	method gameOver() {
		game.addVisual(gameOver)
		game.removeVisual(papita)
		game.removeVisual(papitaViolenta)
		reloj.detener()
		zombies.forEach{ zombie => game.removeVisual(zombie)} // borra todos los zombies que ya estaban 
		game.removeTickEvent("crearZombies") // para que dejen de aparecer
		if (hayZombiesEnojados){
			game.removeTickEvent("aparecerZombiesEnojados")}
		else hayZombiesEnojados = false
	}

	method parar() {
		position = self.posicionInicial()
		papita.desaparecer()
		papitaViolenta.desaparecer()
	}

}

object gameOver {

	method position() = game.center()

	method text() = "GAME OVER"

	method textColor() = "#ffffff"

}

object reloj {

	var tiempo = 0

	method text() = "Tiempo de juego: " + tiempo.toString()

	method textColor() = "#ffffff"

	method position() = game.at(game.width() - 1, game.height() - 1)

	method pasarTiempo() {
		tiempo = tiempo + 1
	}

	method iniciar() {
		tiempo = 0
		game.onTick(1000, "tiempo", { self.pasarTiempo()})
	}

	method detener() {
		game.removeTickEvent("tiempo")
	}

	method chocar(aQuien) {
	}

}

object puntaje {

	var puntaje = 0

	method text() = "Puntaje: " + puntaje.toString()

	method textColor() = "#ffffff"

	method position() = game.at(game.width() - 3, game.height() - 1)

	method subirPuntaje(cantidad) {
		puntaje += cantidad
	}

	method chocar(aQuien) {
	}

}

