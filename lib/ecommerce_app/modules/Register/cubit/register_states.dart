import 'package:ecommerce_app/ecommerce_app/models/shopmodels/loginModel/LoginModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final LoginModel? loginmodel;
  ShopRegisterSuccessState(this.loginmodel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterpasswordState extends ShopRegisterStates {}
