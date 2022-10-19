import wollok.game.*

class Papita{
	var numero=1
	var property position=self.posicionInicial()
	
	method image()="assets/papita" + numero.toString() + ".png"

	method posicionInicial() = game.at(2.randomUpTo(4), game.height()+1)
	//la papita aparece en un lugar random entre las celdas 2 y 4 
	//un casillero arriba para que no se vea
	
	method aparecer(){
		position = self.posicionInicial()
		game.onTick(300,"moverPapita",{self.mover()})
		//cada 300 milisegundos se mueve la papita
	}
	
	method mover(){
		position = position.down(1) //muevo para abajo un casillero
		if (position.y() == -1)//si se fue del cuadro vuelvo a la pos inicial
			position = self.posicionInicial()
	}
	
	method configurarTecla(){keyboard.space().onPressDo{self.rodar()}} //si se aprieta espacio rueda
	
	method rodar(){
		game.removeTickEvent("moverPapita")
		game.onTick(200,"girarPapita",{self.girar()})
	}
	
	method girar(){
		numero=4.min(numero+1) //"movimiento" de la imagen
		if (numero==4) numero=1 //loop
		
		position=position.right(1) //muevo uno a la derecha
		
		if (position.x() > game.width()){ //si desaparece de la pantalla deja de girar y vuelve a aparecer
			game.removeTickEvent("girarPapita")
			numero=1
			self.aparecer()
			}
		}
		
	method chocar(contraQuien){
		contraQuien.chocar()
		self.borrar()
	}
	
	method borrar(){
		game.removeTickEvent("girarPapita")
		numero=1
		self.aparecer()
	}
	
	method desaparecer(){
		game.removeTickEvent("moverPapita")
		position = self.posicionInicial() //para que no se vea cuando termina el juego
	}
	
	method chocar(){} //si se chocan las papitas entre si no para nada
}

object papitaViolenta inherits Papita{
	var diagonal=false
	
	override method image()="assets/papitaEnojada" + numero.toString() + ".png"
	
	override method posicionInicial() = game.at(1, game.height()+1)
	
	override method chocar(contraQuien){
		contraQuien.chocar()
		if (contraQuien.estaVivo()){ //si no mató al zombie rebota
			game.onTick(300,"moverPapitaDiagonal",{self.diagonal()
													diagonal=true
			})
			}
		else{self.borrar()}
	}
	
	override method aparecer(){
		if (diagonal){
			game.removeTickEvent("moverPapitaDiagonal")
			super()
		}
		else {super()}
	}
	override method configurarTecla(){keyboard.a().onPressDo{self.rodar()}} //si se aprieta espacio rueda
	method diagonal()=[position=position.left(1),position=position.right(1)].anyOne()
}


