import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopstates.dart';
import 'package:ecommerce_app/ecommerce_app/models/favourites_model/favouritemodel.dart';
import 'package:ecommerce_app/ecommerce_app/models/homemodel/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: ((context, state) {
          return ListView.separated(
            itemBuilder: ((context, index) => FAVItem(
                BlocProvider.of<ShopCubit>(context)
                    .favoritesModel!
                    .data!
                    .data[index],
                context)),
            separatorBuilder: ((context, index) => Divider()),
            itemCount: BlocProvider.of<ShopCubit>(context)
                .favoritesModel!
                .data!
                .data
                .length,
          );
        }),
        listener: ((context, state) {}));
  }
}

Widget FAVItem(model, context) {
  return Container(
    height: 150,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 150,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CachedNetworkImage(
                imageUrl: "${model.product!.image}",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "${model.product!.name}",
                style: TextStyle(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Text(
                    "${model.product!.price}",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.product!.price != model.product!.oldPrice)
                    Text(
                      "${model.product!.oldPrice}",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: BlocProvider.of<ShopCubit>(context)
                              .favourites[model.product!.id]!
                          ? Colors.deepOrange
                          : Colors.grey[300],
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<ShopCubit>(context)
                          .changeFavorites(model.product!.id!);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
