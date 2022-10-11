import wollok.game.*
import papita.*
import menu.* //para la clase OpcionesMenu

object juego inherits OpcionesMenu {

	method image()="assets/fondoJuego.png"
	
	override method iniciar(){
		super()
		game.addVisual(papita)
		keyboard.enter().onPressDo{self.empezarJuego()} 
		//agregar algun cartel que diga "precione enter para iniciar" o algo asi
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