import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/praises.dart';

String? encodeImage(Uint8List image) {
  return base64Encode(image);
}

Image decodeImage(String? image) {
  return Image.memory(base64Decode(image!));
}

Future<List<Praises>> loadPraises(String url) async {
  final String response = await rootBundle.loadString(url);
  GetPraises model = GetPraises.fromJson(json.decode(response));
  //ListClass.praiseList = model.response!;
  List<Praises> praiseList = [];
  praiseList = model.response!;
  return praiseList;
}
