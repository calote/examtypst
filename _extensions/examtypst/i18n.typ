// ============================================
// SISTEMA DE INTERNACIONALIZACIÓN
// ============================================

#let traducciones = (
  es: (
    ejercicio: "Ejercicio",
    problema: "Problema",
    pregunta: "Pregunta",
    solucion: "Solución",
    puntos: "puntos",
    punto: "punto",
    nombre: "Nombre",
    apellidos: "Apellidos",
    dni: "DNI/NIF",
    grupo: "Grupo",
    fecha: "Fecha",
    calificacion: "Calificación",
    total: "Total",
    verdadero: "V",
    falso: "F",
    pagina: "Página",
    de: "de",
  ),
  
  en: (
    ejercicio: "Exercise",
    problema: "Problem",
    pregunta: "Question",
    solucion: "Solution",
    puntos: "points",
    punto: "point",
    nombre: "Name",
    apellidos: "Surname",
    dni: "ID",
    grupo: "Group",
    fecha: "Date",
    calificacion: "Grade",
    total: "Total",
    verdadero: "T",
    falso: "F",
    pagina: "Page",
    de: "of",
  ),
  
  fr: (
    ejercicio: "Exercice",
    problema: "Problème",
    pregunta: "Question",
    solucion: "Solution",
    puntos: "points",
    punto: "point",
    nombre: "Nom",
    apellidos: "Prénom",
    dni: "ID",
    grupo: "Groupe",
    fecha: "Date",
    calificacion: "Note",
    total: "Total",
    verdadero: "V",
    falso: "F",
    pagina: "Page",
    de: "de",
  ),
  
  de: (
    ejercicio: "Übung",
    problema: "Problem",
    pregunta: "Frage",
    solucion: "Lösung",
    puntos: "Punkte",
    punto: "Punkt",
    nombre: "Name",
    apellidos: "Nachname",
    dni: "Ausweis",
    grupo: "Gruppe",
    fecha: "Datum",
    calificacion: "Note",
    total: "Gesamt",
    verdadero: "W",
    falso: "F",
    pagina: "Seite",
    de: "von",
  ),
  
  pt: (
    ejercicio: "Exercício",
    problema: "Problema",
    pregunta: "Pergunta",
    solucion: "Solução",
    puntos: "pontos",
    punto: "ponto",
    nombre: "Nome",
    apellidos: "Sobrenome",
    dni: "ID",
    grupo: "Grupo",
    fecha: "Data",
    calificacion: "Nota",
    total: "Total",
    verdadero: "V",
    falso: "F",
    pagina: "Página",
    de: "de",
  ),
)

// Función para obtener traducciones
#let t(key, lang: "es") = {
  if lang in traducciones {
    if key in traducciones.at(lang) {
      return traducciones.at(lang).at(key)
    }
  }
  // Fallback a español
  return traducciones.es.at(key, default: key)
}