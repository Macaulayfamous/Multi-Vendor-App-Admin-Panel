import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
}
