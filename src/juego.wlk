import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu
import zombie.*

object juego{
	var position=self.posicionInicial()
	const zombies=[]
	const papita=new Papita()
	
	method image()="assets/fondoJuego.png"
	method position() = position
	
	method posicionInicial()=game.at(game.width(),game.height()) //para que no se vea
	method iniciar(){
		position=game.origin()
		game.addVisual(reloj)
		keyboard.enter().onPressDo{self.empezarJuego()} 
		//agregar algun cartel que diga "presione enter para iniciar" o algo asi
	}
	
	method empezarJuego(){
		game.clear()
		position=game.origin()
		game.addVisual(self)
		//por si aprietan enter mientras juegan
		game.addVisual(papita)
		game.addVisual(papitaViolenta)
		game.addVisual(reloj)
		game.addVisual(puntaje)
		reloj.iniciar()
		game.onTick(5000,"aparecerZombies",{self.crearZombies(1)})
		game.onTick(30000,"aparecerPapitasViolentas",{papitaViolenta.aparecer()})
		papita.aparecer()
		papita.configurarTecla()
		papitaViolenta.configurarTecla()
		keyboard.shift().onPressDo{=>juegoMenu.volverAlMenu()}	
	}
	
	method crearZombies(cantidad){
		var nuevo
		cantidad.times{x => nuevo= new Zombie()
			zombies.add(nuevo)
			game.addVisual(nuevo)
			nuevo.aparecer()}
		game.onCollideDo(nuevo,{ papitaCualquiera => papitaCualquiera.chocar(nuevo)})
	}
	
	method gameOver(){
		game.addVisual(gameOver)
		game.removeVisual(papita)
		game.removeVisual(papitaViolenta)
		reloj.detener()
		zombies.forEach{zombie=>zombie.desaparecer()} //borra todos los zombies que ya estaban 
		game.removeTickEvent("aparecerZombies") //para que dejen de aparecer
	}
	method parar(){
		position=self.posicionInicial()
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
	method chocar(aQuien){}
}

object puntaje {
	var puntaje = 0
	method text() = "Puntaje: " + puntaje.toString()
	method textColor() = "#ffffff"
	method position() = game.at(game.width()-3, game.height()-1)
	
	method subirPuntaje(cantidad) {
		puntaje+=cantidad
	}
	method chocar(aQuien){}
}
