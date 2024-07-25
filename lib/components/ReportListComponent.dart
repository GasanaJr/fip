class ReportListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(reports[index].title),
          subtitle: Text(reports[index].summary),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailComponent(report: reports[index]))),
        );
      },
    );
  }
}
