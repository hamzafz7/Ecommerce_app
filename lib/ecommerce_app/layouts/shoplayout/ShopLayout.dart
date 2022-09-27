import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopstates.dart';
import 'package:ecommerce_app/ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/ecommerce_app/modules/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Salla"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SearchScreen())));
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
            body: BlocProvider.of<ShopCubit>(context)
                .screens[BlocProvider.of<ShopCubit>(context).currentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: BlocProvider.of<ShopCubit>(context).currentindex,
              items: BlocProvider.of<ShopCubit>(context).icons,
              onTap: (index) {
                BlocProvider.of<ShopCubit>(context).changebottom(index);
              },
            ),
          );
        });
  }
}
