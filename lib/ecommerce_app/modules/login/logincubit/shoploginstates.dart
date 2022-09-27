import 'package:ecommerce_app/ecommerce_app/models/shopmodels/loginModel/LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final LoginModel? loginmodel;
  ShopLoginSuccessState(this.loginmodel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final error;
  ShopLoginErrorState(this.error);
}

class ShoploginpasswordState extends ShopLoginStates {}
