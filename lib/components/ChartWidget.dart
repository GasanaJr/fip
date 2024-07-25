class ChartWidget extends StatelessWidget {
  final List<ChartData> data;
  
  ChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: charts.LineChart(
        [
          charts.Series<ChartData, String>(
            id: 'Data',
            domainFn: (data, _) => data.label,
            measureFn: (data, _) => data.value,
            data: data,
          ),
        ],
      ),
    );
  }
}
