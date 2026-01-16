import 'package:flutter/material.dart';

void showTopMessage(
  BuildContext context,
  String message, {
  Color backgroundColor = Colors.red,
}) {
  final overlay = Overlay.of(context);

  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 6),
            ],
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3)).then((_) {
    overlayEntry.remove();
  });
}