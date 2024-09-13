/// This class holds file paths for all logistat assets
/// such as images, svgs, gifs, lotties.
class AppAssetsFinder {
  AppAssetsFinder._();

  static const String _svgLocation = 'assets/svg/';
  static const String _pngLocation = 'assets/png/';
  static const String _jpgLocation = 'assets/image/';
  static const String _webpLocation = 'assets/webp/';

  static const String _pngFileExtension = '.png';
  static const String _svgFileExtension = '.svg';
  static const String _jpgFileExtension = '.jpeg';
  static const String _webpFileExtension = '.webp';

  /// This method abstracts out the long file path when calling an SVG asset.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  static String getSvgPath(String assetName) {
    return _svgLocation + assetName + _svgFileExtension;
  }

  /// This method abstracts out the long file path when calling a PNG asset.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  static String getPngPath(String assetName) {
    return _pngLocation + assetName + _pngFileExtension;
  }

  /// This method abstracts out the long file path when calling a JPG asset.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  static String getJpgPath(String assetName) {
    return _jpgLocation + assetName + _jpgFileExtension;
  }

  /// This method abstracts out the long file path when calling a WebP asset.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  static String getWebpPath(String assetName) {
    return _webpLocation + assetName + _webpFileExtension;
  }

  /// This method abstracts out the long file path when calling an image asset.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  ///
  /// Note if the image is not a [_pngFileExtension], then you can provide
  /// the [fileExtension] that satisfies your use case.
  /// e.g. {.jpg, .jpeg, .webp}
  static String getImagePath(String assetName, {String? fileExtension}) {
    fileExtension ??= _pngFileExtension; // Provide a default value if null

    if (fileExtension == _jpgFileExtension) {
      return _jpgLocation + assetName + fileExtension;
    } else if (fileExtension == _webpFileExtension) {
      return _webpLocation + assetName + fileExtension;
    } else {
      // Default to PNG if no specific extension is provided
      return _pngLocation + assetName + fileExtension;
    }
  }
}
