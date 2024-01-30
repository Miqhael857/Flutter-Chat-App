import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoader([String? text]) {
  EasyLoading.show(
    status: text ?? 'Please wait...',
    indicator: const CircularProgressIndicator.adaptive(),
  );
}

void hideLoader() {
  EasyLoading.dismiss();
}
