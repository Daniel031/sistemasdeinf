class Catalogo {
  final String idCatalogo;
  final String nombre;

  Catalogo({
    required this.idCatalogo,
    required this.nombre,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) {
    return Catalogo(
      idCatalogo: json['IdCatalogo'] ?? '',
      nombre: json['Nombre'] ?? '',
    );
  }
}
