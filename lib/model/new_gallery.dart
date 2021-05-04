class Gallery {
  String image;
  String name;
  String address1;
  String address2;
  String phone;
  String location;
  String galleryNo;
  Gallery(
      {this.image,
      this.name,
      this.address1,
      this.address2,
      this.phone,
      this.location,
      this.galleryNo});
  factory Gallery.fromMap(Map<String, dynamic> map) {
    return Gallery(
      image: map["image"],
      name: map["name"],
      address1: map["address1"],
      address2: map["address2"],
      phone: map["phone"],
      location: map["location"],
      galleryNo: map["galleryNo"],
    );
  }
}
