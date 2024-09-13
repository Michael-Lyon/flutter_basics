// ignore_for_file: tighten_type_of_initializing_formals

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This widgets will be responsible for displaying images on the screen.
/// It has 4 constructors,
///
/// [PyImageHelper.pngJpg]: The first one is used to display png, jpeg,
/// jpg images.
///
/// [PyImageHelper.svg]: second one is used to  display svg images.
///
/// [PyImageHelper.file]:  To display an image from the device.
///
/// [PyImageHelper.network]:  To display an image from the internet.

class PyImageHelper extends StatelessWidget {
  /// This named constructor is used to render png,jpg,jpeg images to the screen
  const PyImageHelper.pngJpg(
    this.imagePath, {
    super.key,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.color,
  })  : _isSvg = false,
        file = null,
        networkUrl = null,
        assert(
          imagePath != null,
          'You must provide an image path/url',
        );

  /// This named constructor is used to render svg images to the screen.
  const PyImageHelper.svg(
    this.imagePath, {
    super.key,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.color,
  })  : _isSvg = true,
        file = null,
        networkUrl = null,
        assert(
          imagePath != null,
          'You must provide an image path/url',
        );

  /// This named constructor is used to render svg images to the screen.
  const PyImageHelper.network(
    this.networkUrl, {
    super.key,
    bool? isSvg,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.color,
  })  : _isSvg = isSvg ?? false,
        file = null,
        imagePath = null,
        assert(
          networkUrl != null,
          'You must provide an url',
        );

  /// This constructor renders image from the device.
  const PyImageHelper.file(
    this.file, {
    super.key,
    bool? isSvg,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.color,
  })  : _isSvg = isSvg ?? false,
        imagePath = null,
        networkUrl = null,
        assert(
          file != null,
          'You must provide an a file',
        );

  /// local asset image path.
  final String? imagePath;

  /// Boolean to check if file is a svg file.
  final bool _isSvg;

  /// Network url member.
  final String? networkUrl;

  /// {@macro flutter.widgets.BoxDecoration.fit}
  final BoxFit? fit;

  /// {@macro flutter.widgets.BoxDecoration.alignment}
  final Alignment? alignment;

  /// The height to set on the image.
  final double? height;

  /// The width to set on the image.
  final double? width;

  /// {@macro flutter.widgets.BoxDecoration.fit}
  final Color? color;

  /// File from device.
  final File? file;

  @override
  Widget build(BuildContext context) {
    return _isSvg
        ? _SvgWidget(
            key: key,
            path: networkUrl ?? imagePath,
            isNetworkImage: networkUrl != null,
            fit: fit!,
            alignment: alignment!,
            height: height,
            width: width,
            color: color,
            file: file,
          )
        : _PngWidget(
            key: key,
            path: networkUrl ?? imagePath,
            isNetworkImage: networkUrl != null,
            fit: fit!,
            alignment: alignment!,
            height: height,
            width: width,
            color: color,
            file: file,
          );
  }
}

class _SvgWidget extends StatelessWidget {
  const _SvgWidget({
    required this.path,
    required this.isNetworkImage,
    required this.fit,
    required this.alignment,
    required this.file,
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final String? path;
  final bool isNetworkImage;
  final BoxFit fit;
  final Alignment alignment;
  final double? height;
  final double? width;
  final Color? color;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return file != null
        ? SvgPicture.file(
            file!,
            fit: fit,
            alignment: alignment,
            height: height,
            width: width,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          )
        : isNetworkImage
            ? SvgPicture.network(
                path!,
                fit: fit,
                alignment: alignment,
                height: height,
                width: width,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
              )
            : SvgPicture.asset(
                path!,
                fit: fit,
                alignment: alignment,
                height: height,
                width: width,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
              );
  }
}

class _PngWidget extends StatelessWidget {
  const _PngWidget({
    required this.path,
    required this.isNetworkImage,
    required this.fit,
    required this.alignment,
    required this.file,
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final String? path;
  final bool isNetworkImage;
  final BoxFit fit;
  final Alignment alignment;
  final double? height;
  final double? width;
  final Color? color;
  final File? file;
  @override
  Widget build(BuildContext context) {
    return file != null
        ? Image.file(
            file!,
            fit: fit,
            alignment: alignment,
            height: height,
            width: width,
            color: color,
          )
        : isNetworkImage
            ? CachedNetworkImage(
                imageUrl: path!,
                fit: fit,
                alignment: alignment,
                height: height,
                width: width,
                color: color,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.close, color: Colors.red),
                placeholder: (context, url) => SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : Image.asset(
                path!,
                fit: fit,
                alignment: alignment,
                height: height,
                width: width,
                color: color,
              );
  }
}
