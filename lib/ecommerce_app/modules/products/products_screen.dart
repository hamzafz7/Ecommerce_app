import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopcubit.dart';
import 'package:ecommerce_app/ecommerce_app/models/CategoriesModel/CategoriesModel,.dart';
import 'package:ecommerce_app/ecommerce_app/models/homemodel/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/shopstates.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition:
                  BlocProvider.of<ShopCubit>(context).homemodel != null &&
                      BlocProvider.of<ShopCubit>(context).categorymodel != null,
              builder: (context) => HomeBuilder(
                  BlocProvider.of<ShopCubit>(context).homemodel,
                  BlocProvider.of<ShopCubit>(context).categorymodel,
                  context),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) {});
  }
}

Widget HomeBuilder(
    HomeModel? model, CategoriesModel? categoriesModel, context) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model!.data!.Banners.map((e) {
                return CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: "${e.image}",
                );
              }).toList(),
              options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true)),
          SizedBox(
            height: 15,
          ),
          Text(
            "New Products!",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            //width: 100,
            height: 100,
            //color: Colors.grey[300],
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) =>
                    BuildCategoryItem(categoriesModel!.data!.data[index])),
                separatorBuilder: ((context, index) => SizedBox(
                      width: 10,
                    )),
                itemCount: categoriesModel!.data!.data.length),
          ),
          Container(
              //  color: Colors.grey[300],
              child: GridView.count(
            childAspectRatio: 1 / 1.8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            crossAxisCount: 2,
            children: List.generate(
                model.data!.Products.length,
                (index) => Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CachedNetworkImage(
                                    height: 200,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    imageUrl:
                                        "${model.data!.Products[index].image}",
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                  ),
                                  if (model.data!.Products[index].discount != 0)
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
                                ]),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${model.data!.Products[index].name}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${model.data!.Products[index].price}",
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        if (model.data!.Products[index].price !=
                                            model
                                                .data!.Products[index].oldprice)
                                          Text(
                                            "${model.data!.Products[index].oldprice}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        Spacer(),
                                        IconButton(
                                          icon: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                BlocProvider.of<ShopCubit>(
                                                                context)
                                                            .favourites[
                                                        model
                                                            .data!
                                                            .Products[index]
                                                            .id]!
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
                                                .changeFavorites(model
                                                    .data!.Products[index].id!);
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ]),
                    )),
          ))
        ]),
      ),
    ),
  );
}

Widget BuildCategoryItem(DataItemModel? model) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CachedNetworkImage(
        imageUrl: "${model!.image}",
        width: 80,
        height: 100,
      ),
      Container(
        width: 80,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          "${model.name}",
          style: TextStyle(fontSize: 18),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
