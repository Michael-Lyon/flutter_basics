// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_skeleton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitSkeleton _$ARKitSkeletonFromJson(Map<String, dynamic> json) =>
    ARKitSkeleton(
      const MapOfMatrixConverter()
          .fromJson(json['modelTransforms'] as Map<String, List<double>>),
      const MapOfMatrixConverter()
          .fromJson(json['localTransforms'] as Map<String, List<double>>),
    );

Map<String, dynamic> _$ARKitSkeletonToJson(ARKitSkeleton instance) =>
    <String, dynamic>{
      'modelTransforms':
          const MapOfMatrixConverter().toJson(instance.modelTransforms),
      'localTransforms':
          const MapOfMatrixConverter().toJson(instance.localTransforms),
    };
