import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  Loader({
    required this.context,
  });

  void show() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dark background
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Loader
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.5,
            child: const Material(
              color: Colors.transparent,
              child: Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
