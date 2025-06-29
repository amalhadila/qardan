import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/home/presentation/manager/cubit/task_cubit.dart';
import 'package:qardan/features/home/presentation/views/widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
create: (context) => PreventiveTasksCubit()..fetchPreventiveTasks(),    
  child: const TasksViewBody(),
    );
  }
}
