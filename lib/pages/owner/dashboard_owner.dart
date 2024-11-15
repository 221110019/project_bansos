import 'package:flutter/material.dart';
import 'package:project_bansos/services/auth_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Owner',
      home: DashboardOwner(),
    );
  }
}

class DashboardOwner extends StatefulWidget {
  const DashboardOwner({super.key});

  @override
  State<DashboardOwner> createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  AuthServices authServices = AuthServices();

  final List<Map<String, dynamic>> products = [
    {'name': 'Produk A', 'stock': 10},
    {'name': 'Produk B', 'stock': 5},
    {'name': 'Produk C', 'stock': 8},
    {'name': 'Produk D', 'stock': 2},
    {'name': 'Produk E', 'stock': 7},
    {'name': 'Produk F', 'stock': 3},
    {'name': 'Produk G', 'stock': 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 230, 117, 25),
              child: Row(
                children: [
                  Icon(Icons.warning,
                      color: const Color.fromARGB(255, 195, 4, 4)),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peringatan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text("Stok sudah mau habis!"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 140, 131, 131),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text("Sisa Stok: ${product['stock']}"),
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  authServices.logoutUser();
                },
                child: Text(
                  'logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
