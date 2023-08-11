import 'package:flutter/material.dart';
import 'package:uber_web_admin_panel/views/widgets/product_list_screen.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '\ProductScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Widget _rowHeader(int flex, String text) {
    return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.yellow.shade900,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Manage Products',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  _rowHeader(1, 'Image'),
                  _rowHeader(3, 'Name '),
                  _rowHeader(2, 'Price'),
                  _rowHeader(2, 'Quantity'),
                  _rowHeader(1, 'ACTION'),
                  _rowHeader(1, 'VIEW MORE'),
                ],
              ),
              ProductListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
