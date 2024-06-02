import 'package:google_maps_flutter/google_maps_flutter.dart';

class Scan {
  final int? id;
  String value;
  String? type;
  String description;

  Scan({
    this.id,
    this.type,
    this.description = '',
    required this.value,
  }) {
    type = value.contains('http') ? 'URL' : 'LOCATION';

    if (type == 'LOCATION') {
      value = value.replaceAll('geo:', '');
    }
  }

  factory Scan.fromMap(Map<String, dynamic> scan) {
    return Scan(id: scan['id'], value: scan['value'], type: scan['type'], description: scan['description']);
  }

  LatLng getLatLng() {
    List<String> coords =
        this.value.replaceAll(' ', '').replaceAll('geo:', '').split(',');
    return LatLng(double.parse(coords[0]), double.parse(coords[1]));
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'value': value, 'type': type, 'description': description};
  }

  @override
  String toString() {
    return 'Scan: $id - $type - $value - $description';
  }
}
