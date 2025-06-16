import 'package:billing_app/view/CustomerPage/Customerpage.dart';
import 'package:billing_app/view/CustomerPage/customerlist.dart';
import 'package:billing_app/view/LoginPage/LoginPage.dart';
import 'package:billing_app/view/invoicePage/Invoivcepage.dart';
import 'package:billing_app/view/mainscreen/mainscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/dashboard': (context) =>  DashboardPage(),
        '/new-invoice': (context) =>  InvoiceCreationPage(),
        '/add-customer': (context) => AddCustomerPage(),
        '/customers': (context) =>  CustomerListPage(),

      },
    );
  }
}
