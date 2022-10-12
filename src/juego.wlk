import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu
import zombie.*

object juego{
	var position=self.posicionInicial()
	const listaZombies=[]
	method image()="assets/fondoJuego.png"
	method position() = position
	method posicionInicial()=game.at(game.width(),game.height()) //para que no se vea
	method iniciar(){
		position=game.origin()
		game.addVisual(reloj)
		keyboard.enter().onPressDo{self.empezarJuego()} 
		//agregar algun cartel que diga "precione enter para iniciar" o algo asi
	}
	method parar(){
		position=self.posicionInicial()
		papita.desaparecer()
	} 
	
	method empezarJuego(){
		game.clear()
//		position=game.origin()
		game.addVisual(self)
		//por si aprietan enter mientras juegan
		game.addVisual(papita)
		game.addVisual(reloj)
		game.addVisual(puntaje)
		reloj.iniciar()
		game.onTick(10000,"aparecerZombies",{self.crearZombies(1)})
		papita.aparecer()
		keyboard.space().onPressDo{papita.rodar()} 
		//cuando se aprieta espacio la papita deja de subir y empieza a rodar
		game.onCollideDo(papita,{ zombie => zombie.morir()
											papita.borrar()
		})
		keyboard.shift().onPressDo{=>juegoMenu.volverAlMenu(0)}	
	}
	
	method crearZombies(cantidad){
		var nuevo
		cantidad.times{x => nuevo= new Zombie()
			listaZombies.add(nuevo)
			game.addVisual(nuevo)
			nuevo.aparecer()
		}
	}
	method gameOver(){
		game.addVisual(gameOver)
		game.removeVisual(papita)
		reloj.detener()
		game.removeTickEvent("aparecerZombies") //para que desaparezcan todos
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
	method position() = game.at(game.width()-1, game.height()-1)
	
	method pasarTiempo() {
		tiempo = tiempo +1
	}
	method iniciar(){
		tiempo = 0
		game.onTick(1000,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
	}
}


object puntaje {
	var puntaje = 0
	method text() = "Puntaje: " + puntaje.toString()
	method textColor() = "#ffffff"
	method position() = game.at(game.width()-1, game.height()-2)
	
	method subirPuntaje(cantidad) {
		puntaje+=cantidad
	}
}
