import 'dart:math';

class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromjson(Map mp) {
    status = mp['status'];
    data = CategoriesDataModel.fromjson(mp['data']);
  }
}

class CategoriesDataModel {
  int? currentpage;
  int? total;
  List<DataItemModel> data = [];
  CategoriesDataModel.fromjson(Map json) {
    currentpage = json['current_page'];
    total = json['total'];
    for (int i = 0; i < total!; i++) {
      data.add(DataItemModel.fromjson(json['data'][i]));
    }
  }
}

class DataItemModel {
  int? id;
  String? name;
  String? image;
  DataItemModel.fromjson(Map<String, dynamic> mp) {
    id = mp['id'];
    name = mp['name'];
    image = mp['image'];
  }
}
