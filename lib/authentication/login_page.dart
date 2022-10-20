import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/commons/main_page.dart';

import 'bloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(
                    defaultIndex: 0,
                  ),
                ),
              );
            } else {
              if (state is AuthenticationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(translate("username or password is invalid")),
                  ),
                );
              }
            }
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 100, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo-reewayy.png",
                        height: 100,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SizedBox(
                          height: 350,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller: userNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("email");
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    hintText: translate("email"),
                                    label: Text(translate("Email")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  obscureText: true,
                                  controller: userPasswordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("Password");
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    hintText: translate("password"),
                                    label: Text(translate("password")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, bottom: 8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(Authenticate(
                                                userName:
                                                    userNameController.text,
                                                userPassword:
                                                    userPasswordController
                                                        .text));
                                      }
                                    },
                                    child: Text(translate("Login")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
