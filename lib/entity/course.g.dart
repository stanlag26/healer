// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      idDoc: json['idDoc'] as String? ?? '',
      idUser: json['idUser'] as String,
      namePill: json['namePill'] as String,
      descriptionPill: json['descriptionPill'] as String,
      photoPill: json['photoPill'] as String,
      namePhotoPillInStorage: json['namePhotoPillInStorage'] as String,
      timeOfReceipt: (json['timeOfReceipt'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'idDoc': instance.idDoc,
      'idUser': instance.idUser,
      'namePill': instance.namePill,
      'descriptionPill': instance.descriptionPill,
      'photoPill': instance.photoPill,
      'namePhotoPillInStorage': instance.namePhotoPillInStorage,
      'timeOfReceipt': instance.timeOfReceipt,
    };
