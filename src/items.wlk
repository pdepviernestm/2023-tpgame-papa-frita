import personaje.*
import wollok.game.*
import skin.*
import menu.*

class item {
	var property position

	method image()
	
	method chocar()
	
	method morir() {
		game.removeVisual(self)
	}
	
	method morirPorBomba() {
		game.removeVisual(self)
	}
}

class ayuda inherits item {
	
	method image() = skin.item()
	
	method chocar() {
		var maxBombas = monigote.maxBombas()
		cantidadAyudas.cantidad(cantidadAyudas.cantidad()+1)
		monigote.maxBombas(maxBombas+1)
		game.removeVisual(self)
	}

}

class puntos inherits item {
	
	method image() = skin.item2()
	
	method chocar() {
		cantidadPuntos.cantidad(cantidadPuntos.cantidad()+20) 
		game.removeVisual(self)
	}
	
}
