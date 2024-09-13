// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitMaterial _$ARKitMaterialFromJson(Map<String, dynamic> json) =>
    ARKitMaterial(
      diffuse: json['diffuse'] == null
          ? const ARKitMaterialProperty(color: Color(0xFFFFFFFF))
          : ARKitMaterialProperty.fromJson(
              json['diffuse'] as Map<String, dynamic>),
      ambient: json['ambient'] == null
          ? const ARKitMaterialProperty(color: Color(0xFF000000))
          : ARKitMaterialProperty.fromJson(
              json['ambient'] as Map<String, dynamic>),
      specular: json['specular'] == null
          ? const ARKitMaterialProperty(color: Color(0xFFFFFFFF))
          : ARKitMaterialProperty.fromJson(
              json['specular'] as Map<String, dynamic>),
      emission: json['emission'] == null
          ? const ARKitMaterialProperty(color: Color(0xFF000000))
          : ARKitMaterialProperty.fromJson(
              json['emission'] as Map<String, dynamic>),
      transparent: json['transparent'] == null
          ? const ARKitMaterialProperty(color: Color(0x00FFFFFF))
          : ARKitMaterialProperty.fromJson(
              json['transparent'] as Map<String, dynamic>),
      reflective: const ARKitMaterialPropertyConverter()
          .fromJson(json['reflective'] as Map<String, dynamic>?),
      multiply: const ARKitMaterialPropertyConverter()
          .fromJson(json['multiply'] as Map<String, dynamic>?),
      normal: const ARKitMaterialPropertyConverter()
          .fromJson(json['normal'] as Map<String, dynamic>?),
      displacement: const ARKitMaterialPropertyConverter()
          .fromJson(json['displacement'] as Map<String, dynamic>?),
      ambientOcclusion: const ARKitMaterialPropertyConverter()
          .fromJson(json['ambientOcclusion'] as Map<String, dynamic>?),
      selfIllumination: const ARKitMaterialPropertyConverter()
          .fromJson(json['selfIllumination'] as Map<String, dynamic>?),
      metalness: json['metalness'] == null
          ? const ARKitMaterialProperty(color: Color(0xFF000000))
          : ARKitMaterialProperty.fromJson(
              json['metalness'] as Map<String, dynamic>),
      roughness: json['roughness'] == null
          ? const ARKitMaterialProperty(color: Color(0xFFFFFFFF))
          : ARKitMaterialProperty.fromJson(
              json['roughness'] as Map<String, dynamic>),
      shininess: (json['shininess'] as num?)?.toDouble() ?? 1.0,
      transparency: (json['transparency'] as num?)?.toDouble() ?? 1.0,
      lightingModelName: json['lightingModelName'] == null
          ? ARKitLightingModel.blinn
          : const ARKitLightingModelConverter()
              .fromJson((json['lightingModelName'] as num).toInt()),
      fillMode: json['fillMode'] == null
          ? ARKitFillMode.fill
          : const ARKitFillModeConverter()
              .fromJson((json['fillMode'] as num).toInt()),
      cullMode: json['cullMode'] == null
          ? ARKitCullMode.back
          : const ARKitCullModeConverter()
              .fromJson((json['cullMode'] as num).toInt()),
      transparencyMode: json['transparencyMode'] == null
          ? ARKitTransparencyMode.aOne
          : const ARKitTransparencyModeConverter()
              .fromJson((json['transparencyMode'] as num).toInt()),
      locksAmbientWithDiffuse: json['locksAmbientWithDiffuse'] as bool? ?? true,
      writesToDepthBuffer: json['writesToDepthBuffer'] as bool? ?? true,
      colorBufferWriteMask: json['colorBufferWriteMask'] == null
          ? ARKitColorMask.all
          : const ARKitColorMaskConverter()
              .fromJson((json['colorBufferWriteMask'] as num).toInt()),
      doubleSided: json['doubleSided'] as bool? ?? false,
      blendMode: json['blendMode'] == null
          ? ARKitBlendMode.alpha
          : const ARKitBlendModeConverter()
              .fromJson((json['blendMode'] as num).toInt()),
    );

Map<String, dynamic> _$ARKitMaterialToJson(ARKitMaterial instance) {
  final val = <String, dynamic>{
    'diffuse': instance.diffuse,
    'ambient': instance.ambient,
    'specular': instance.specular,
    'emission': instance.emission,
    'transparent': instance.transparent,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reflective',
      const ARKitMaterialPropertyConverter().toJson(instance.reflective));
  writeNotNull('multiply',
      const ARKitMaterialPropertyConverter().toJson(instance.multiply));
  writeNotNull(
      'normal', const ARKitMaterialPropertyConverter().toJson(instance.normal));
  writeNotNull('displacement',
      const ARKitMaterialPropertyConverter().toJson(instance.displacement));
  writeNotNull('ambientOcclusion',
      const ARKitMaterialPropertyConverter().toJson(instance.ambientOcclusion));
  writeNotNull('selfIllumination',
      const ARKitMaterialPropertyConverter().toJson(instance.selfIllumination));
  val['metalness'] = instance.metalness;
  val['roughness'] = instance.roughness;
  val['shininess'] = instance.shininess;
  val['transparency'] = instance.transparency;
  val['lightingModelName'] =
      const ARKitLightingModelConverter().toJson(instance.lightingModelName);
  val['fillMode'] = const ARKitFillModeConverter().toJson(instance.fillMode);
  val['cullMode'] = const ARKitCullModeConverter().toJson(instance.cullMode);
  val['transparencyMode'] =
      const ARKitTransparencyModeConverter().toJson(instance.transparencyMode);
  val['locksAmbientWithDiffuse'] = instance.locksAmbientWithDiffuse;
  val['writesToDepthBuffer'] = instance.writesToDepthBuffer;
  val['colorBufferWriteMask'] =
      const ARKitColorMaskConverter().toJson(instance.colorBufferWriteMask);
  val['blendMode'] = const ARKitBlendModeConverter().toJson(instance.blendMode);
  val['doubleSided'] = instance.doubleSided;
  return val;
}
