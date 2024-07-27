import 'package:flutter/material.dart';

//a stateless widget that represents the dashboard of the app
class DashboardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //AppBar provides the header fr the dashboard screen
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Here are some stats for you:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.timeline),
                title: Text('Total Sales'),
                subtitle: Text('\$ 25,000'),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Total Customers'),
                subtitle: Text('150'),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Total Orders'),
                subtitle: Text('75'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recent Orders:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text('Order #${index + 1}'),
                    subtitle: Text('Customer: Customer ${index + 1}\nAmount: \$${(index + 1) * 50}'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to order details
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //floating action button to add a new order
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new order
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
