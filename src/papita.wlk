import wollok.game.*

object papita{
	var numero=1
	var position=self.posicionInicial()
	
	method image()="assets/papita" + numero.toString() + ".png"
	method position() = position

	method posicionInicial() = game.at(2.randomUpTo(6), game.height()+1)
	//la papita aparece en un lugar random entre las celdas 3 y 7 
	//un casillero arriba para que no se vea
	
	method aparecer(){
		position = self.posicionInicial()
		game.onTick(250,"moverPapita",{self.mover()})
		//cada 250 milisegundos se mueve la papita
	}
	
	method desaparecer(){
		game.removeTickEvent("moverPapita")
		position = self.posicionInicial()
	}
	
	method mover(){
		position = position.down(1) //muevo para abajo un casillero
		if (position.y() == -1)//si se fue del cuadro vuelvo a la pos inicial
			position = self.posicionInicial()
	}
	method rodar(){
		game.removeTickEvent("moverPapita") //deja de subir
		game.onTick(150,"girarPapita",{self.girar()})
	}
	
	method girar(){
		numero=4.min(numero+1) 
		if (numero==4) numero=1
		//cambia el numero para que se modifique la imagen y "gire"
		position=position.right(1) 
		//muevo uno a la derecha
		if (position.x() > game.width()){
			game.removeTickEvent("girarPapita")
			numero=1
			self.aparecer()
			}
		//cuando "desaparece" deja de moverse a la derecha y vuelve aparecer desde arriba
		}
}
