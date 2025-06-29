
import 'package:qardan/features/home/data/model/task_model.dart';

abstract class PreventiveTasksState {}

class PreventiveTasksInitial extends PreventiveTasksState {}

class PreventiveTasksLoading extends PreventiveTasksState {}

class PreventiveTasksLoaded extends PreventiveTasksState {
  final List<PreventiveTask> tasks;
  PreventiveTasksLoaded({required this.tasks});
}

class PreventiveTasksError extends PreventiveTasksState {
  final String message;
  PreventiveTasksError({required this.message});
}
