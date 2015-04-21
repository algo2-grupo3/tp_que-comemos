package ar.tp.dieta

import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestNuevoUsuario {

	Usuario usuarioNuevo
	Usuario usuarioSinNombre
	
	@Before
	def void init(){
		usuarioNuevo = new Usuario => [
			setNombre("Carlos")
			setPeso(103.35)
			setAltura(1.75)
		
			setFechaDeNacimiento(1989, 6, 28) //Nacio el 28 de junio de 1989
			setRutina(new RutinaIntensiva)
			agregarCondicion(new CondicionHipertension)
		]
		
		usuarioSinNombre = new Usuario =>[
			setPeso(85.6)
			setAltura(1.81)
		
			setFechaDeNacimiento(1930, 3, 15) //Nacio el 28 de junio de 1989
			setRutina(new RutinaIntensiva)
			
			agregarCondicion(new CondicionHipertension)
		]

	}

	@Test
	def void validarUnUsuario(){
		usuarioNuevo.validarUsuario()
	}
	
	@Test (expected=typeof (IllegalArgumentException))
	def void usuarioSinNombreNoSeValida(){ //Intentamos validar sin nombre, los demas requisitos se construyen igual.
		usuarioSinNombre.validarUsuario()
	}
	
	// @Test del IMC
	@Test
	def void usuarioConRutinaSaludable(){
		Assert.assertTrue(usuarioNuevo.sigoUnaRutinaSaludable())
	}
 
 	@Test
 	def void usuarioCreaReceta(){

 		usuarioNuevo.crearReceta("Pure", 200, "1) Papar 2) Pisar", "Facil", "Todo el año")
 		Assert.assertFalse(usuarioNuevo.misRecetas.empty)
 		Assert.assertTrue(usuarioNuevo.misRecetas.exists[receta | receta.devolverNombre() == "Pure"])
 	}
 		
 	 
 	@Test
 	def void modificaReceta(){
 		
 		usuarioNuevo.crearReceta("Pure", 200, "1) Papar 2) Pisar", "Facil", "Todo el año")
 		usuarioNuevo.modificarReceta("Pure", "Papada", 0, "0", "0", "0")
 		Assert.assertTrue((usuarioNuevo.devolverReceta("Papada")).devolverNombre() == "Papada")
 		
 	}
 	 
}