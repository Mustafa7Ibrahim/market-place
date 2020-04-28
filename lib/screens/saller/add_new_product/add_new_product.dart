import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/add_images.dart';
import 'package:market_place/widgets/edit_feild.dart';
import 'package:market_place/widgets/list_of_images.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  BuildContext context;
  final formKey = GlobalKey<FormState>();

  //faild controller
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final specificationsController = TextEditingController();

  List<Asset> images = List<Asset>();
  List<String> types = <String>[
    'Supermarket',
    'Fashion',
    'Mobile & Tablets',
    'Electronics',
    'Health & Beauty',
    'Home & Kitchen',
    'Babies',
    'Toys',
    'Appliances',
    'Sports',
    'Automotive',
    'Tools',
  ];
  String type;

  @override
  void initState() {
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
              images == null || images.isEmpty
                  ? AddImages(
                      height: height,
                      width: width,
                      onTap: loadAssets,
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
                            onTap: loadAssets,
                            height: height,
                            width: width,
                            images: images,
                            index: index,
                          );
                        },
                      ),
                    ),
              EditFeild(
                  hint: 'Product Name', max: 1, controller: nameController),
              EditFeild(hint: 'Price', max: 1, controller: priceController),
              EditFeild(
                  hint: 'Quantity', max: 1, controller: quantityController),
              Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.only(
                  left: 14.0,
                  right: 14.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [shadow],
                ),
                child: DropdownButton(
                  items: types.map((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String onChange) =>
                      setState(() => type = onChange),
                  hint: Text('Product Type'),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  focusColor: Colors.white,
                  value: type,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                  ),
                ),
              ),
              EditFeild(
                hint: 'Description',
                max: 6,
                controller: descriptionController,
              ),
              EditFeild(
                hint: 'Specifications',
                max: 8,
                controller: specificationsController,
              ),
              WidthButton(
                width: width,
                title: 'Add Product',
                onTap: () {
                  if (formKey.currentState.validate()) {
                    print(nameController.text);
                    print(priceController.text);
                    print(quantityController.text);
                    print(quantityController.text);
                    print(specificationsController.text);
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
          spinner: Loading(),
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
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }
}
