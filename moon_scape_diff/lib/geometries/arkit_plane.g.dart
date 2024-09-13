// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_plane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPlane _$ARKitPlaneFromJson(Map<String, dynamic> json) => ARKitPlane(
      width: (json['width'] as num?)?.toDouble() ?? 1,
      height: (json['height'] as num?)?.toDouble() ?? 1,
      widthSegmentCount: (json['widthSegmentCount'] as num?)?.toInt() ?? 1,
      heightSegmentCount: (json['heightSegmentCount'] as num?)?.toInt() ?? 1,
      materials: (json['materials'] as List<dynamic>?)
              ?.map((e) => ARKitMaterial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ARKitPlaneToJson(ARKitPlane instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  writeNotNull(
      'width', const DoubleValueNotifierConverter().toJson(instance.width));
  writeNotNull(
      'height', const DoubleValueNotifierConverter().toJson(instance.height));
  val['widthSegmentCount'] = instance.widthSegmentCount;
  val['heightSegmentCount'] = instance.heightSegmentCount;
  return val;
}
