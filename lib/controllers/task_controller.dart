import 'package:get/get.dart';
import 'package:todoso/db/db_helper.dart';
import 'package:todoso/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>>? tasks = await DBHelper.query();
    taskList.assignAll(tasks!.map((data) => Task.fromJson(data)).toList());
  }

  delete(Task task) {
    DBHelper.delete(task);
  }
}
