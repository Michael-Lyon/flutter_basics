// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_anchor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitUnkownAnchor _$ARKitUnkownAnchorFromJson(Map<String, dynamic> json) =>
    ARKitUnkownAnchor(
      json['anchorType'] as String,
      json['nodeName'] as String,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List<double>),
    );

Map<String, dynamic> _$ARKitUnkownAnchorToJson(ARKitUnkownAnchor instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'identifier': instance.identifier,
      'transform': const MatrixConverter().toJson(instance.transform),
      'anchorType': instance.anchorType,
    };

ARKitPlaneAnchor _$ARKitPlaneAnchorFromJson(Map<String, dynamic> json) =>
    ARKitPlaneAnchor(
      const Vector3Converter().fromJson(json['center'] as List<double>),
      const Vector3Converter().fromJson(json['extent'] as List<double>),
      json['nodeName'] as String,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List<double>),
    );

Map<String, dynamic> _$ARKitPlaneAnchorToJson(ARKitPlaneAnchor instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'identifier': instance.identifier,
      'transform': const MatrixConverter().toJson(instance.transform),
      'center': const Vector3Converter().toJson(instance.center),
      'extent': const Vector3Converter().toJson(instance.extent),
    };

ARKitImageAnchor _$ARKitImageAnchorFromJson(Map<String, dynamic> json) =>
    ARKitImageAnchor(
      json['referenceImageName'] as String,
      const Vector2Converter()
          .fromJson(json['referenceImagePhysicalSize'] as List<double>),
      json['isTracked'] as bool,
      json['nodeName'] as String,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List<double>),
    );

Map<String, dynamic> _$ARKitImageAnchorToJson(ARKitImageAnchor instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'identifier': instance.identifier,
      'transform': const MatrixConverter().toJson(instance.transform),
      'referenceImageName': instance.referenceImageName,
      'referenceImagePhysicalSize':
          const Vector2Converter().toJson(instance.referenceImagePhysicalSize),
      'isTracked': instance.isTracked,
    };

ARKitFaceAnchor _$ARKitFaceAnchorFromJson(Map<String, dynamic> json) =>
    ARKitFaceAnchor(
      ARKitFace.fromJson(json['geometry'] as Map<String, dynamic>),
      (json['blendShapes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      json['isTracked'] as bool,
      json['nodeName'] as String,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List<double>),
      const MatrixConverter()
          .fromJson(json['leftEyeTransform'] as List<double>),
      const MatrixConverter()
          .fromJson(json['rightEyeTransform'] as List<double>),
    );

Map<String, dynamic> _$ARKitFaceAnchorToJson(ARKitFaceAnchor instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'identifier': instance.identifier,
      'transform': const MatrixConverter().toJson(instance.transform),
      'geometry': instance.geometry,
      'leftEyeTransform':
          const MatrixConverter().toJson(instance.leftEyeTransform),
      'rightEyeTransform':
          const MatrixConverter().toJson(instance.rightEyeTransform),
      'blendShapes': instance.blendShapes,
      'isTracked': instance.isTracked,
    };

ARKitBodyAnchor _$ARKitBodyAnchorFromJson(Map<String, dynamic> json) =>
    ARKitBodyAnchor(
      ARKitSkeleton.fromJson(json['skeleton'] as Map<String, dynamic>),
      json['isTracked'] as bool,
      json['nodeName'] as String,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List<double>),
    );

Map<String, dynamic> _$ARKitBodyAnchorToJson(ARKitBodyAnchor instance) =>
    <String, dynamic>{
      'nodeName': instance.nodeName,
      'identifier': instance.identifier,
      'transform': const MatrixConverter().toJson(instance.transform),
      'skeleton': instance.skeleton,
      'isTracked': instance.isTracked,
    };
