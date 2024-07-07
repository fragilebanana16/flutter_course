import 'package:flutter/material.dart';

class TipPrompt {
  static final TipPrompt _singleton = TipPrompt._internal();

  factory TipPrompt() {
    return _singleton;
  }

  TipPrompt._internal();
}
