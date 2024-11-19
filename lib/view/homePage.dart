import 'package:final_exam/controller/task_controller.dart';
import 'package:final_exam/service/auth_service.dart';
import 'package:final_exam/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                for (int i = 0; i < controller.dataList.length; i++) {
                  CloudFireService.cloudFireService.addDataInFireStore(
                      controller.dataList[i]['title'],
                      controller.dataList[i]['des'],
                      controller.dataList[i]['due'],
                      controller.dataList[i]['category']);
                }
              },
              icon: Icon(Icons.sync)),
          IconButton(
            onPressed: () {
              for(int i=0;i<controller.dataList.length;i++)
              {
                int id=controller.dataList[i]['id'];
                controller.removeData(id);
              }
              CloudFireService.cloudFireService.getDataFromFireStore();
            },
            icon: Icon(Icons.backup),
          ),
          IconButton(
            onPressed: () {
              AuthService.authService.logout();
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (value) {
                  controller.searchCategory(value);
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.teal,
                        )),
                    child: const Center(
                        child: Text(
                      'work',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.teal,
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'home',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.teal,
                        )),
                    child: const Center(
                        child: Text(
                      'All Task',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, index) {
                    if (controller.dataList.isEmpty) {
                      return const Text('No data');
                    }
                    return Card(
                      child: ListTile(
                        title: Text(controller.dataList[index]['title']),
                        subtitle: Text(controller.dataList[index]['category']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {

                                  controller.removeData(
                                      controller.dataList[index]['id']);
                                },
                                icon: const Icon(
                                  Icons.delete,

                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Update Task'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: controller.txtTitle,
                                              decoration: const InputDecoration(
                                                  labelText: 'Title',
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextField(
                                              controller: controller.txtDue,
                                              decoration: const InputDecoration(
                                                  labelText: 'Due Date',
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextField(
                                              controller: controller.txtDes,
                                              decoration: const InputDecoration(
                                                  labelText: 'Description',
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextField(
                                              controller: controller.txtCate,
                                              decoration: const InputDecoration(
                                                  labelText: 'Category',
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder()),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            String title =
                                                controller.txtTitle.text;
                                            String des = controller.txtDes.text;
                                            String due = controller.txtDue.text;
                                            String category =
                                                controller.txtCate.text;
                                            controller.updateTask(
                                                title,
                                                des,
                                                due,
                                                category,
                                                controller.dataList[index]
                                                    ['id']);
                                            Get.back();
                                          },
                                          child: Text('save'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('cancel'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Task'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller.txtTitle,
                      decoration: const InputDecoration(
                          labelText: 'Title',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.txtDue,
                      decoration: const InputDecoration(
                          labelText: 'Due Date',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.txtDes,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.txtCate,
                      decoration: const InputDecoration(
                          labelText: 'Category',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    String title = controller.txtTitle.text;
                    String des = controller.txtDes.text;
                    String due = controller.txtDue.text;
                    String category = controller.txtCate.text;
                    controller.insertData(title, des, due, category);
                    Get.back();
                    controller.txtDes.clear();
                    controller.txtCate.clear();
                    controller.txtDue.clear();
                    controller.txtTitle.clear();
                  },
                  child: const Text('save'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
