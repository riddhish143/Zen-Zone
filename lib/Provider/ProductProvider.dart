import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
  String name;
  List Image;
  String documentId;
  String suppId;
  bool isFavourite;
  Product({required this.name, required this.Image, required this.documentId, required this.suppId , this.isFavourite = false});
}


class Favourite extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems{
    return _list;
  }

  int? get count {
    _list.length;
  }


  void addItem(
    String name,
    List Image,
    String documentId,
    String suppId,
  ) {
    final product = Product(name:name , Image: Image , documentId: documentId , suppId: suppId);
    _list.add(product);
    notifyListeners();
  }
}
