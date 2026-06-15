import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreConverter<T> {
  T fromFirestore(DocumentSnapshot doc, SnapshotOptions? options);

  Map<String, dynamic> toFirestore(T value, SetOptions? options);
}