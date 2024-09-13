// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitUnkownGeometry _$ARKitUnkownGeometryFromJson(Map<String, dynamic> json) =>
    ARKitUnkownGeometry(
      json['geometryType'] as String,
      (json['materials'] as List<dynamic>)
          .map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ARKitUnkownGeometryToJson(ARKitUnkownGeometry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  val['geometryType'] = instance.geometryType;
  return val;
}
