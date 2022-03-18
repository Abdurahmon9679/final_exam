import 'dart:convert';
import 'package:benaficary/models/recopients_class.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBService{
  static const String dbName="db_relationship";
  static Box box = Hive.box(dbName);



  static Future<void>store(List<Recipients>cards)async{
    ///object=>map=>Stirng
    List<String>stringList = cards.map((card) => jsonEncode(card.toJson())).toList();
    await box.put("relationship", stringList);
  }

  static List<Recipients>load(){
    ///String =>Map=>objcet
    List<String>stringList=box.get("relationship")??<String>[];
    List<Recipients>cards = stringList.map((string) => Recipients.fromJson(jsonDecode(string))).toList();
    return cards;
  }

  static Future<void>remove()async{
    await box.delete("relationship");
  }

}