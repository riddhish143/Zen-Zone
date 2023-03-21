import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScree extends StatefulWidget {
  const SearchScree({Key? key}) : super(key: key);

  @override
  State<SearchScree> createState() => _SearchScreeState();
}

class _SearchScreeState extends State<SearchScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CupertinoSearchTextField(),
      ),
    );
  }
}
