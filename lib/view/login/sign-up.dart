import 'package:final_exam/controller/task_controller.dart';
import 'package:final_exam/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Sign-Up',style: TextStyle(color: Colors.white),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller:controller.txtName,
              decoration: const InputDecoration(
                labelText: 'Name',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller:controller.txtEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller:controller.txtPassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AuthService.authService.createUserWithEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);
              Get.to('/signIn');
            }, child: const Text('Sign-Up',style: TextStyle(color: Colors.red),)),
            TextButton(onPressed: (){
              Get.toNamed('/signIn');
            }, child:const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Already have account',style: TextStyle(color: Colors.black),),
                Text('Sign-In',style: TextStyle(color: Colors.red),),
              ],
            ))
          ],
        ),
      ),
    );

  }
}
