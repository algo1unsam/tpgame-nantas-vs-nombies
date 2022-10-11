import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu

object juego inherits OpcionesMenu {

	method image()="assets/fondoJuego.png"
	
	override method iniciar(){
		super()
		//agregar algun cartel que diga "precione enter para iniciar" o algo asi
		keyboard.b().onPressDo{self.empezarJuego()} 
	}
	override method parar(){
		super()
		papita.desaparecer()
	} 
	method empezarJuego(){
		papita.aparecer()
	}
}