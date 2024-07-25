class ReportDetailComponent extends StatelessWidget {
  final Report report;
  
  ReportDetailComponent({required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),
      body: Column(
        children: [
          ChartWidget(data: report.data),
          TaFilterComponentbleWidget(data: report.data),
        ],
      ),
    );
  }
}
