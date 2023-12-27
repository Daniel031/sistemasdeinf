class JsonModel {
  final int number;
  final int origin;
  final double valueX;
  final double valueY;

  JsonModel(
      {required this.number,
      required this.origin,
      required this.valueX,
      required this.valueY});

  factory JsonModel.fromJson(Map<String, dynamic> json) {
    return JsonModel(
      number: json['numero'],
      origin: json['origen'],
      valueX: json['valor_x'],
      valueY: json['valor_y'],
    );
  }
}
