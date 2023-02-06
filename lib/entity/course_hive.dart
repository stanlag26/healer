
import 'package:hive/hive.dart';

part 'course_hive.g.dart';

@HiveType(typeId: 1)
class CourseHive extends HiveObject {
  @HiveField(0)
  late final String namePill;

  @HiveField(1)
  late final String descriptionPill;

  @HiveField(2)
  late final String photoPill;

  @HiveField(3)
  late final List <String> timeOfReceipt;

  CourseHive({
    required this.namePill,
    required this.descriptionPill,
    required this.photoPill,
    required this.timeOfReceipt,
  });
  @override
  String toString() => 'Название: $namePill, Описание: $descriptionPill, Фото: $photoPill,  Прием: $timeOfReceipt';

}

//команда для генерации  flutter packages pub run build_runner watch
