class Negocio {
  final String idNegocio;
  final String nombre;
  final String sigla;
  final String imagen;
  final String direccion;
  final String telefono;
  final String mail;
  final String paginaWeb;
  final String longitud;
  final String latitud;
  final String idCenComercial;
  final String nro;

  Negocio({
    required this.idNegocio,
    required this.nombre,
    required this.sigla,
    required this.imagen,
    required this.direccion,
    required this.telefono,
    required this.mail,
    required this.paginaWeb,
    required this.longitud,
    required this.latitud,
    required this.idCenComercial,
    required this.nro,
  });

  factory Negocio.fromJson(Map<String, dynamic> json) {
    return Negocio(
      idNegocio: json['IdNegocio'] ?? '',
      nombre: json['Nombre'] ?? '',
      sigla: json['Sigla'] ?? '',
      imagen: json['Imagen'] ?? '',
      direccion: json['Direccion'] ?? '',
      telefono: json['Telefono'] ?? '',
      mail: json['Mail'] ?? '',
      paginaWeb: json['Pagina Web'] ?? '',
      longitud: json['Longitud'] ?? '',
      latitud: json['Latitud'] ?? '',
      idCenComercial: json['IdCenComercial'] ?? '',
      nro: json['Nro'] ?? '',
    );
  }
}
