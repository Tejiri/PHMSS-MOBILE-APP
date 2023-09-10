import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phmss_patient_app/Providers/user_provider.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/custom_widgets/form_widgets.dart';
import 'package:phmss_patient_app/pages/patient/patient_homepage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset("assets/lottie/health.json"),
                  customTextField(
                      controller: email,
                      hintText: "Enter email",
                      icon: Icon(Icons.email),
                      obscureText: false),
                  customTextField(
                      controller: password,
                      hintText: "Enter password",
                      icon: Icon(Icons.password),
                      obscureText: true),
                  customButton(
                      buttonText: "Login",
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await Api()
                            .login(
                                context: context,
                                email: email.text,
                                password: password.text)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });

                        // if (isLoading) {
                        //
                        // } else {
                        //   setState(() {
                        //     isLoading = true;
                        //   });
                        // }
                      })
                ],
              ),
            ),
            isLoading == true
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[400]?.withOpacity(0.6)),
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
      ),
    );
  }
}
