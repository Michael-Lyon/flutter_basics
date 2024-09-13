import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'package:moonscape_main/display_ar/ar_combo.dart';
import 'package:moonscape_main/display_ar/native_ar_mode.dart';
// import 'package:moonscape_main/display_ar/object_plane.dart';
import 'package:moonscape_main/services/api_service.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:io';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/services.dart';
// Adjust the import path if needed

class ModelViewerScreen extends StatefulWidget {
  final Map<String, dynamic> modelData;
  final String taskId;

  const ModelViewerScreen(
      {required this.modelData, required this.taskId, super.key});

  @override
  _ModelViewerScreenState createState() => _ModelViewerScreenState();
}

class _ModelViewerScreenState extends State<ModelViewerScreen> {
  final Logger logger = Logger();
  final Box _box = Hive.box('models');
  Map<String, dynamic>? updatedModelData;
  String _errorMessage = '';
  final ApiService apiService = ApiService();
  static const platform = MethodChannel('pygod');

  late String url;
  late String iosUrl;

  @override
  void initState() {
    super.initState();
    _initializeUrls();
    _fetchModelData();
  }

  Future<void> _launchAR(String modelUrl) async {
    try {
      await platform.invokeMethod('launchAR', {'modelUrl': modelUrl});
    } on PlatformException catch (e) {
      print("Failed to launch AR: '${e.message}'.");
    }
  }

  void _initializeUrls() {
    if (updatedModelData != null && updatedModelData!['model_urls'] != null) {
      url = _decodeUrl(updatedModelData!['model_urls']['glb'].toString());
      iosUrl = _decodeUrl(updatedModelData!['model_urls']['usdz'].toString());
    } else {
      url = '';
      iosUrl = '';
    }
  }

  Future<void> _fetchModelData() async {
    logger
        .d('ABOUT FETCHING: Fetching model data for task ID: ${widget.taskId}');
    logger.d('DATA MODEL: ${widget.modelData}');

    if (widget.modelData['status'] == "processing" ||
        widget.modelData['status'] == "completed") {
      logger.d('Fetching model data for task ID: ${widget.taskId}');
      final response = await apiService.checkStatus(widget.taskId);

      if (response != null && !response.containsKey('error')) {
        logger.d('Updated model data received: $response');
        setState(() {
          updatedModelData = response;
          _initializeUrls(); // Reinitialize URLs after fetching data
        });
        _box.put(widget.taskId, updatedModelData);
      } else if (response != null && response['status'] == 'processing') {
        logger.d('Model still processing: ${response['status']}');
        await Future.delayed(const Duration(seconds: 30));
        if (mounted) {
          _fetchModelData();
        }
      } else {
        setState(() {
          _errorMessage = response?['error'] ?? 'Unknown error occurred.';
        });
      }
    } else {
      logger.d('Status not in processing or completed');
      updatedModelData = widget.modelData;
      _initializeUrls(); // Initialize URLs based on existing data
      setState(() {});
    }
  }

  String _decodeUrl(String url) {
    final x = HtmlUnescape().convert(url);
    return x;
  }

  void _navigateToARObjectsScreen() {
    if (url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ARScreen(
            modelUrl: iosUrl,
          ),
          // builder: (context) => ObjectGesturesWidget(
          //   modelUrl: url,
          // ),
          //  builder: (context) => ARGlbManipulationPage(
          //   modelUrl: url,
        ),
        // builder: (context) => IOSARScreen(
        // builder: (context) => LoadGltfOrGlbFilePage(
        // builder: (context) => CombinedARPage(
        // modelUrl: url,
        // ),
        // ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AR model URL is not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.d(updatedModelData);
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Viewer'),
      ),
      body: Center(
        child: updatedModelData == null
            ? _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )
                : const CircularProgressIndicator()
            : ModelViewer(
                backgroundColor: const Color(0xFFEEEEEE),
                src: url,
                alt: 'A 3D model',
                ar: true,
                arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                autoRotate: true,
                iosSrc: iosUrl,
                disableZoom: false,
                autoPlay: true,
              ),
      ),
      floatingActionButton: Platform.isIOS
          ? FloatingActionButton(
              onPressed: () {
                _launchAR(iosUrl);
              },
              child: const Icon(Icons.view_in_ar),
            )
          : null, // FAB only visible on iOS
    );
  }
}
