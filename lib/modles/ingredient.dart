// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    Data data;
    String message;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.ing,
    });

    List<Ing> ing;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        ing: List<Ing>.from(json["Ing"].map((x) => Ing.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Ing": List<dynamic>.from(ing.map((x) => x.toJson())),
    };
}

class Ing {
    Ing({
        this.id,
        this.userId,
        this.note,
        this.expiryData,
        this.title,
        this.weight,
        this.price,
        this.category,
       
    });

    int id;
    String userId;
    String note;
    dynamic expiryData;
    String title;
    String weight;
    String price;
    String category;
   

    factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        id: json["id"],
        userId: json["user_id"],
        note: json["note"],
        expiryData: json["expiry_data"],
        title: json["title"],
        weight: json["weight"],
        price: json["price"],
        category: json["category"],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "note": note,
        "expiry_data": expiryData,
        "title": title,
        "weight": weight,
        "price": price,
        "category": category,
     
    };
}
