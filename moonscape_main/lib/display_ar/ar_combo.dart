import 'dart:io';
import 'dart:math' as math;

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class ARGlbManipulationPage extends StatefulWidget {
  final String modelUrl;

  const ARGlbManipulationPage({Key? key, required this.modelUrl})
      : super(key: key);

  @override
  _ARGlbManipulationPageState createState() => _ARGlbManipulationPageState();
}

class _ARGlbManipulationPageState extends State<ARGlbManipulationPage> {
  late ARKitController arkitController;
  ARKitNode? modelNode;
  final Logger logger = Logger();
  bool isLoading = false;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Load and Manipulate GLB')),
        body: Stack(
          children: [
            ARKitSceneView(
              showFeaturePoints: true,
              enableTapRecognizer: true,
              enablePinchRecognizer: true,
              enablePanRecognizer: true,
              enableRotationRecognizer: true,
              planeDetection: ARPlaneDetection.horizontal,
              onARKitViewCreated: onARKitViewCreated,
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Set up gesture handlers
    this.arkitController.onNodePinch = _onPinchHandler;
    this.arkitController.onNodePan = _onPanHandler;
    this.arkitController.onNodeRotation = _onRotationHandler;

    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );
    _loadGLBModel(position);
  }

  Future<void> _loadGLBModel(vector.Vector3 position) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      final node = await _getNodeFromNetwork(position);
      arkitController.add(node);
      modelNode = node;
      logger.d('Model loaded and added to scene.');
    } catch (e) {
      logger.e('Failed to load model: $e');
      _showErrorSnackBar('Failed to load model.');
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  Future<ARKitGltfNode> _getNodeFromNetwork(vector.Vector3 position) async {
    try {
      final file = await _downloadFile(widget.modelUrl);
      if (file.existsSync()) {
        logger.d('Model file downloaded: ${file.path}');
        return ARKitGltfNode(
          assetType: AssetType.documents,
          url: file.path.split('/').last,
          scale: vector.Vector3(0.5, 0.5, 0.5),
          position: position,
        );
      } else {
        throw Exception('Downloaded file does not exist.');
      }
    } catch (e) {
      logger.e('Error downloading model: $e');
      throw Exception('Failed to load model from network.');
    }
  }

  Future<File> _downloadFile(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/${url.split("/").last}';
      await Dio().download(url, filePath);
      logger.d('Download completed!! Path = $filePath');
      return File(filePath);
    } catch (e) {
      logger.e('Error downloading file: $e');
      throw Exception('Failed to download file.');
    }
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinchResults) {
    final pinch = pinchResults.firstWhereOrNull(
      (e) => e.nodeName == modelNode?.name,
    );
    if (pinch != null) {
      logger.d('Pinch detected: ${pinch.scale}');
      final scale = vector.Vector3.all(pinch.scale);
      modelNode?.scale = scale;
      logger.d('Setting new scale: $scale');
    } else {
      logger.d('Pinch not applied to the correct node.');
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> panResults) {
    final pan = panResults.firstWhereOrNull(
      (e) => e.nodeName == modelNode?.name,
    );
    if (pan != null) {
      final old = modelNode?.eulerAngles;
      final newAngleY = pan.translation.x * math.pi / 180;
      modelNode?.eulerAngles =
          vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
      logger.d('Pan detected: ${pan.translation}');
      logger.d('Setting new eulerAngles: ${modelNode?.eulerAngles}');
    } else {
      logger.d("No pan found");
    }
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotationResults) {
    final rotation = rotationResults.firstWhereOrNull(
      (e) => e.nodeName == modelNode?.name,
    );
    if (rotation != null) {
      final eulerAngles = modelNode?.eulerAngles ??
          vector.Vector3.zero() + vector.Vector3.all(rotation.rotation);
      modelNode?.eulerAngles = eulerAngles;
      logger.d('Rotation detected: ${rotation.rotation}');
      logger.d('Setting new eulerAngles: ${modelNode?.eulerAngles}');
    } else {
      logger.d("No rotation found");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
