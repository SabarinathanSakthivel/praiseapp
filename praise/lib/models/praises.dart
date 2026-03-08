import 'dart:convert';

GetPraises getPraisesFromJson(String str) =>
    GetPraises.fromJson(json.decode(str));

String getPraisesToJson(GetPraises data) => json.encode(data.toJson());

class GetPraises {
  GetPraises({
    this.response,
  });

  List<Praises>? response;

  factory GetPraises.fromJson(Map<String, dynamic> json) => GetPraises(
        response: json["response"] == null
            ? null
            : List<Praises>.from(
                json["response"].map((x) => Praises.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? null
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

List<Praises> praisesFromJson(String str) =>
    List<Praises>.from(json.decode(str).map((x) => Praises.fromJson(x)));

String praisesToJson(List<Praises> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Praises {
  Praises({
    this.id,
    this.praise,
  });

  int? id;
  String? praise;

  factory Praises.fromJson(Map<String, dynamic> json) => Praises(
        id: json["id"],
        praise: json["praise"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "praise": praise,
      };
}
