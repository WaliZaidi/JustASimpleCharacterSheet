import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void initState(BuildContext context);

  void resetState();
}
