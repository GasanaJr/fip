class DashboardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          ChartWidget(),
          SummaryCard(),
          ReportListComponent(),
        ],
      ),
    );
  }
}
