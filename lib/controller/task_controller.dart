import 'package:final_exam/helper/task_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController
{
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtTitle= TextEditingController();
  TextEditingController txtDes = TextEditingController();
  TextEditingController txtDue = TextEditingController();
  TextEditingController txtCate = TextEditingController();

 RxList dataList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    initDb();

  }

  Future<void> initDb() async {
    await DbHelper.dbHelper.database;
    await getData();
  }

  Future<RxList> insertData(String title,String des,String due,String category)
  async {
     dataList.value = await DbHelper.dbHelper.insertDatabase(title, des, due, category);
     getData();
     return dataList;
  }
  Future<void> getData()
  async {
    dataList.value = await DbHelper.dbHelper.readDataFromTable();
  }

  Future<void> removeData(int id)
  async {
    await DbHelper.dbHelper.deleteData(id);

    await getData();
  }

  Future<void> updateTask(String title,String des,String due,String category,int id)
  async {
    await DbHelper.dbHelper.updateData(title, des, due, category, id);
    getData();
  }

  Future<void> searchCategory(String title)
  async {
    await DbHelper.dbHelper.searchData(title);
  }
}