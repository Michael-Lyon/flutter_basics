// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterialProperty _$ARKitMaterialPropertyFromJson(
        Map<String, dynamic> json) =>
    ARKitMaterialProperty(
      color: const ColorConverter().fromJson((json['color'] as num?)?.toInt()),
      image: json['image'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ARKitMaterialPropertyToJson(
    ARKitMaterialProperty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', const ColorConverter().toJson(instance.color));
  writeNotNull('image', instance.image);
  writeNotNull('url', instance.url);
  return val;
}
