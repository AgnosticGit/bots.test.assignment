import 'package:json_annotation/json_annotation.dart';

part 'task.model.g.dart';

@JsonSerializable()
class TaskModel {
  TaskModel({
    this.id,
    this.title = '',
    this.completed = 0,
    this.createdAt,
  });

  int? id;
  String title;
  int completed;

  @JsonKey(name: 'created_at')
  DateTime? createdAt = DateTime.now();

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
