import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/hivedb/hive_type_constants.dart';
import 'package:hive/hive.dart';

part 'shared_file_state.g.dart';

@HiveType(typeId: HiveTypeConstant.sharedFileState)
enum SharedFileState {
  @HiveField(0)
  none,
  @HiveField(1)
  downloading,
  @HiveField(2)
  uploading,
  @HiveField(3)
  available,
}
