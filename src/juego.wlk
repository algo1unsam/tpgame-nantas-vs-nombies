import wollok.game.*
import papita.*
import menu.*
import zombie.*

object juego {

	var property position = self.posicionInicial()
	var property zombies = []
	const papita = new Papita()
	var hayZombiesEnojados = false

	method image() = "fondos/fondoJuego.png"

	method posicionInicial() = game.at(game.width(), game.height()) // para que no se vea

	method iniciar() {
		position = game.origin()
		game.addVisual(enter)
		keyboard.enter().onPressDo{ self.empezarJuego()}
	}

	method empezarJuego() {
		game.clear()
		position = game.origin()
		game.addVisual(self)
		game.addVisual(papita)
		game.addVisual(papitaViolenta)
		game.addVisual(reloj)
		game.addVisual(puntaje)
		reloj.iniciar()
		game.onTick(5000, "crearZombies", { self.crearZombies()})
		game.schedule(30000, { papitaViolenta.aparecer()
			keyboard.a().onPressDo{ papitaViolenta.rodar()} // si se aprieta a rueda la papaViolenta
		})
		if (!hayZombiesEnojados) game.onTick(35000, "crearZombiesEnojados", { self.aparecerZombiesEnojados() })
		papita.aparecer()
		keyboard.d().onPressDo{ papita.rodar()} // si se aprieta espacio rueda la papa
		keyboard.shift().onPressDo{=> juegoMenu.volverAlMenu()}
	}

	method configuracionZombie(zombie) {
		zombies.add(zombie)
		game.addVisual(zombie)
		zombie.aparecer()
		game.onCollideDo(zombie, { papitaCualquiera =>
			papitaCualquiera.chocar(zombie)
			game.sound("musica/bowling.mp3").play()
		})
	}

	method crearZombies() {
		const nuevo = new Zombie(vida = 1)
		self.configuracionZombie(nuevo)
	}

	method aparecerZombiesEnojados() {
		hayZombiesEnojados = true
		game.onTick(8000, "aparecerZombiesEnojados", { self.crearZombiesEnojados()})
	}

	method crearZombiesEnojados() {
		const nuevo = new ZombieEnojado(vida = 2)
		self.configuracionZombie(nuevo)
	}

	method gameOver() {
		juegoMenu.musicaOpciones().pause()
		game.sound("musica/gameOver.mp3").play()
		if (hayZombiesEnojados) { // por si se pierde antes de que empiecen a aparecer los enojados
			game.removeTickEvent("crearZombiesEnojados")
			game.removeTickEvent("aparecerZombiesEnojados")
		} else hayZombiesEnojados = true
		game.addVisual(gameOver)
		game.removeVisual(papita)
		game.removeVisual(papitaViolenta)
		reloj.detener()
		game.removeTickEvent("crearZombies") // para que dejen de aparecer
		game.schedule(5000, { game.stop()})
		zombies.forEach{ zombie => zombie.desaparecer()} // borra todos los zombies que estan 
	}

	method parar() {
		position = self.posicionInicial()
		papita.desaparecer()
		papitaViolenta.desaparecer()
	}

}

object gameOver {

	method position() = game.at(4, 2)

	method image() = "fondos/gameOver.png"

}

object reloj {

	var property tiempo = 0

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

}

object puntaje {

	var puntaje = 0

	method text() = "Puntaje: " + puntaje.toString()

	method textColor() = "#ffffff"

	method position() = game.at(game.width() - 3, game.height() - 1)

	method subirPuntaje(cantidad) {
		puntaje += cantidad
	}

}

object enter {

	method text() = "Presione enter para comenzar a jugar"

	method textColor() = "#ffffff"

	method position() = game.center()

}

