import 'package:cloud_firestore/cloud_firestore.dart';
import 'collections.dart';

class FirestoreClient {
  final FirebaseFirestore _db;

  FirestoreClient(this._db);

  // 🔥 USERS
  CollectionReference<Map<String, dynamic>> users() {
    return _db.collection(FirestoreCollections.users);
  }

  // 🔥 TASKS
  CollectionReference<Map<String, dynamic>> tasks() {
    return _db.collection(FirestoreCollections.tasks);
  }

  // 🔥 FOCUS SESSIONS
  CollectionReference<Map<String, dynamic>> focusSessions() {
    return _db.collection(FirestoreCollections.focusSessions);
  }

  // 🔥 ROUTINES
  CollectionReference<Map<String, dynamic>> routines() {
    return _db.collection(FirestoreCollections.routines);
  }

  // 🔥 AI REQUESTS
  CollectionReference<Map<String, dynamic>> aiRequests() {
    return _db.collection(FirestoreCollections.aiRequests);
  }

  // 🔥 SUBSCRIPTIONS
  CollectionReference<Map<String, dynamic>> subscriptions() {
    return _db.collection(FirestoreCollections.subscriptions);
  }
}