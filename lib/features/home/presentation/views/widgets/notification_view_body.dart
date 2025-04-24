import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/data/model/notification_model.dart';
import 'package:qardan/features/home/presentation/manager/cubit/notification_cubit.dart';
import 'package:qardan/features/home/presentation/manager/cubit/notification_state.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlertsCubit()..getAlerts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('الإشعارات'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20).r,
          child: BlocBuilder<AlertsCubit, AlertsState>(
            builder: (context, state) {
              if (state is AlertsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AlertsError) {
                return Center(child: Text("خطأ: ${state.message}"));
              } else if (state is AlertsSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.alerts.length,
                        itemBuilder: (context, index) {
                          final alert = state.alerts[index];
                          return NotificationItem(alert: alert);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
  

}
class NotificationItem extends StatelessWidget {
  final AlertModel alert;

  const NotificationItem({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffDCEEDD),
        border: Border.symmetric(horizontal: BorderSide(color: Color(0xffC8CFC8), width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'تذكير',
                        style: Styles.textStyle16.copyWith(color: ColorApp.black),
                      ),
                      const Spacer(),
                      Text(
                        timeAgo(alert.alertTime),
                        style: Styles.textStyle12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    alert.message,
                    style: Styles.textStyle14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String timeAgo(String timeString) {
    try {
      final dateTime = DateTime.parse(timeString);
      final diff = DateTime.now().difference(dateTime);
      if (diff.inMinutes < 60) return '${diff.inMinutes} دقيقة';
      if (diff.inHours < 24) return '${diff.inHours} ساعة';
      return '${diff.inDays} يوم';
    } catch (e) {
      return '';
    }
  }
}