
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course{
  String idDoc;
  late final String idUser;
  late final String namePill;
  late final String descriptionPill;
  late final String photoPill;
  late final String namePhotoPillInStorage;
  late final List <String> timeOfReceipt;

  Course({
    this.idDoc = '',
    required this.idUser,
    required this.namePill,
    required this.descriptionPill,
    required this.photoPill,
    required this.namePhotoPillInStorage,
    required this.timeOfReceipt,
  });

  @override
  String toString() => 'Название: $namePill, Описание: $descriptionPill, Фото: $photoPill,  Прием: $timeOfReceipt';

factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);



  }