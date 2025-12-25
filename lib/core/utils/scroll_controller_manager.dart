import 'package:flutter/widgets.dart';

class ScrollControllerManager {
  final ScrollController controller = ScrollController();

  void dispose() {
    controller.dispose();
  }
}
