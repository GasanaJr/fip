class ExportComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => exportToPDF(),
          child: Text('Export to PDF'),
        ),
        ElevatedButton(
          onPressed: () => exportToCSV(),
          child: Text('Export to CSV'),
        ),
      ],
    );
  }
}
