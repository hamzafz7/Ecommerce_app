class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> Banners = [];
  List<ProductsModel> Products = [];
  HomeDataModel.fromJson(Map mp) {
    mp['banners'].forEach((element) {
      Banners.add(BannersModel.fromJson(element));
    });
    mp['products'].forEach((element) {
      Products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson(Map mp) {
    id = mp['id'];
    image = mp['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? name;
  String? image;
  bool? infavourites;
  bool? incart;

  ProductsModel.fromJson(Map mp) {
    id = mp['id'];
    price = mp['price'];
    oldprice = mp['old_price'];
    discount = mp['discount'];
    name = mp['name'];
    image = mp['image'];
    infavourites = mp["in_favorites"];
    incart = mp['in_cart'];
  }
}
