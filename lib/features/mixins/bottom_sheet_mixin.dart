import 'package:flutter/material.dart';

mixin BottomSheetMixin {
  Future<T?> showBottomSheetCustom<T>(BuildContext context, Widget widget) {
    return showModalBottomSheet<T>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return SingleChildScrollView(
            child: widget,
          );
        });
  }
}
