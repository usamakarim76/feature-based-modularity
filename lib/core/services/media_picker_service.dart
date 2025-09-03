import 'dart:io';
import 'package:clean_architecture/core/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// A comprehensive service class for picking images and videos from camera or gallery
///
/// This service handles:
/// - Permission management
/// - Image/Video selection from camera or gallery
/// - Multiple image selection
/// - File compression and optimization
/// - User-friendly UI components
///
/// Usage:
/// ```dart
/// final mediaService = MediaPickerService();
/// File? image = await mediaService.pickImage(source: MediaSource.camera);
/// ```
class MediaPickerService {
  /// Singleton instance to ensure only one instance exists
  static final MediaPickerService _instance = MediaPickerService._internal();

  /// Factory constructor that returns the singleton instance
  factory MediaPickerService() => _instance;

  /// Private constructor for singleton pattern
  MediaPickerService._internal();

  /// Image picker instance from the image_picker package
  final ImagePicker _picker = ImagePicker();

  /// Main method to pick media (image or video) from camera or gallery
  ///
  /// Parameters:
  /// - [mediaType]: Type of media to pick (image or video)
  /// - [source]: Source of media (camera or gallery)
  /// - [maxDuration]: Maximum duration for video in seconds (video only)
  /// - [imageQuality]: Quality of image from 0-100 (image only)
  /// - [maxWidth]: Maximum width for image (image only)
  /// - [maxHeight]: Maximum height for image (image only)
  ///
  /// Returns: File object if successful, null if cancelled or failed
  ///
  /// Throws: Exception if permission denied or other errors occur
  Future<XFile?> pickMedia({
    required MediaType mediaType,
    required MediaSource source,
    int? maxDuration, // for video in seconds
    int? imageQuality, // for image 0-100
    double? maxWidth, // for image
    double? maxHeight, // for image
  }) async {
    try {
      // Check and request permissions before proceeding
      // bool hasPermission = await _checkPermissions(source);
      // if (!hasPermission) {
      //   throw Exception('Permission denied');
      // }

      XFile? pickedFile;

      // Pick media based on type
      if (mediaType == MediaType.image) {
        pickedFile = await _pickImage(
          source: source,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
      } else {
        pickedFile = await _pickVideo(source: source, maxDuration: maxDuration);
      }

      // Convert XFile to File if picked successfully
      if (pickedFile != null) {
        return pickedFile;
      }
      return null;
    } catch (e) {
      debugPrint('Error picking media: $e');
      rethrow;
    }
  }

  /// Private method to pick image from camera or gallery
  ///
  /// Parameters:
  /// - [source]: Source of image (camera or gallery)
  /// - [imageQuality]: Quality of image from 0-100 (default: 85)
  /// - [maxWidth]: Maximum width for image
  /// - [maxHeight]: Maximum height for image
  ///
  /// Returns: XFile object if successful, null if cancelled
  Future<XFile?> _pickImage({
    required MediaSource source,
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    // Convert MediaSource to ImageSource
    final ImageSource imageSource = source == MediaSource.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    // Pick image with specified parameters
    return await _picker.pickImage(
      source: imageSource,
      imageQuality: imageQuality ?? 85, // Default quality: 85%
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }

  /// Private method to pick video from camera or gallery
  ///
  /// Parameters:
  /// - [source]: Source of video (camera or gallery)
  /// - [maxDuration]: Maximum duration for video in seconds
  ///
  /// Returns: XFile object if successful, null if cancelled
  Future<XFile?> _pickVideo({
    required MediaSource source,
    int? maxDuration,
  }) async {
    // Convert MediaSource to ImageSource
    final ImageSource imageSource = source == MediaSource.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    // Pick video with specified parameters
    return await _picker.pickVideo(
      source: imageSource,
      maxDuration: maxDuration != null
          ? Duration(seconds: maxDuration)
          : null, // No duration limit if not specified
    );
  }

  /// Pick multiple images from gallery only
  ///
  /// Note: Multiple selection is only available from gallery, not camera
  ///
  /// Parameters:
  /// - [imageQuality]: Quality of images from 0-100 (default: 85)
  /// - [maxWidth]: Maximum width for each image
  /// - [maxHeight]: Maximum height for each image
  ///
  /// Returns: List of File objects (empty list if cancelled)
  ///
  /// Throws: Exception if permission denied or other errors occur
  Future<List<File>> pickMultipleImages({
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      // Check gallery permissions
      bool hasPermission = await _checkPermissions(MediaSource.gallery);
      if (!hasPermission) {
        throw Exception('Permission denied');
      }

      // Pick multiple images from gallery
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: imageQuality ?? 85, // Default quality: 85%
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      // Convert List<XFile> to List<File>
      return pickedFiles.map((file) => File(file.path)).toList();
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      rethrow;
    }
  }

  /// Show a bottom sheet to let user choose between camera and gallery
  ///
  /// This provides a user-friendly interface for source selection
  ///
  /// Parameters:
  /// - [context]: Build context for showing bottom sheet
  /// - [mediaType]: Type of media to pick (image or video)
  /// - [maxDuration]: Maximum duration for video in seconds (video only)
  /// - [imageQuality]: Quality of image from 0-100 (image only)
  /// - [maxWidth]: Maximum width for image (image only)
  /// - [maxHeight]: Maximum height for image (image only)
  ///
  /// Returns: File object if successful, null if cancelled
  Future<File?> showMediaSourceBottomSheet({
    required BuildContext context,
    required MediaType mediaType,
    int? maxDuration,
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    return await showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Select ${mediaType == MediaType.image ? 'Image' : 'Video'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Source options row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  _buildSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () async {
                      Navigator.pop(context); // Close bottom sheet
                      final file = await pickMedia(
                        mediaType: mediaType,
                        source: MediaSource.camera,
                        maxDuration: maxDuration,
                        imageQuality: imageQuality,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      );
                      Navigator.pop(context, file); // Return result
                    },
                  ),
                  // Gallery option
                  _buildSourceOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () async {
                      Navigator.pop(context); // Close bottom sheet
                      final file = await pickMedia(
                        mediaType: mediaType,
                        source: MediaSource.gallery,
                        maxDuration: maxDuration,
                        imageQuality: imageQuality,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      );
                      Navigator.pop(context, file); // Return result
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// Build a source option widget for bottom sheet
  ///
  /// Creates a tappable container with icon and label
  ///
  /// Parameters:
  /// - [icon]: Icon to display
  /// - [label]: Text label to display
  /// - [onTap]: Callback function when tapped
  ///
  /// Returns: Widget for source option
  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  /// Check and request permissions based on media source
  ///
  /// Different permissions are required for different sources:
  /// - Camera: Camera permission
  /// - Gallery: Photos permission (Android) or Photos Add Only (iOS)
  ///
  /// Parameters:
  /// - [source]: Media source (camera or gallery)
  ///
  /// Returns: true if permission granted, false otherwise
  Future<bool> _checkPermissions(MediaSource source) async {
    Permission permission;

    // Determine which permission to request based on source
    if (source == MediaSource.camera) {
      permission = Permission.camera;
    } else {
      // Gallery permissions differ by platform
      if (Platform.isAndroid) {
        permission = Permission.photos; // Android 13+
      } else {
        permission = Permission.photosAddOnly; // iOS
      }
    }

    // Check current permission status
    PermissionStatus status = await permission.status;

    // Request permission if denied
    if (status.isDenied) {
      status = await permission.request();
    }

    return status.isGranted;
  }

  /// Get file size in megabytes (MB)
  ///
  /// Useful for checking file size before upload or processing
  ///
  /// Parameters:
  /// - [filePath]: Path to the file
  ///
  /// Returns: File size in MB as double
  ///
  /// Example:
  /// ```dart
  /// double sizeInMB = await mediaService.getFileSizeInMB('/path/to/file.jpg');
  /// print('File size: ${sizeInMB.toStringAsFixed(2)} MB');
  /// ```
  Future<double> getFileSizeInMB(String filePath) async {
    final file = File(filePath);
    final bytes = await file.length();
    return bytes / (1024 * 1024); // Convert bytes to MB
  }

  /// Compress an image file
  ///
  /// Note: This is a placeholder implementation.
  /// For production use, consider using packages like flutter_image_compress
  ///
  /// Parameters:
  /// - [imageFile]: Original image file to compress
  /// - [quality]: Compression quality from 0-100 (default: 85)
  ///
  /// Returns: Compressed File object, null if compression failed
  Future<File?> compressImage(File imageFile, {int quality = 85}) async {
    try {
      // This is a basic implementation using image_picker
      // For better compression, use packages like flutter_image_compress
      final compressedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: quality,
      );

      if (compressedFile != null) {
        return File(compressedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return null;
    }
  }
}

/// Extension methods for MediaPickerService to provide convenient shortcuts
///
/// These methods provide quick access to common operations without
/// needing to specify all parameters explicitly
extension MediaPickerExtension on MediaPickerService {
  /// Quick method to pick an image with default settings
  ///
  /// Parameters:
  /// - [source]: Source of image (default: gallery)
  /// - [imageQuality]: Quality from 0-100 (default: 85)
  /// - [maxWidth]: Maximum width for image
  /// - [maxHeight]: Maximum height for image
  ///
  /// Returns: File object if successful, null if cancelled
  ///
  /// Example:
  /// ```dart
  /// File? image = await MediaPickerService().pickImage(source: MediaSource.camera);
  /// ```
  Future<XFile?> pickImage({
    MediaSource source = MediaSource.gallery,
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    return await pickMedia(
      mediaType: MediaType.image,
      source: source,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }

  /// Quick method to pick a video with default settings
  ///
  /// Parameters:
  /// - [source]: Source of video (default: gallery)
  /// - [maxDuration]: Maximum duration in seconds
  ///
  /// Returns: File object if successful, null if cancelled
  ///
  /// Example:
  /// ```dart
  /// File? video = await MediaPickerService().pickVideo(
  ///   source: MediaSource.camera,
  ///   maxDuration: 30, // 30 seconds max
  /// );
  /// ```
  Future<XFile?> pickVideo({
    MediaSource source = MediaSource.gallery,
    int? maxDuration,
  }) async {
    return await pickMedia(
      mediaType: MediaType.video,
      source: source,
      maxDuration: maxDuration,
    );
  }
}
