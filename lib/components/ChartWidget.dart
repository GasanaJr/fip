class ChartWidget extends StatelessWidget {
  final List<ChartData> data;
  
  //Constructor for chartwidget, requiring a list of chartdata
  ChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      //set the height of container to 300 pixels
      height: 300,
      //create a linechart using the chart_flutter package
      child: charts.LineChart(
        [
          //define a series of data for the chart
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
