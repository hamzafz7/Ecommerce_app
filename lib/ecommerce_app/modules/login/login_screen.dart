import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/ecommerce_app/components/components.dart';
import 'package:ecommerce_app/ecommerce_app/layouts/shoplayout/ShopLayout.dart';
import 'package:ecommerce_app/ecommerce_app/modules/Register/Registerscreen.dart';
import 'package:ecommerce_app/ecommerce_app/modules/login/logincubit/shoplogincubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network/local/CasheHelper.dart';
import 'logincubit/shoploginstates.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var pascontroller = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);
  void loginsuccessed(context) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setBool('islogin', true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShopLayout()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, ShopLoginStates>(
            listener: (context, state) async {
          if (state is ShopLoginSuccessState) {
            if (state.loginmodel!.status!) {
              print(state.loginmodel!.data!.token!);
              SharedPreferences sh = await SharedPreferences.getInstance();
              await sh
                  .setString('token', state.loginmodel!.data!.token!)
                  .then((value) {
                loginsuccessed(context);
              });
            } else {
              Fluttertoast.showToast(
                  msg: "${state.loginmodel!.message!}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //   SizedBox(
                        //    height: 140,
                        // ),
                        Text(
                          "LOGIN !",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login to get our last news !",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (val) {
                              if (val!.isEmpty)
                                return "email should not be empty";
                              else {
                                return null;
                              }
                            },
                            label: "Enter your email",
                            prefix: Icons.email),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          isPassword:
                              BlocProvider.of<LoginCubit>(context).ispassowrd,
                          controller: pascontroller,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty)
                              return "password should not be empty";
                            else
                              return null;
                          },
                          label: "Enter your Passowrd",
                          prefix: Icons.lock,
                          suffix: Icons.remove_red_eye_outlined,
                          suffixPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .Changepasswordmode();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: (state is! ShopLoginLoadingState),
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .Userlogin(emailcontroller.text,
                                          pascontroller.text);
                                }
                              },
                              text: 'LOGIN'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Don\'t have an account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              RegisterScreen())));
                                },
                                child: Text("Register"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
