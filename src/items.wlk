import personaje.*
import wollok.game.*
import skin.*

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
		monigote.maxBombas(maxBombas+1)
		game.removeVisual(self)
	}

}

class puntos inherits item {
	
	method image() = skin.item2()
	
	method chocar() {
		var puntosActuales = monigote.puntos()
		monigote.puntos(puntosActuales+20)
		game.removeVisual(self)
	}
	
}
