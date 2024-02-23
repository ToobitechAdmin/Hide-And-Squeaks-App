




class TreatModel {
  int? treats;
  int? price;
  int? id;





  // Constructor
  TreatModel({
    this.treats,
    this.price,
    this.id




  });

  factory TreatModel.fromJson(Map<String, dynamic> json) {
    return TreatModel(
        treats: json['treats'],
        price: json['price'],
        id:json["id"],





    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treats': treats,
      'price': price,
      "id":id



    };
  }



}