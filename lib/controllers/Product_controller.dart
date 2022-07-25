import 'package:ecommerce_app_panal/models/Product_models.dart';
import 'package:ecommerce_app_panal/services/Database_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
var products = <Product>[].obs;
DatabaseService databaseService = DatabaseService();
var newProduct = {}.obs;

@override
void onInit(){
products.bindStream(databaseService.getProduct());
super.onInit();
}

get price => newProduct['price'];
get quantity => newProduct['quantity'];
get isRecommended => newProduct['isRecommended'];
get isPopular => newProduct['isPopular'];

void updateProductPrice(
    int index,
    Product product,
    double value
    ){
           product.price = value;
           products[index] = product;
     }

    void saveNewProductPrice(
        Product product,
        String field,
        double value,
        ){
       databaseService.updateField(product, field, value);
    }
void updateProductQuantity( int index,
    Product product,
    int value){
  product.quantity = value;
  products[index] = product;

}
}