import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/data/model/task_model.dart';
import 'package:qardan/features/home/presentation/manager/cubit/task_cubit.dart';
import 'package:qardan/features/home/presentation/manager/cubit/task_state.dart';
import 'package:qardan/features/home/presentation/views/land_map_view.dart';
import 'package:qardan/features/home/presentation/views/report_view.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جدول المهام'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ الأزرار العلوية
            Padding(
              padding: EdgeInsets.only(right: 8.w, bottom: 16.h, left: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportView()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff1C631E),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('التقارير', style: Styles.textStyle15_inter),
                            const Icon(Icons.align_vertical_bottom_sharp, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LandMapView()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff1C631E),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('الخريطة', style: Styles.textStyle15_inter),
                            const Icon(Icons.map, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ قائمة المهام باستخدام BlocBuilder
            Expanded(
              child: BlocBuilder<PreventiveTasksCubit, PreventiveTasksState>(
                builder: (context, state) {
                  if (state is PreventiveTasksLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PreventiveTasksLoaded) {
                    final tasks = state.tasks;
                    if (tasks.isEmpty) {
                      return const Center(child: Text('لا توجد مهام متاحة حالياً'));
                    }
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => const CaptureView()));
                          },
                          child: TaskItem(task: tasks[index]),
                        );
                      },
                    );
                  } else if (state is PreventiveTasksError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final PreventiveTask task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15).r,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffDCEEDD),
          border: const Border.symmetric(horizontal: BorderSide(color: Color(0xffC8CFC8), width: 0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8).r,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          task.isCurrent ? Icons.check_circle : Icons.check_circle_outline,
                          size: 20,
                          color: task.isCurrent ? Colors.green : ColorApp.secondaryColor2,
                        ),
                        const Spacer(),
                        Text(' ${task.day} يوم', style: Styles.textStyle12),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      task.message,
                      style: Styles.textStyle14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.stage,
                          style: Styles.textStyle12.copyWith(color: Colors.black87),
                        ),
                        Text(
                          task.repetition,
                          style: Styles.textStyle12.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
