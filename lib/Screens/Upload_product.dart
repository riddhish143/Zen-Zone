import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:final2/Utilities/Category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

List<String> category = [
  'Focus',
  'Podcast',
  'Sleep',
  'Deep Focus',
  'Kids',
  'Productivity',
  'Ambient Sound',
  'Free'
];

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);
  static const String id = '/Upload_product_screen';

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  String mainCategValue = 'Focus';
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  dynamic _pickImageError;

  void _pickProductImages() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 96,
      );
      setState(() {
        _imageFileList = pickedImages!;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError);
    }
  }

  Widget previewImages() {
    if (_imageFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: _imageFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(_imageFileList![index].path));
          });
    } else {
      return const Center(
        child: Text('you have not \n \n picked images yet !',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      );
    }
  }

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imageFileList!.isNotEmpty) {
        setState(() {
          _imageFileList = [];
          mainCategValue = "Focus";
        });
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please pick images first',
            contentType: ContentType.failure,
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'Please Enter all the fields Properly',
          contentType: ContentType.failure,
        ),
      ));
    }
  }

  void SelectedMainCategory(String? value)
  {
    setState(() {
      mainCategValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(children: [
                  Stack(children: [
                    Container(
                      color: Colors.grey,
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: _imageFileList != null
                          ? previewImages()
                          : const Center(
                              child: Text(
                                  'you have not \n \n picked images yet !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16)),
                            ),
                    ),
                    _imageFileList!.isEmpty
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                _imageFileList = [];
                              });
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.black,
                            )),
                  ]),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.20),
                    child: Column(
                      children: [
                        const Text("Select Category"),
                        DropdownButton(
                         focusColor: Colors.black,
                          dropdownColor: Colors.grey,
                          menuMaxHeight: 500,
                          elevation: 0,
                            borderRadius: BorderRadius.circular(5),
                            enableFeedback: true,
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                            value: mainCategValue,
                            items:mainCateg.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                child: Text(value , style: TextStyle(color: Colors.black),),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              SelectedMainCategory(value);
                            })
                      ],
                    ),
                  )
                ]),
                SizedBox(
                  height: 30,
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Price";
                      } else if (value.isValidPrice() != true) {
                        return 'Invalid Price';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      price = double.parse(value!);
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Enter a price for a product',
                        labelText: 'Price',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Quantity";
                      } else if (value.isValidQuantity() != true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'On Snap!',
                            message: 'Please Enter valid Quantity',
                            contentType: ContentType.failure,
                          ),
                        ));
                      }
                      return null;
                    },
                    onSaved: (value) {
                      quantity = int.parse(value!);
                    },
                    keyboardType: TextInputType.number,
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Add Quantity',
                        labelText: 'Quantity',
                        prefixIcon: Icon(
                          Icons.production_quantity_limits_outlined,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Name";
                      }
                      return null;
                    },
                    maxLength: 100,
                    maxLines: 3,
                    onSaved: (value) {
                      proName = value!;
                    },
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Enter Product Name',
                        labelText: 'Product Name',
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Description";
                      }
                      return null;
                    },
                    maxLength: 800,
                    maxLines: 5,
                    onSaved: (value) {
                      proDesc = value!;
                    },
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Product Description',
                        labelText: 'Product Description',
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _imageFileList!.isEmpty
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: FloatingActionButton(
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    onPressed: () {
                      _pickProductImages();
                    },
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              mouseCursor: MaterialStateMouseCursor.clickable,
              onPressed: () {
                _pickProductImages();
              },
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              uploadProduct();
            },
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.upload,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
    hintText: 'Price',
    labelText: 'Price',
    floatingLabelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    ),
    prefixIcon: Icon(Icons.phone, color: Colors.black),
    suffixIconColor: Colors.black);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}
