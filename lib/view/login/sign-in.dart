import 'package:final_exam/controller/task_controller.dart';
import 'package:final_exam/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Sign-In',style: TextStyle(color: Colors.white),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              AuthService.authService.signInWithUserEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);
              Get.toNamed('/home');
            }, child: const Text('Sign-In',style: TextStyle(color: Colors.red),)),
            TextButton(onPressed: (){
              Get.toNamed('/signUp');
            }, child:const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Dont  have a account ?',style: TextStyle(color: Colors.black),),
                Text('Sign-Up',style: TextStyle(color: Colors.red),),
              ],
            ))
          ],
        ),
      ),
    );

  }
}
