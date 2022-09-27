import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/ecommerce_app/modules/login/logincubit/shoploginstates.dart';
import 'package:ecommerce_app/network/remote/DioHelper.dart';

import '../../../../endpoint.dart';
import '../../../models/shopmodels/loginModel/LoginModel.dart';

class LoginCubit extends Cubit<ShopLoginStates> {
  LoginCubit() : super(ShopLoginInitialState());
  LoginModel? loginmodel;
  Userlogin(String email, String Password) {
    emit(ShopLoginLoadingState());
    DioHelper.postdata(url: Login, data: {'email': email, 'password': Password})
        .then((value) {
      loginmodel = LoginModel.fromjson(value.data);
      print(loginmodel!.status);
      emit(ShopLoginSuccessState(loginmodel));
    }).onError((error, stackTrace) {
      emit(ShopLoginErrorState(error));
    });
  }

  bool ispassowrd = false;
  Changepasswordmode() {
    ispassowrd = !ispassowrd;
    emit(ShoploginpasswordState());
  }
}
