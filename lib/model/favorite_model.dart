class FavoriteModel {
  String postLiked;
  String video;
  String image;
  String brand;
  String model;
  String city;
  String gear;
  String color;
  String gaz;
  String km;
  String price;
  String phone;
  String not;
  String installment;
  String statusCar;
  String likes;
  FavoriteModel(
      {
        this.postLiked,
        this.brand,
        this.city,
        this.color,
        this.gaz,
        this.gear,
        this.image,
        this.installment,
        this.km,
        this.model,
        this.statusCar,
        this.not,
        this.phone,
        this.price,
        this.video,
        this.likes,
      });
  FavoriteModel.fromMap(Map<String, dynamic> mapData) {
    postLiked=mapData["postLiked"];
    video = mapData['video'];
    image = mapData['image'];
    brand = mapData['brand'];
    model = mapData['model'];
    city = mapData['city'];
    gear = mapData['gear'];
    gaz = mapData['gaz'];
    km = mapData['km'];
    phone = mapData['phone'];
    not = mapData['not'];
    installment = mapData['installment'];
    statusCar = mapData['statusCar'];
    color = mapData['color'];
    price = mapData['price'];
    likes = mapData['likes'];
  }
}
