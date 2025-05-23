class Universidad {
  var property provincia
  var property honorarios
  var property donaciones
}
class ProfesionalVinculado {
  const property universidad
  method puedenTrabajarEn() = [universidad.provincia()]
  method honorariosPercibidos() = universidad.honorarios()
  method cobrar(unMonto){
    universidad.donaciones(unMonto * 0.5)
  }
}
class ProfesionalLitoral {
  const property universidad
  method puedenTrabajarEn() = ["Entre Rios","Santa Fe","Corrientes"]
  method honorariosPercibidos() = 3000
  method cobrar(unMonto){
    asociacionLitoral.cobrarDonaciones(unMonto)
  }
}
class ProfesionalLibres {
  const property universidad
  const property puedenTrabajarEn = []
  var property honorariosPercibidos 
  var cobros = 0
  method cobrar(unMonto){
    cobros += unMonto
  }
  method pasarDinero(unMonto,unProfesional){
    unProfesional.cobrar(unMonto)
    cobros = 0.max(cobros - unMonto)
  }
}
class Empresa {
  const profesionales = []
  const clientes = []
  var property honorarioReferencia
  method contratarProfesional(unProfesional){
    profesionales.add(unProfesional)
  }
  method estudioEnLaUniversidad(unaUniversidad) = profesionales.count({p=>p.universidad() == unaUniversidad})
  method profesionalesCaros() = profesionales.filter({p=>p.honorariosPercibidos() > honorarioReferencia}).asSet()
  method universidadesFormadoras() = profesionales.map({p=>p.universidad()}).asSet()
  method profesionalMasBarato() = profesionales.min({p=>p.honorariosPercibidos()})
  method esDeGenteAcotada() = profesionales.all({p=>p.puedenTrabajarEn().size() <= 3})
  method puedeSatisfacerAUn(unSolicitante) = profesionales.any({p=>unSolicitante.puedeSerAtendidoPor(p)})
  method darServicio(unSolicitante){
        if (self.puedeSatisfacerAUn(unSolicitante)){
            const unProf = profesionales.find({p => unSolicitante.puedeSerAtendidoPor(p)})
            unProf.cobrar(unProf.honorario())
            clientes.add(unSolicitante)
        }
    }
    method cantidadClientes(){
        return clientes.size()
    }
    method tieneComoClientesA(unSolicitante){
        return clientes.contains(unSolicitante)
    }
    method esProfesionalPocoAtractivo(unProfesional){
        const prof = unProfesional.provinciasDondeTrabaja().asSet()
        const otroProf = profesionales.find({p => p.provinciasDondeTrabaja().asSet() == prof })
        return otroProf.any({p => p.honorario() < unProfesional.honorario()})
    }
}
object asociacionLitoral {
  var donaciones = 0
  method cobrarDonaciones(unaDonacion){
    donaciones += unaDonacion
  }
}