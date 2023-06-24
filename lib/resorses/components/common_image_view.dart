import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../util/assets.dart';
import '../../util/loading_widget.dart';


class CommonImageView extends StatelessWidget {
  final String? image;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final bool? isCircle;
  final double? radius;
  final String? defaultAssetImage;
  final String? basePathUrl;
  final BorderRadius? borderRadius;

  const CommonImageView({
    Key? key,
    this.image,
    this.boxFit,
    this.height,
    this.width,
    this.isCircle,
    this.radius,
    this.defaultAssetImage,
    this.basePathUrl,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: image != null
            ? CachedNetworkImage(
                color: Colors.transparent,
                // cacheKey: image,
                key: Key(image ?? "1"),
                fit: boxFit ?? BoxFit.cover,
                width: width,
                height: height,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: isCircle == true
                          ? null
                          : borderRadius ?? BorderRadius.circular(radius ?? 0),
                      color: Colors.transparent,
                      border: isCircle == false
                          ? Border.all(color: Colors.white)
                          : Border.all(color: Colors.transparent),
                      shape: isCircle == true
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: boxFit ?? BoxFit.cover,
                      ),
                      boxShadow: isCircle == true
                          ? [
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                              ),
                            ]
                          : []),
                ),
                imageUrl: image?.contains('http') == true
                    ? '$image'
                    : getCorrectImagePath(image),
                progressIndicatorBuilder: (ctx, stringName, progress) {
                  return const LoadingWidget();
                },

                errorWidget: (context, _, __) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  child: Image.asset(defaultAssetImage ?? Assets.DEFAULT_IMAGE,
                      fit: BoxFit.cover),
                ),
              )
            : ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: Image.asset(
                    width: width,
                    height: height,
                    defaultAssetImage ?? Assets.DEFAULT_IMAGE,
                    fit: BoxFit.cover),
              ),
      ),
    ]);
  }

  String getCorrectImagePath(String? imagePath) {
    String? tempImagePath = imagePath;

    if (imagePath != null &&
        imagePath.isNotEmpty &&
        imagePath.startsWith("/")) {
      tempImagePath = (basePathUrl ?? imagePath.replaceFirst("/", ""));
    } else {
      tempImagePath = "$basePathUrl$imagePath";
    }

    log("getCorrectImagePath: $tempImagePath");
    return tempImagePath;
  }
}
