import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/poem.dart';

class PoemService {
  static List<Poem>? _cachedPoems;

  static Future<Poem> getRandomPoem() async {
    if (_cachedPoems == null) {
      final jsonStr = await rootBundle.loadString('assets/texts/poems.json');
      final List<dynamic> jsonList = json.decode(jsonStr);
      _cachedPoems = jsonList.map((e) => Poem.fromJson(e)).toList();
    }
    final random = Random();
    return _cachedPoems![random.nextInt(_cachedPoems!.length)];
  }
}
