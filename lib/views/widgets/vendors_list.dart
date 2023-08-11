import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_web_admin_panel/views/models/vendor_user_models.dart';

class VendorsList extends StatefulWidget {
  @override
  _VendorsListState createState() => _VendorsListState();
}

class _VendorsListState extends State<VendorsList> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vendors').snapshots();

  Widget vendorData(Widget widget, int? flex) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) {
            VendorUserModel vendor = VendorUserModel.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vendorData(
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                        vendor.storeImage.toString(),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    1),
                vendorData(
                    Text(
                      vendor.bussinessName.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    3),
                vendorData(
                    Text(
                      vendor.cityValue.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                vendorData(
                    Text(
                      vendor.stateValue.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                vendorData(
                    vendor.approved == true
                        ? ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(vendor.vendorId)
                                  .update({
                                'approved': false,
                              });
                            },
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ))
                        : ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(vendor.vendorId)
                                  .update({
                                'approved': true,
                              });
                            },
                            child: Text(
                              'Approved',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow),
                            ),
                          ),
                    1),
                vendorData(
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    1),
              ],
            );
          }),
        );
      },
    );
  }
}
