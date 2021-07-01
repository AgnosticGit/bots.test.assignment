import 'package:bots/models/task.model.dart';
import 'package:bots/services/rest.api.service.dart';
import 'package:bots/stores/global.store.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/api.url.dart';
import 'package:bots/utils/enums.dart';

class ApiRequestsService {
  static Future<void> getTaskList() async {
    await RestApiService<List<TaskModel>, dynamic>(
      url: ApiUrl.tasks,
      requestType: RequestType.get,
      headers: {'Accept': 'application/json'},
      setIsDisconnected: GlobalStore.to.setInternetDisconnected,
      setIsLoading: GlobalStore.to.setIsLoading,
      successFromJson: (json) {
        return json['data']
            .map<TaskModel>((json) => TaskModel.fromJson(json))
            .toList();
      },
      successToStore: TasksStore.to.setTasks,
    ).request();
  }

  static Future<void> addTask(TaskModel task) async {
    await RestApiService<TaskModel, dynamic>(
      url: ApiUrl.tasks,
      requestType: RequestType.post,
      headers: {'Accept': 'application/json'},
      setIsDisconnected: GlobalStore.to.setInternetDisconnected,
      setIsLoading: GlobalStore.to.setIsLoading,
      body: task.toJson(),
      successFromJson: (json) => TaskModel.fromJson(json['data']),
      successToStore: TasksStore.to.addTask,
    ).request();
  }

  static Future<void> changeTasksCompletedStatus(
    List<TaskModel> tasks,
    int completed,
  ) async {
    final tasksIDs = tasks.map<int>((task) => task.id!).toList();

    await RestApiService<List<TaskModel>, dynamic>(
      url: ApiUrl.changeTasksCompletedStatus + completed.toString(),
      requestType: RequestType.put,
      headers: {'Accept': 'application/json'},
      setIsDisconnected: GlobalStore.to.setInternetDisconnected,
      setIsLoading: GlobalStore.to.setIsLoading,
      body: {'tasks': tasksIDs},
      successFromJson: (json) {
        return json['data']
            .map<TaskModel>((json) => TaskModel.fromJson(json))
            .toList();
      },
      successToStore: TasksStore.to.rewriteTasksByNewTasks,
    ).request();
  }

  static Future<void> deleteTask(List<TaskModel> tasks) async {
    final tasksIDs = tasks.map<int>((task) => task.id!).toList();

    await RestApiService<List<TaskModel>, dynamic>(
      url: ApiUrl.tasks,
      requestType: RequestType.delete,
      headers: {'Accept': 'application/json'},
      setIsLoading: GlobalStore.to.setIsLoading,
      setIsDisconnected: GlobalStore.to.setInternetDisconnected,
      body: {'tasks': tasksIDs},
      executeIfSuccess: TasksStore.to.removeFromTasksSelectedTasks,
    ).request();
  }
}
