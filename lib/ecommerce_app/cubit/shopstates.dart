import 'package:ecommerce_app/ecommerce_app/models/changefavmodel/changefavmodel.dart';
import 'package:ecommerce_app/ecommerce_app/models/shopmodels/loginModel/LoginModel.dart';

abstract class ShopStates {}

class ShopInititalState extends ShopStates {}

class ShopChangeNavbottomState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel? model;
  ShopSuccessChangeFavoritesState({this.model});
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetUserState extends ShopStates {}

class ShopSuccessGetUserState extends ShopStates {
  final LoginModel userModel;

  ShopSuccessGetUserState(this.userModel);
}

class ShopErrorGetUserState extends ShopStates {}
