import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:google_maps_flutter/google_maps_flutter.dart' show MarkerId;
import 'package:google_maps_flutter/google_maps_flutter.dart' show Marker;

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    @required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  LatLng getLatLng() {
    final dataLatng = this.valor.replaceFirst('geo:', '').split(',');
    return new LatLng(
        double.parse(dataLatng[0].trim()), double.parse(dataLatng[1].trim()));
  }

  Set<Marker> getmarkers() {
    final markers = Set<Marker>();
    markers
        .add(Marker(markerId: MarkerId('geo-location'), position: getLatLng()));

    return markers;
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
