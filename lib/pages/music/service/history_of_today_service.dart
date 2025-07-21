import 'dart:math';
import 'package:flutter_course/pages/music/repo/today_in_history_repo.dart';

class HistoryTodayService {
  static List<String>? _cachedPoems;

  static Future<Map<String, dynamic>> getRandomHistoryToday() async {
    final repo = TodayInHistoryRepo();
    await repo.open();
    final records = await repo.getTodayRecords();
    await repo.close(); // 用完关闭释放资源
    // for (var item in records) {
    //   print('${item['year']}年: ${item['data']}');
    // }
    final random = Random();
    return records![random.nextInt(records!.length)];
  }
}
