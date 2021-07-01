import 'package:bots/models/task.model.dart';
import 'package:bots/services/math.service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test completed tasks only one and only completed', () {
    final data = [TaskModel(createdAt: DateTime.now(), completed: 1, id: 0)];
    final res = MathService.countTasks(data, 1);
    expect(res, 1);
  });

  test('Test completed tasks only one and only uncompleted', () {
    final data = [TaskModel(createdAt: DateTime.now(), id: 0)];
    final res = MathService.countTasks(data, 0);
    expect(res, 1);
  });

  test('Test completed tasks only one and opposite completed', () {
    final data = [TaskModel(createdAt: DateTime.now(), id: 0)];
    final res = MathService.countTasks(data, 1);
    expect(res, 0);
  });

  test('Test completed tasks only one and opposite uncompleted', () {
    final data = [TaskModel(createdAt: DateTime.now(), completed: 1, id: 0)];
    final res = MathService.countTasks(data, 0);
    expect(res, 0);
  });

  test('Test some only completed', () {
    final data = [
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 0),
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 1),
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 2),
    ];
    final res = MathService.countTasks(data, 1);
    expect(res, 3);
  });

  test('Test some only uncompleted', () {
    final data = [
      TaskModel(createdAt: DateTime.now(), id: 0),
      TaskModel(createdAt: DateTime.now(), id: 1),
      TaskModel(createdAt: DateTime.now(), id: 2),
    ];
    final res = MathService.countTasks(data, 0);
    expect(res, 3);
  });

  test('Test some different', () {
    final data = [
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 0),
      TaskModel(createdAt: DateTime.now(), id: 1),
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 2),
      TaskModel(createdAt: DateTime.now(), completed: 1, id: 3),
      TaskModel(createdAt: DateTime.now(), id: 4),
      TaskModel(createdAt: DateTime.now(), id: 5),
      TaskModel(createdAt: DateTime.now(), id: 6),
    ];
    final resCompleted = MathService.countTasks(data, 1);
    final resUncompleted = MathService.countTasks(data, 0);
    expect(resCompleted, 3);
    expect(resUncompleted, 4);
  });
}
