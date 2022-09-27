import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopstates.dart';
import 'package:ecommerce_app/ecommerce_app/models/CategoriesModel/CategoriesModel,.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) => Scaffold(
          body: ListView.separated(
        itemBuilder: (context, index) => Buildcategrory(
            BlocProvider.of<ShopCubit>(context)
                .categorymodel!
                .data!
                .data[index]),
        separatorBuilder: (context, index) => Divider(),
        itemCount: BlocProvider.of<ShopCubit>(context)
            .categorymodel!
            .data!
            .data
            .length,
      )),
      listener: ((context, state) {}),
    );
  }
}

Widget Buildcategrory(DataItemModel model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: "${model.image}",
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "${model.name}",
          style: TextStyle(fontSize: 18),
        ),
        Spacer(),
        Icon(Icons.arrow_forward)
      ],
    ),
  );
}
