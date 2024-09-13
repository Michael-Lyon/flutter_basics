// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_light.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLight _$ARKitLightFromJson(Map<String, dynamic> json) => ARKitLight(
      type: json['type'] == null
          ? ARKitLightType.omni
          : const ARKitLightTypeConverter()
              .fromJson((json['type'] as num).toInt()),
      color: json['color'] == null
          ? Colors.white
          : const ColorConverter().fromJson((json['color'] as num?)?.toInt()),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 6500,
      intensity: (json['intensity'] as num?)?.toDouble() ?? 0.8,
      spotInnerAngle: (json['spotInnerAngle'] as num?)?.toDouble() ?? 0,
      spotOuterAngle: (json['spotOuterAngle'] as num?)?.toDouble() ?? 45,
    );

Map<String, dynamic> _$ARKitLightToJson(ARKitLight instance) {
  final val = <String, dynamic>{
    'type': const ARKitLightTypeConverter().toJson(instance.type),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('color', const ColorConverter().toJson(instance.color));
  val['temperature'] = instance.temperature;
  writeNotNull('intensity',
      const DoubleValueNotifierConverter().toJson(instance.intensity));
  val['spotInnerAngle'] = instance.spotInnerAngle;
  val['spotOuterAngle'] = instance.spotOuterAngle;
  return val;
}
