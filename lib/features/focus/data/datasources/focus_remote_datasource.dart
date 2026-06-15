import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/focus_session_model.dart';

abstract class FocusRemoteDataSource {
  Future<void> saveSession(FocusSessionModel session);
}

class FocusRemoteDataSourceImpl implements FocusRemoteDataSource {
  final FirebaseFirestore firestore;
  final String collection = 'focus_session';

  FocusRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> saveSession(FocusSessionModel session) async {
    await firestore.collection(collection).add(session.toJson());
  }
}
