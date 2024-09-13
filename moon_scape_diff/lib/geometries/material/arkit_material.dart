import 'package:arkit_plugin/geometries/material/arkit_blend_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_color_mask.dart';
import 'package:arkit_plugin/geometries/material/arkit_cull_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_fill_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_lighting_model.dart';
import 'package:arkit_plugin/geometries/material/arkit_material_property.dart';
import 'package:arkit_plugin/geometries/material/arkit_transparency_mode.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ui';

part 'arkit_material.g.dart';

@JsonSerializable()
class ARKitMaterial {
  ARKitMaterial({
    this.diffuse = const ARKitMaterialProperty(color: Color(0xFFFFFFFF)),
    this.ambient = const ARKitMaterialProperty(color: Color(0xFF000000)),
    this.specular = const ARKitMaterialProperty(color: Color(0xFFFFFFFF)),
    this.emission = const ARKitMaterialProperty(color: Color(0xFF000000)),
    this.transparent = const ARKitMaterialProperty(color: Color(0x00FFFFFF)),
    this.reflective,
    this.multiply,
    this.normal,
    this.displacement,
    this.ambientOcclusion,
    this.selfIllumination,
    this.metalness = const ARKitMaterialProperty(color: Color(0xFF000000)),
    this.roughness = const ARKitMaterialProperty(color: Color(0xFFFFFFFF)),
    this.shininess = 1.0,
    this.transparency = 1.0,
    this.lightingModelName = ARKitLightingModel.blinn,
    this.fillMode = ARKitFillMode.fill,
    this.cullMode = ARKitCullMode.back,
    this.transparencyMode = ARKitTransparencyMode.aOne,
    this.locksAmbientWithDiffuse = true,
    this.writesToDepthBuffer = true,
    this.colorBufferWriteMask = ARKitColorMask.all,
    this.doubleSided = false,
    this.blendMode = ARKitBlendMode.alpha,
  });

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty diffuse;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty ambient;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty specular;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty emission;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty transparent;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? reflective;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? multiply;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? normal;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? displacement;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? ambientOcclusion;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty? selfIllumination;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty metalness;

  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty roughness;

  final double shininess;
  final double transparency;

  @ARKitLightingModelConverter()
  final ARKitLightingModel lightingModelName;

  @ARKitFillModeConverter()
  final ARKitFillMode fillMode;

  @ARKitCullModeConverter()
  final ARKitCullMode cullMode;

  @ARKitTransparencyModeConverter()
  final ARKitTransparencyMode transparencyMode;

  final bool locksAmbientWithDiffuse;
  final bool writesToDepthBuffer;

  @ARKitColorMaskConverter()
  final ARKitColorMask colorBufferWriteMask;

  @ARKitBlendModeConverter()
  final ARKitBlendMode blendMode;

  final bool doubleSided;

  static ARKitMaterial fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitMaterialToJson(this);
}
