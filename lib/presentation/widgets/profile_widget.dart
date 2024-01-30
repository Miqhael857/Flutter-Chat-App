import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/extensions/string_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileWidget({String? imageUrl, File? image, String? name}) {
  if (image != null) {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  } else {
    if (imageUrl == null) {
      return Image.asset(
        'profile'.png,
        fit: BoxFit.cover,
        width: 120.w,
        height: 120.h,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => SizedBox(
          height: 50,
          width: 50,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.blueGrey.shade200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$name', overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      );
    }
  }
}
