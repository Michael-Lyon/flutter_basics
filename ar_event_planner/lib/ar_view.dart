import 'package:ar_event_planner/floor_plan_view.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:io';
import 'package:vector_math/vector_math_64.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARView extends StatefulWidget {
  @override
  _ARViewState createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  ArCoreController? arCoreController;
  ARKitController? arKitController;
  bool isScanning = false;

  List<Vector3> floorPlanPoints = [];

  @override
  void dispose() {
    arCoreController?.dispose();
    arKitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Floor Plan'),
      ),
      // body: Platform.isAndroid ? _buildAndroidARView() : _buildIOSARView(),
      body: Stack(
        children: [
          Platform.isAndroid ? _buildAndroidARView() : _buildIOSARView(),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: isScanning ? _finishScanning : _startScanning,
                child: Text(isScanning ? 'Finish Scanning' : 'Start Scanning'),
              ),
            ),
          ),
          if (isScanning)
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                    'Scanning in progress... ${floorPlanPoints.length} points collected'),
              ),
            ),
        ],
      ),
    );
  }

  void _startScanning() {
    setState(() {
      isScanning = true;
      floorPlanPoints.clear();
    });
  }

  void _finishScanning() {
    setState(() {
      isScanning = false;
    });
    _navigateToFloorPlanView();
  }

  Widget _buildAndroidARView() {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
    );
  }

  Widget _buildIOSARView() {
    return ARKitSceneView(
      onARKitViewCreated: _onARKitViewCreated,
      planeDetection: ARPlaneDetection.horizontal,
      showStatistics: true,
      enablePinchRecognizer: true,
      showFeaturePoints: true,
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
  }

  void _onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    arKitController?.onAddNodeForAnchor = _handleOnAddNodeForAnchor;
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    if (!isScanning) return;
    setState(() {
      final center = plane.centerPose?.translation ?? vector.Vector3.zero();
      final extentX = plane.extendX ?? 0.0;
      final extentZ = plane.extendZ ?? 0.0;
      floorPlanPoints.addAll([
        vector.Vector3(
            center.x - extentX / 2, center.y, center.z - extentZ / 2),
        vector.Vector3(
            center.x + extentX / 2, center.y, center.z - extentZ / 2),
        vector.Vector3(
            center.x + extentX / 2, center.y, center.z + extentZ / 2),
        vector.Vector3(
            center.x - extentX / 2, center.y, center.z + extentZ / 2),
      ]);
    });
  }

  void _handleOnAddNodeForAnchor(ARKitAnchor anchor) {
    if (!isScanning) return;
    if (anchor is ARKitPlaneAnchor) {
      setState(() {
        floorPlanPoints.addAll([
          Vector3(anchor.center.x - anchor.extent.x / 2, anchor.center.y,
              anchor.center.z - anchor.extent.z / 2),
          Vector3(anchor.center.x + anchor.extent.x / 2, anchor.center.y,
              anchor.center.z - anchor.extent.z / 2),
          Vector3(anchor.center.x + anchor.extent.x / 2, anchor.center.y,
              anchor.center.z + anchor.extent.z / 2),
          Vector3(anchor.center.x - anchor.extent.x / 2, anchor.center.y,
              anchor.center.z + anchor.extent.z / 2),
        ]);
      });
    }
  }

  void _navigateToFloorPlanView() {
    print(floorPlanPoints);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FloorPlanView(floorPlanPoints),
      ),
    );
  }
}
