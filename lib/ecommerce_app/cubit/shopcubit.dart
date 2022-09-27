import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/ecommerce_app/components/constants.dart';
import 'package:ecommerce_app/ecommerce_app/cubit/shopstates.dart';
import 'package:ecommerce_app/ecommerce_app/models/CategoriesModel/CategoriesModel,.dart';
import 'package:ecommerce_app/ecommerce_app/models/homemodel/homemodel.dart';
import 'package:ecommerce_app/ecommerce_app/models/shopmodels/loginModel/LoginModel.dart';
import 'package:ecommerce_app/ecommerce_app/modules/categories/categories_screen.dart';
import 'package:ecommerce_app/ecommerce_app/modules/favourites/favourite_screen.dart';
import 'package:ecommerce_app/ecommerce_app/modules/products/products_screen.dart';
import 'package:ecommerce_app/ecommerce_app/modules/settings/settings_screen.dart';
import 'package:ecommerce_app/network/remote/DioHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../endpoint.dart';
import '../models/changefavmodel/changefavmodel.dart';
import '../models/favourites_model/favouritemodel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInititalState());
  int currentindex = 0;
  List<BottomNavigationBarItem> icons = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.category,
        ),
        label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favourites'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Settings'),
  ];
  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];
  void changebottom(index) {
    currentindex = index;
    emit(ShopChangeNavbottomState());
  }

  HomeModel? homemodel;
  Map<int?, bool?> favourites = {};

  void gethomedata() async {
    emit(ShopLoadingHomeDataState());
    SharedPreferences sh = await SharedPreferences.getInstance();
    token = sh.getString('token');
    print(token);
    await DioHelper.getdata(url: Home, query: null, token: token).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      //print(homemodel!.data!.Products[0].infavourites);
      homemodel!.data!.Products.forEach((e) {
        favourites.addAll({e.id: e.infavourites});
      });
      //  print(favourites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categorymodel;
  void getCategoriesData() async {
    emit(ShopLoadingCategoriesDataState());
    await DioHelper.getdata(url: Categories, query: null).then((value) {
      {
        categorymodel = CategoriesModel.fromjson(value.data);
        emit(ShopSuccessCategoriesDataState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() async {
    emit(ShopLoadingGetFavoritesState());
    SharedPreferences sh = await SharedPreferences.getInstance();

    DioHelper.getdata(url: favourite, token: sh.getString('token'))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //  print(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postdata(
      url: favourite,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);

      if (!changeFavoritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(model: changeFavoritesModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  LoginModel? userModel;

  void getuser() async {
    emit(ShopLoadingGetUserState());
    SharedPreferences sh = await SharedPreferences.getInstance();

    DioHelper.getdata(url: profile, token: sh.getString('token')).then((value) {
      userModel = LoginModel.fromjson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessGetUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserState());
    });
  }
}
