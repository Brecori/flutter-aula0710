import 'package:get/get.dart';
import 'package:novo/database/task.database.dart';
import 'package:novo/domain/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDataSource {
  late SharedPreferences _preference;
  final TaskDatabase _database = TaskDatabase.instance;
  final Rx<List<Task>?> _tasks = Rx(null);

  initPreference() async {
    _preference = await SharedPreferences.getInstance();
  }

  String? load(String key) {
    return _preference.getString(key);
  }

  save(String key, String value){
    _preference.setString(key, value);
  }
  
  saveTask(Task task) {
    _database.insert(task);
  }
  
  loadTasks() async {
    _tasks.value = await _database.readALl();
  }
}