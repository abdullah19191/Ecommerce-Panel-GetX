import 'package:ecommerce_app_panal/models/Product_models.dart';
import 'package:ecommerce_app_panal/services/Database_service.dart';
import 'package:ecommerce_app_panal/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/Product_controller.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.find();
  DatabaseService databaseService = DatabaseService();
  StorageService storageService = StorageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              ImagePicker _picker = ImagePicker();
                              final XFile? _image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No Image Selected. ')));
                              }
                              if (_image != null) {
                                await storageService.uploadImage(_image);
                                var imageUrl = await storageService
                                    .getDownloadURL(_image.name);
                                productController.newProduct.update(
                                    'imageUrl', (_) => imageUrl,
                                    ifAbsent: () => imageUrl);
                                print(productController.newProduct['imageUrl']);
                              }
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            )),
                        const Text(
                          'Add New Image',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Products Information',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                buildTextFormField('Product ID', 'Id', productController),
                buildTextFormField('Product Name', 'name', productController),
                buildTextFormField('Product Description', 'description', productController),
                buildTextFormField('Product Category', 'category', productController),
                const SizedBox(
                  height: 10,
                ),
                buildSlider(context, 'Price', 'price', productController,
                    productController.price),
                buildSlider(context, 'Quantity', 'quantity', productController,
                    productController.quantity),
                const SizedBox(
                  height: 10,
                ),
                buildCheckedBox(context, 'Recommended', 'isRecommended',
                    productController, productController.isRecommended),
                buildCheckedBox(context, 'Popular', 'isPopular',
                    productController, productController.isPopular),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          databaseService.addProduct(Product(
                              description: productController.newProduct['description'],
                              id: productController.newProduct['id'].toString(),
                              category: productController.newProduct['category'],
                              isRecommended: productController.newProduct['isRecommended'],
                              isPopular: productController.newProduct['isPopular'],
                              imageUrl: productController.newProduct['imageUrl'],
                              name: productController.newProduct['name'],
                              price: productController.newProduct['price'],
                              quantity: productController.newProduct['quantity'].toInt(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildCheckedBox(BuildContext context, String title, String name,
      ProductController productController, bool? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Checkbox(
            value: (controllerValue == null) ? false : controllerValue,
            checkColor: Colors.black,
            activeColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: () => value);
            }),
      ],
    );
  }

  Row buildSlider(BuildContext context, String title, String name,
      ProductController productController, double? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
              max: 25,
              min: 0,
              divisions: 10,
              activeColor: Colors.black,
              inactiveColor: Colors.black12,
              value: (controllerValue == null) ? 0 : controllerValue,
              onChanged: (value) {
                productController.newProduct
                    .update(name, (_) => value, ifAbsent: () => value);
              },
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(
          String hintText, String name, ProductController productController) =>
      TextFormField(
          decoration: InputDecoration(hintText: hintText),
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: () => value);
          });
}
