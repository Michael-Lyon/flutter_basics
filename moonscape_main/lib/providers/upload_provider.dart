import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:moonscape_main/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadState {
  final bool isUploading;
  final String? errorMessage;

  UploadState({required this.isUploading, this.errorMessage});

  UploadState copyWith({bool? isUploading, String? errorMessage}) {
    return UploadState(
      isUploading: isUploading ?? this.isUploading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UploadNotifier extends StateNotifier<UploadState> {
  UploadNotifier() : super(UploadState(isUploading: false));

  final Logger logger = Logger();

  Future<void> uploadImage(XFile image) async {
    state = state.copyWith(isUploading: true);
    final ApiService apiService = ApiService();
    final Box box = Hive.box('models');

    final taskData = await apiService.uploadImage(image.path, image.name);

    if (taskData != null && !taskData.containsKey('error')) {
      String taskId = taskData['task_id'] ?? '';
      box.put(taskId, taskData);
      state = state.copyWith(isUploading: false);
      // Optionally, you can handle a success message or further logic here.
      // For example, you can show a success toast message to the user.
      showToast('Image uploaded successfully');
      // Or you can navigate to a different screen.
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen()));
    } else {
      final errorMessage = taskData?['error'] ?? 'Unknown error occurred.';
      state = state.copyWith(isUploading: false, errorMessage: errorMessage);
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

final uploadProvider = StateNotifierProvider<UploadNotifier, UploadState>(
  (ref) => UploadNotifier(),
);
