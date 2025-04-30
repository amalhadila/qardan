import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qardan/features/home/presentation/manager/cubit/nutrients_report_cubit.dart';
import 'package:qardan/features/home/presentation/views/widgets/report_section_view_body.dart';

class ReportSectionView extends StatelessWidget {
  const ReportSectionView(
      {super.key, required this.selectedReport, required this.sectorId});
  final String selectedReport;
  final int sectorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => NutrientReportCubit()..fetchNutrientReport(sectorId.toString()),
      child: ReportSectionViewBody(
        selectedReport: selectedReport,
        sectorId: sectorId,
      ),
    );
  }
}
