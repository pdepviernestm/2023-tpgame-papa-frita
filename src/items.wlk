import personaje.*
import wollok.game.*
import skin.*
import menu.*
import tablero.*

class Item {
	var property position

	method image()
	
	method chocar()
	
	method morir() {
		game.removeVisual(self)
	}
	
	method morirPorBomba() {
		game.removeVisual(self)
	}
	
	method agregarItem() {
		game.schedule(1000, {
			game.addVisual(self)
			}
		)
	} 
}

class Ayuda inherits Item {
	
	override method image() = skin.item()
	
	override method chocar() {
		var maxBombas = monigote.maxBombas()
		cantidadAyudas.cantidad(cantidadAyudas.cantidad()+1)
		monigote.maxBombas(maxBombas+1)
		game.removeVisual(self)
	}

}

class Puntos inherits Item {
	
	override method image() = skin.item2()
	
	override method chocar() {
		cantidadPuntos.cantidad(cantidadPuntos.cantidad()+20) 
		game.removeVisual(self)
	}
	
}
