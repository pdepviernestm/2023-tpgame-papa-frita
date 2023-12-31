import wollok.game.*
import skin.*
import personaje.*
import jogo.*

class Explosion {
	var property position
	method image() = skin.explosion()
	
	method generarExplosion() {
		game.addVisual(self)
		game.schedule(1000, {=> game.removeVisual(self)})
		game.whenCollideDo(self,{e=>e.morirPorBomba()})
	}
	
	method chocar() { }
	
	method morir () { }
	method morirPorBomba(){}
}

class Bomba {
	
	var property tiempoEnExplotar = 2000 // en ms
	var property position = monigote.position()
	var property image = skin.bomba()
	const explosiones = []
	
	method colocar() {
		game.addVisual(self)
		game.schedule(tiempoEnExplotar, {=> self.explotar()})
	}
	
	method explotar() {
		game.removeVisual(self)
		jogo.bombas().remove(self)
		explosiones.add(new Explosion(position = position))
		explosiones.add(new Explosion(position = position.up(1)))
		explosiones.add(new Explosion(position = position.down(1)))
		explosiones.add(new Explosion(position = position.left(1)))
		explosiones.add(new Explosion(position = position.right(1)))		
	
		explosiones.forEach({e => e.generarExplosion()})	
	}
	
	method chocar() { }
	method morir() { }
	method morirPorBomba() { }

}