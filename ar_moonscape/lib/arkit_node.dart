import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/light/arkit_light.dart';
import 'package:arkit_plugin/physics/arkit_physics_body.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:arkit_plugin/utils/matrix4_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:arkit_plugin/utils/random_string.dart' as random_string;
import 'package:vector_math/vector_math_64.dart';

class ARKitNode {
  ARKitNode({
    this.geometry,
    this.physicsBody,
    this.light,
    this.renderingOrder = 0,
    bool isHidden = false,
    Vector3? position,
    Vector3? scale,
    Vector4? rotation,
    Vector3? eulerAngles,
    String? name,
    Matrix4? transformation,
  })  : name = name ?? random_string.randomString(),
        isHidden = ValueNotifier(isHidden),
        transformNotifier = ValueNotifier(createTransformMatrix(
            transformation!, position!, scale!, rotation!, eulerAngles!));

  final ARKitGeometry? geometry;

  Matrix4 get transform => transformNotifier.value;

  set transform(Matrix4 matrix) {
    transformNotifier.value = matrix;
  }

  Vector3 get position => transform.getTranslation();

  set position(Vector3 value) {
    final old = Matrix4.fromFloat64List(transform.storage);
    final newT = old.clone();
    newT.setTranslation(value);
    transform = newT;
  }

  Vector3 get scale => transform.matrixScale;

  set scale(Vector3 value) {
    transform =
        Matrix4.compose(position, Quaternion.fromRotation(rotation), value);
  }

  Matrix3 get rotation => transform.getRotation();

  set rotation(Matrix3 value) {
    transform =
        Matrix4.compose(position, Quaternion.fromRotation(value), scale);
  }

  Vector3 get eulerAngles => transform.matrixEulerAngles;

  set eulerAngles(Vector3 value) {
    final old = Matrix4.fromFloat64List(transform.storage);
    final newT = old.clone();
    newT.matrixEulerAngles = value;
    transform = newT;
  }

  final ValueNotifier<Matrix4> transformNotifier;

  final String name;

  final ARKitPhysicsBody? physicsBody;

  final ARKitLight? light;

  final int renderingOrder;

  final ValueNotifier<bool> isHidden;

  static const _boolValueNotifierConverter = ValueNotifierConverter();
  static const _matrixValueNotifierConverter = MatrixValueNotifierConverter();

  Map<String, dynamic> toMap() => <String, dynamic>{
        'dartType': runtimeType.toString(),
        'geometry': geometry?.toJson(),
        'transform': _matrixValueNotifierConverter.toJson(transformNotifier),
        'physicsBody': physicsBody?.toJson(),
        'light': light?.toJson(),
        'name': name,
        'renderingOrder': renderingOrder,
        'isHidden': _boolValueNotifierConverter.toJson(isHidden),
      }..removeWhere((String k, dynamic v) => v == null);
}
