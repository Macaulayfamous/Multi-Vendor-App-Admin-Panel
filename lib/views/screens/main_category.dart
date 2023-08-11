import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_web_admin_panel/views/widgets/main_category_widget.dart';

class MainCategoryScreen extends StatefulWidget {
  static const String id = 'MainCategoryScreen';
  const MainCategoryScreen({super.key});

  @override
  State<MainCategoryScreen> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late String _mainCategory;
  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  Object? _selectedValue;
  Widget _dropdownButton() {
    return StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: CircularProgressIndicator(color: Colors.yellow.shade900),
            );
          }

          return DropdownButton(
            value: _selectedValue,
            hint: Text('Selecte Category'),
            items: snapshot.data!.docs.map((e) {
              return DropdownMenuItem<String>(
                value: e['categoryName'],
                child: Text(
                  e['categoryName'],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          );
        });
  }

  uploadMainCategory() async {
    if (_formKey.currentState!.validate()) {
      await _firebaseFirestore
          .collection('mainCategory')
          .doc(_mainCategory)
          .set({
        'category': _selectedValue,
        'mainCategory': _mainCategory,
        'approved': true,
      });
    } else {
      print('Failds must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Main Category',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            _dropdownButton(),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              child: TextFormField(
                onChanged: (value) {
                  _mainCategory = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fields must not be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: Text(
                    'Enter Category Name',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.yellow.shade900))),
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                  ),
                  onPressed: () {
                    uploadMainCategory();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            MainCategoryWidget(),
          ],
        ),
      ),
    );
  }
}
