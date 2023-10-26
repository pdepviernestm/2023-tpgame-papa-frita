import wollok.game.*
import skin.*
import bomba.*
import jogo.*

object monigote {
	var property vivo = true
	var property position = game.origin()
	var property posicionVieja= position
	var property maxBombas = 1
	var property puntos = 0
	
	method image() = skin.monigote()
	
	method position() = position
	
	method sonido() = skin.sonidos().anyOne()
	
	method volver() = self.position(self.posicionVieja())
	
	method arriba() {
		posicionVieja= position
		position = position.up(1)
		game.sound(self.sonido()).play()		
			
	} 
	method abajo() {
		posicionVieja= position
		position = position.down(1)		
		game.sound(self.sonido()).play()	
	} 
	method izquierda() {
		posicionVieja= position
		position = position.left(1)		
		game.sound(self.sonido()).play()		
	} 
	method derecha() {
		posicionVieja= position
		position = position.right(1)	
		game.sound(self.sonido()).play()
	} 
	
	method ponerBomba() {
		if (jogo.bombas().size() < maxBombas) {
			var nuevaBomba = new bomba()
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