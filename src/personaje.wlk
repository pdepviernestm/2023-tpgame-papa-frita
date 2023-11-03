import wollok.game.*
import skin.*
import bomba.*
import jogo.*

object monigote {
	var property vivo = true
	var property position = game.origin()
	var property posicionVieja= position
	var property maxBombas = 1
	
	method image() = skin.monigote()
	
	method position() = position
	
	method sonido() = skin.sonidos().anyOne()
	
	method volver() = self.position(self.posicionVieja())
	
	method movimiento() {
		posicionVieja= position
		game.sound(self.sonido()).play()
	}
	
	method arriba() {
		self.movimiento()
		position = position.up(1)	
	} 
	method abajo() {
		self.movimiento()
		position = position.down(1)		
	} 
	method izquierda() {
		self.movimiento()
		position = position.left(1)		
	} 
	method derecha() {
		self.movimiento()
		position = position.right(1)	
	} 
	
	method ponerBomba() {
		if (jogo.bombas().size() < maxBombas) {
			var nuevaBomba = new Bomba()
			jogo.bombas().add(nuevaBomba)
			nuevaBomba.colocar()
		}
	}
	method morir() {
		game.removeVisual(self)
		game.addVisual(mensajeDeMuerte)
		game.sound(skin.sonidoMuerte()).play()
		self.vivo(false)
	}
	method morirPorBomba(){
		game.removeVisual(self)
		game.addVisual(mensajeMuerteBomba)
		game.sound(skin.sonidoMuerte()).play()
		self.vivo(false)
	}
	
}

object mensajeDeMuerte {
	
	method position() = game.origin()
	
	method image() = skin.mensajeMuerte()
	
	method morir() {}
	
	method morirPorBomba() {}
	
}

object mensajeMuerteBomba {
	method position()=game.origin()
	method image()= skin.mensajeMuerteBomba()
}