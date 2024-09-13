// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsBody _$ARKitPhysicsBodyFromJson(Map<String, dynamic> json) =>
    ARKitPhysicsBody(
      const ARKitPhysicsBodyTypeConverter()
          .fromJson((json['type'] as num).toInt()),
      shape: ARKitPhysicsShape.fromJson(json['shape'] as Map<String, dynamic>),
      categoryBitMask: (json['categoryBitMask'] as num).toInt(),
    );

Map<String, dynamic> _$ARKitPhysicsBodyToJson(ARKitPhysicsBody instance) =>
    <String, dynamic>{
      'type': const ARKitPhysicsBodyTypeConverter().toJson(instance.type),
      'shape': instance.shape,
      'categoryBitMask': instance.categoryBitMask,
    };
