import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:qardan/features/home/data/model/task_model.dart';
import 'package:qardan/features/home/presentation/manager/cubit/task_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreventiveTasksCubit extends Cubit<PreventiveTasksState> {
  PreventiveTasksCubit() : super(PreventiveTasksInitial());

  Future<void> fetchPreventiveTasks() async {
    emit(PreventiveTasksLoading());
     final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    try {
      final response = await Dio().get(
        'https://lobster-fast-solely.ngrok-free.app/api/preventive-tasks',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );
      print('RESPONSE STATUS: ${response.statusCode}');
print('RESPONSE BODY: ${response.data}');

      if (response.data['success'] == true) {
        List tasksJson = response.data['preventive_tasks'];
        List<PreventiveTask> tasks = tasksJson
            .map((json) => PreventiveTask.fromJson(json))
            .toList();
        print('tasksJson: ${tasksJson}');
        emit(PreventiveTasksLoaded(tasks: tasks));
      } else {
        emit(PreventiveTasksError(message: 'فشل في تحميل المهام.'));
      }
    } catch (e) {
      emit(PreventiveTasksError(message: e.toString()));
    }
  }
}
