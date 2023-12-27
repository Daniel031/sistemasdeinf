class Producto {
  final String idProducto;
  final String nombre;
  final String idCatalogo;
  final String color;
  final String precio;
  final String cantidad;
  final String fotos;
  final String disponible;
  final String idNegocio;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.idCatalogo,
    required this.color,
    required this.precio,
    required this.cantidad,
    required this.fotos,
    required this.disponible,
    required this.idNegocio,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['IdPoducto'] ?? '',
      nombre: json['Producto'] ?? '',
      idCatalogo: json['IdCatalogo'] ?? '',
      color: json['Color'] ?? '',
      precio: json['Precio'] ?? '',
      cantidad: json['Cantidad'] ?? '',
      fotos: json['Fotos'] ?? '',
      disponible: json['Dsponible'] ?? '',
      idNegocio: json['IdNegocio'] ?? '',
    );
  }
}
