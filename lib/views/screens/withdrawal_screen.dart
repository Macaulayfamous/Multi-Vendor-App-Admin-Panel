import 'package:flutter/material.dart';
import 'package:uber_web_admin_panel/views/widgets/withdrawal_list.dart';

class WithrawalScreen extends StatefulWidget {
  static const String id = '\withdrawalScreen';

  @override
  State<WithrawalScreen> createState() => _WithrawalScreenState();
}

class _WithrawalScreenState extends State<WithrawalScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'withdrawal',
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
                _rowHeader(1, 'NAME'),
                _rowHeader(3, 'AMOUNT'),
                _rowHeader(2, 'Bank NAME'),
                _rowHeader(2, 'BANK ACCOUNT'),
                _rowHeader(1, 'EMAIL'),
                _rowHeader(1, 'PHONE'),
              ],
            ),
            WithdrawalList(),
          ],
        ),
      ),
    );
  }
}
