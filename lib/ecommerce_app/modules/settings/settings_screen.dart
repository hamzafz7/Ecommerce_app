import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/ecommerce_app/components/components.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessGetUserState) {
        namecontroller.text = state.userModel.data!.name!;
        emailcontroller.text = state.userModel.data!.email!;
        phonecontroller.text = state.userModel.data!.phone!;
      }
    }, builder: (context, state) {
      var model = BlocProvider.of<ShopCubit>(context).userModel;
      namecontroller.text = model!.data!.name!;
      emailcontroller.text = model.data!.email!;
      phonecontroller.text = model.data!.phone!;

      return ConditionalBuilder(
          condition: BlocProvider.of<ShopCubit>(context).userModel != null,
          fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
          builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: namecontroller,
                          type: TextInputType.name,
                          validate: (val) {
                            if (val!.isEmpty)
                              "name field must not be empty";
                            else
                              return null;
                          },
                          label: "Name",
                          prefix: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          validate: (val) {
                            if (val!.isEmpty)
                              "email field must not be empty";
                            else
                              return null;
                          },
                          label: "Email",
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          validate: (val) {
                            if (val!.isEmpty)
                              "phone field must not be empty";
                            else
                              return null;
                          },
                          label: "Phone",
                          prefix: Icons.phone),
                      SizedBox(
                        height: 40,
                      ),
                      defaultButton(
                          function: () async {
                            SharedPreferences sh =
                                await SharedPreferences.getInstance();
                            await sh.setBool('islogin', false);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginScreen())));
                          },
                          text: "Sign Out")
                    ],
                  ),
                ),
              ));
    });
  }
}
