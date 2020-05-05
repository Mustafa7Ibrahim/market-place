import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/widgets/add_images.dart';
import 'package:market_place/widgets/edit_feild.dart';
import 'package:market_place/widgets/list_of_assets.dart';
import 'package:market_place/widgets/list_of_images.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddNewProduct extends StatefulWidget {
  final List proImages;
  final String proName;
  final String proPrice;
  final String proQuantity;
  final String proType;
  final String proDes;
  final String proSpecif;

  AddNewProduct({
    @required this.proImages,
    @required this.proName,
    @required this.proQuantity,
    @required this.proType,
    @required this.proDes,
    @required this.proSpecif,
    @required this.proPrice,
  });
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final formKey = GlobalKey<FormState>();
  final Product product = Product();

  List<Asset> images = List<Asset>();
  List<String> _imageUrls = List();
  Map<String, String> filePaths;

  String type;
  bool loading;

  //faild controller
  String name;
  String price;
  String quantity;
  String description;
  String specifications;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              images == null || images.isEmpty && widget.proImages == null
                  ? AddImages(
                      height: height,
                      width: width,
                      onTap: loadAssets,
                    )
                  : widget.proImages == null
                      ? SizedBox(
                          height: height / 2,
                          child: ListView.builder(
                            itemCount: images?.length ?? 0,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ListOfAssets(
                                onTap: loadAssets,
                                height: height,
                                width: width,
                                images: images,
                                index: index,
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: height / 2,
                          child: ListView.builder(
                            itemCount: images?.length ?? 0,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ListOfImages(
                                height: height,
                                width: width,
                                images: product.productImages,
                                index: index,
                                onTap: loadAssets,
                              );
                            },
                          ),
                        ),
              EditFeild(
                hint: 'Product Name',
                enable: true,
                max: 1,
                currentValue: widget.proName == null ? name : widget.proName,
              ),
              EditFeild(
                hint: 'Price',
                enable: true,
                max: 1,
                currentValue: widget.proPrice == null ? price : widget.proPrice,
              ),
              EditFeild(
                hint: 'Quantity',
                enable: true,
                max: 1,
                currentValue:
                    widget.proQuantity == null ? quantity : widget.proQuantity,
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [shadow],
                ),
                child: DropdownButton(
                  hint: Text('Product Type'),
                  isExpanded: true,
                  focusColor: Colors.white,
                  value: widget.proType != null ? widget.proType : type,
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.black87, fontSize: 18.0),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  onChanged: (String onChange) => setState(
                    () => type = onChange,
                  ),
                  items: types.map((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                ),
              ),
              EditFeild(
                hint: 'Description',
                enable: true,
                max: 6,
                currentValue:
                    widget.proDes == null ? description : widget.proDes,
              ),
              EditFeild(
                hint: 'Specifications',
                enable: true,
                max: 8,
                currentValue: widget.proSpecif == null
                    ? specifications
                    : widget.proSpecif,
              ),
              WidthButton(
                loading: loading,
                width: width,
                title: 'Add Product',
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    // print the data in the termnal
                    print(name);
                    print(price);
                    print(quantity);
                    print(description);
                    print(specifications);
                    print(type);
                    // checking if images is not empty
                    if (images.isNotEmpty) {
                      // show the loading screen
                      setState(() => loading = true);
                      // start with uploading the images
                      await uploadImages().then((onComplete) async {
                        // checking if the urls is empty
                        if (_imageUrls.isNotEmpty) {
                          // whene complete add the product data
                          await product.addNewProduct(
                            productName: name,
                            price: price,
                            productType: type,
                            description: description,
                            quantity: quantity,
                            specification: specifications,
                            productImages: _imageUrls,
                          );
                        } else {
                          // show that there is somthing went wrong
                          setState(() => loading = false);
                          Fluttertoast.showToast(
                            msg: 'Somthing went wrong',
                          );
                        }
                        // if an error happened
                      }).catchError((onError) {
                        setState(() => loading = false);
                        Fluttertoast.showToast(
                          msg: 'Somthing went wrong: $onError',
                        );
                        // when it finshed clear everything and navigate to home
                      }).whenComplete(() {
                        setState(() {
                          loading = false;
                          name = '';
                          price = '';
                          description = '';
                          quantity = '';
                          specifications = '';
                          images.clear();
                          type = null;
                        });
                        Fluttertoast.showToast(
                          msg: 'Product add Successfuly',
                        );
                        Navigator.pushNamed(context, '/saller');
                      });
                    } else if (widget.proImages.isNotEmpty) {
                      // show the loading screen
                      setState(() => loading = true);
                      // start with uploading the images
                      await uploadImages().then((onComplete) async {
                        // checking if the urls is empty
                        if (_imageUrls.isNotEmpty) {
                          // whene complete add the product data
                          await product.updateNewProduct(
                            proId: product.productId,
                            productName: name,
                            price: price,
                            productType: type,
                            description: description,
                            quantity: quantity,
                            specification: specifications,
                            productImages: _imageUrls == null
                                ? widget.proImages
                                : _imageUrls,
                          );
                        } else {
                          // show that there is somthing went wrong
                          setState(() => loading = false);
                          Fluttertoast.showToast(
                            msg: 'Somthing went wrong',
                          );
                        }
                        // if an error happened
                      }).catchError((onError) {
                        setState(() => loading = false);
                        Fluttertoast.showToast(
                          msg: 'Somthing went wrong: $onError',
                        );
                        // when it finshed clear everything and navigate to home
                      }).whenComplete(() {
                        setState(() {
                          loading = false;
                          name = '';
                          price = '';
                          description = '';
                          quantity = '';
                          specifications = '';
                          images.clear();
                          type = null;
                        });
                        Fluttertoast.showToast(
                          msg: 'Product updated Successfuly',
                        );
                        Navigator.pushNamed(context, '/saller');
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  imageView(var width, var index, var height) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: width / 2 + 34,
      decoration: BoxDecoration(
        boxShadow: [shadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: AssetThumb(
          asset: images[index],
          width: 300,
          height: 300,
          spinner: Loading(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    setState(() => images = List<Asset>());
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
      );
    } on Exception catch (e) {
      e.toString();
    }
    if (!mounted) return;

    setState(() => images = resultList);
  }

  Future<List<String>> uploadImages() async {
    await Future.wait(
        images.map(
          (Asset asset) async {
            ByteData byteData = await asset.getByteData();
            List<int> imageData = byteData.buffer.asUint8List();

            StorageReference reference =
                FirebaseStorage.instance.ref().child(asset.name);
            StorageUploadTask uploadTask = reference.putData(imageData);
            StorageTaskSnapshot storageTaskSnapshot;

            StorageTaskSnapshot snapshot = await uploadTask.onComplete;
            if (snapshot.error == null) {
              storageTaskSnapshot = snapshot;
              final String downloadUrl =
                  await storageTaskSnapshot.ref.getDownloadURL();
              _imageUrls.add(downloadUrl.toString());

              print('Upload success');
            } else {
              print('Error from image repo ${snapshot.error.toString()}');
              throw ('This file is not an image');
            }
          },
        ),
        eagerError: true,
        cleanUp: (_) {
          print('eager cleaned up');
        });

    return _imageUrls;
  }
}
