class LoginModel {
  bool? status;
  String? message;
  UserDataModel? data;
  LoginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
  }
}

class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;
  UserDataModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.point,
      this.credit,
      this.token});
  UserDataModel.fromJson(Map<String, dynamic> mp) {
    id = mp['id'];
    name = mp['name'];
    email = mp['email'];
    phone = mp['phone'];
    image = mp['image'];
    point = mp['points'];
    credit = mp['credit'];
    token = mp['token'];
  }
}
