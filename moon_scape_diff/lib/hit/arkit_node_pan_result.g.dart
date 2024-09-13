// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_node_pan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitNodePanResult _$ARKitNodePanResultFromJson(Map<String, dynamic> json) =>
    ARKitNodePanResult(
      json['nodeName'] as String,
      const Vector2Converter().fromJson(json['translation'] as List<double>),
    );

Map<String, dynamic> _$ARKitNodePanResultToJson(ARKitNodePanResult instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'translation': const Vector2Converter().toJson(instance.translation),
    };
