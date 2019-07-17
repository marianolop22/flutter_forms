import 'dart:convert';

ProducModel producModelFromJson(String str) => ProducModel.fromJson(json.decode(str));

String producModelToJson(ProducModel data) => json.encode(data.toJson());

class ProducModel {
    String id;
    String title;
    double price;
    bool available;
    String urlPhoto;

    ProducModel({
        this.id,
        this.title = '',
        this.price = 0.0,
        this.available = true,
        this.urlPhoto,
    });

    factory ProducModel.fromJson(Map<String, dynamic> json) => new ProducModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        available: json["available"],
        urlPhoto: json["urlPhoto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "available": available,
        "urlPhoto": urlPhoto,
    };
}
