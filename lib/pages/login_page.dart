import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_firestore/blocs/blocs.dart';
import 'package:todo_firestore/components/input_component.dart';
import 'package:todo_firestore/components/button_component.dart';
import 'package:todo_firestore/pages/todos_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthBloc authBloc = AuthBloc();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
          create: (context) => authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              print(state.user.email);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> TodosPage(username: state.user.email,)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Login'),
                      InputComponent(
                        controller: email,
                        hint: 'Email',
                      ),
                      InputComponent(
                        controller: password,
                        hint: 'Password',
                        obscureText: true,
                      ),
                      ButtonComponent(
                        title: 'Login',
                        onTap: () {
                          print('Login');
                          authBloc.add(Login(
                              email: email.text,
                              password: password.text
                          ));
                        },
                      )
                    ],
                  ),
                );
              }
          ),
        ),
      )
    );
  }
}
