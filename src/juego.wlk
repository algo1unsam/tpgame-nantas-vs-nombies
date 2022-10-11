import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu

object juego inherits OpcionesMenu {

	method image()="assets/fondoJuego.png"
	
	override method iniciar(){
		super()
		//agregar algun cartel que diga "precione z para iniciar" o algo asi
		keyboard.z().onPressDo{self.empezarJuego()} 
	}
	override method parar(){
		super()
		papita.desaparecer()
	} 
	method empezarJuego(){
		papita.aparecer()
		keyboard.space().onPressDo{papita.rodar()} 
		//cuando se aprieta espacio la papita deja de subir y empieza a rodar
	}
}