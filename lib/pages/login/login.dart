import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_bloc_api/bloc/login/login_bloc.dart';
import 'package:simple_bloc_api/pages/screen.dart';
import 'package:simple_bloc_api/utils/utils.dart';

import '../../bloc/home/home_bloc.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final idCntr = TextEditingController();
  final pswCntr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: width * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idCntr,
                decoration: InputDecoration(
                    hintText: 'emp code',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: pswCntr,
                decoration: InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    navigatorKey.currentState!
                        .pushReplacement(MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (context) => HomeBloc(),
                                  child: HomeScreen(),
                                )));
                  }
                  if (state is Error) {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(msg: state.error);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: state is Loading
                          ? () {}
                          : () {
                              String id = idCntr.text.trim();
                              String password = pswCntr.text.trim();
                              context.read<LoginBloc>().add(
                                  LoginButtonClick(id: id, password: password));
                            },
                      child: state is Loading
                          ? CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Text('Login'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
