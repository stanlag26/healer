
import 'package:hive/hive.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  late final String nameUser;

  @HiveField(1)
  late final String firstEntry;

  UserHive({
    required this.nameUser,
    required this.firstEntry,
  });
  @override
  String toString() => '$nameUser, $firstEntry';

}

//команда для генерации  flutter packages pub run build_runner watch
