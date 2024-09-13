import 'package:arkit_plugin/light/arkit_light_type.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_light.g.dart';

/// ARKitLight represents a light that can be attached to a ARKitNode.
@JsonSerializable()
class ARKitLight {
  ARKitLight({
    this.type = ARKitLightType.omni,
    this.color = Colors.white,
    this.temperature = 6500,
    double intensity = .8,
    this.spotInnerAngle = 0,
    this.spotOuterAngle = 45,
  }) : intensity = ValueNotifier(intensity);

  @ARKitLightTypeConverter()
  final ARKitLightType type;

  @ColorConverter()
  final Color? color;

  final double temperature;

  @DoubleValueNotifierConverter()
  final ValueNotifier<double> intensity;

  final double spotInnerAngle;
  final double spotOuterAngle;

  static ARKitLight fromJson(Map<String, dynamic> json) =>
      _$ARKitLightFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitLightToJson(this);
}
