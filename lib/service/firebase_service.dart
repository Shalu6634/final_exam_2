import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/controller/task_controller.dart';
import 'package:get/get.dart';

class CloudFireService {
  CloudFireService._();


  static CloudFireService cloudFireService = CloudFireService._();
  List docIdList = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var dataController = Get.put(TaskController());

  Future<void> addDataInFireStore(
    String title,
    String des,
    String due,
    String category,
  ) async {
    final id = await firestore
        .collection('users')
        .add({'title': title, 'des': des, 'due': due, 'category': category});
    docIdList.add(id.id);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromFireStore() {
    final stream = firestore.collection('users').snapshots();
    return stream;
  }

  Future<void> getDataFromFireStore() async {
    final querySnapshot = await firestore.collection('users').get();
    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      // final data = doc.data() as Map<String, dynamic>;
      dataController.insertData(
          data['title'], data['des'], data['due'], data['category']);
    }
  }
}
