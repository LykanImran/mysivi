import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  int currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
