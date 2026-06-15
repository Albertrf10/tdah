class SmartTaskBreaker {
  static const Map<String, List<String>> _templates = {
    'limpiar': [
      'Poner música o un podcast (estimulación)',
      'Recoger objetos del suelo (foco visual)',
      'Limpiar una sola superficie (meta pequeña)',
      'Tirar la basura acumulada',
      'Guardar productos de limpieza'
    ],
    'estudiar': [
      'Despejar el escritorio de distracciones',
      'Abrir el libro/apuntes en la página correcta',
      'Leer solo el primer párrafo o esquema',
      'Escribir 3 ideas clave',
      'Poner cronómetro para un descanso de 5 min'
    ],
    'cocinar': [
      'Beber un vaso de agua antes de empezar',
      'Sacar todos los ingredientes al mostrador',
      'Cortar solo un ingrediente',
      'Seguir el primer paso de la receta',
      'Limpiar mientras se cocina para evitar el caos'
    ],
    'duchar': [
      'Preparar la toalla y ropa limpia',
      'Poner el agua a la temperatura ideal',
      'Entrar y disfrutar del agua 1 minuto',
      'Usar el jabón favorito',
      'Secarse y vestirse inmediatamente'
    ],
    'ordenar': [
      'Elegir un rincón de 1 metro cuadrado',
      'Clasificar en: Guardar, Tirar o Donar',
      'Mover lo que se queda a su sitio',
      'Tirar lo que no sirve',
      'Celebrar el espacio despejado'
    ],
  };

  static List<String> breakDown(String title) {
    final lowerTitle = title.toLowerCase();
    
    for (final entry in _templates.entries) {
      if (lowerTitle.contains(entry.key)) {
        return entry.value;
      }
    }

    // Fallback genérico para cualquier tarea (Algoritmo de Acción Única)
    return [
      'Respirar profundo 3 veces',
      'Identificar el objeto físico necesario para empezar',
      'Tocar o preparar ese objeto',
      'Realizar la acción durante solo 2 minutos',
      'Decidir si quieres seguir o parar'
    ];
  }
}
