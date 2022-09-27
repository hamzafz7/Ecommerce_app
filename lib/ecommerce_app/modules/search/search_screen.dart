import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/ecommerce_app/components/components.dart';
import 'package:ecommerce_app/ecommerce_app/modules/search/cubit/search_cubit.dart';
import 'package:ecommerce_app/ecommerce_app/modules/search/cubit/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shopcubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: ((context, state) {}),
          builder: (context, state) {
            return Form(
              key: formkey,
              child: Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                          controller: searchcontroller,
                          type: TextInputType.text,
                          onChange: (val) {
                            BlocProvider.of<SearchCubit>(context).Search(val);
                          },
                          validate: (val) {
                            if (val!.isEmpty)
                              return "Search field must not be empty";
                          },
                          label: "Search",
                          prefix: Icons.search),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => SearchItem(
                              BlocProvider.of<SearchCubit>(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: BlocProvider.of<SearchCubit>(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

Widget SearchItem(model, context) {
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
                imageUrl: "${model.image}",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              if (model.discount != 0)
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
                "${model.name}",
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
                    "${model.price}",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: BlocProvider.of<ShopCubit>(context)
                              .favourites[model.id]!
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
                          .changeFavorites(model.id!);
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
