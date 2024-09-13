// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_hit_test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitTestResult _$ARKitTestResultFromJson(Map<String, dynamic> json) =>
    ARKitTestResult(
      const ARKitHitTestResultTypeConverter()
          .fromJson((json['type'] as num).toInt()),
      (json['distance'] as num).toDouble(),
      const MatrixConverter().fromJson(json['localTransform'] as List<double>),
      const MatrixConverter().fromJson(json['worldTransform'] as List<double>),
      ARKitAnchor.fromJson(json['anchor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ARKitTestResultToJson(ARKitTestResult instance) =>
    <String, dynamic>{
      'type': const ARKitHitTestResultTypeConverter().toJson(instance.type),
      'distance': instance.distance,
      'localTransform': const MatrixConverter().toJson(instance.localTransform),
      'worldTransform': const MatrixConverter().toJson(instance.worldTransform),
      'anchor': instance.anchor,
    };
