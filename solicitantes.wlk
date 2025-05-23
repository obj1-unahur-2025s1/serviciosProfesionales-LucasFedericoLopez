class Persona {
    const property provincia
    method puedeSerAtendidoPorUn(unProfesional) =
        unProfesional.provincia().contains(provincia) 
}
class Institucion {
    const property universidades = []
    method agregarUniversidad(unaUniversidad){
        universidades.add(unaUniversidad)
    }
    method puedeSerAtendidoPorUn(unProfesional) =
        universidades.contains(unProfesional.universidad())
}
class Club {
    const property provincia = []
    method puedeSerAtendidoPorUn(unProfesional) =
        provincia.contains(unProfesional.puedeTrabajarEn())
}