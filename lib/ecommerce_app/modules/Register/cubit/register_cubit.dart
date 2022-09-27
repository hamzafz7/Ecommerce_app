import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/ecommerce_app/modules/Register/cubit/register_states.dart';
import 'package:ecommerce_app/ecommerce_app/modules/login/logincubit/shoploginstates.dart';
import 'package:ecommerce_app/network/remote/DioHelper.dart';

import '../../../../endpoint.dart';
import '../../../models/shopmodels/loginModel/LoginModel.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialState());
  LoginModel? loginmodel;
  UserRegister(String email, String Password, String name, String phone) {
    emit(ShopRegisterLoadingState());
    DioHelper.postdata(url: register, data: {
      'name': name,
      'email': email,
      'password': Password,
      'phone': phone
    }).then((value) {
      loginmodel = LoginModel.fromjson(value.data);
      print(loginmodel!.status);
      emit(ShopRegisterSuccessState(loginmodel));
    }).onError((error, stackTrace) {
      emit(ShopRegisterErrorState(error));
    });
  }

  bool ispassowrd = false;
  Changepasswordmode() {
    ispassowrd = !ispassowrd;
    emit(ShopRegisterpasswordState());
  }
}
