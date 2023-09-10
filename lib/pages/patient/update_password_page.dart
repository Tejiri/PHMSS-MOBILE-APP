import 'package:flutter/material.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/custom_widgets/alert.dart';
import 'package:phmss_patient_app/pages/LoginPage.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              // color: Colors.amber,
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(hintText: "Enter password"),
                  ),
                  TextField(
                    obscureText: true,
                    controller: confirmPassword,
                    decoration: InputDecoration(hintText: "Confirm password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (password.text.isEmpty ||
                              confirmPassword.text.isEmpty) {
                            setState(() {
                              isLoading = false;
                            });
                            bottomAlert(
                                context: context,
                                isError: true,
                                title: "Error",
                                message:
                                    "Password or confirm password cannot be empty");
                          } else if (password.text != confirmPassword.text) {
                            setState(() {
                              isLoading = false;
                            });
                            bottomAlert(
                                context: context,
                                isError: true,
                                title: "Error",
                                message:
                                    "Ensure password and confirm password are the same");
                          } else {
                            await Api()
                                .updatePassword(
                                    context: context, password: password.text)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }
                        },
                        child: Text("Update Password")),
                  )
                ],
              ),
            ),
          ),
          isLoading == true
              ? Container(
                  decoration:
                      BoxDecoration(color: Colors.grey[400]?.withOpacity(0.6)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Loading",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
