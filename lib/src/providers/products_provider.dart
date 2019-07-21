import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter_forms/src/models/product_model.dart';

class ProductsProvider {

  final String _url = "https://app-228219.firebaseio.com";

  Future<bool> createProduct ( ProductModel product ) async {

    final url = '$_url/products.json';
    final response = await http.post(url, body: productModelToJson( product ));
    final decodedData = json.decode(response.body);

    return true;
  }

  Future<List<ProductModel>> loadProducts () async {

    final url = '$_url/products.json';
    final response = await http.get(url);
    final Map<String, dynamic>  decodedData = json.decode(response.body);
    final List<ProductModel> products = new List();

    if (decodedData == null) return [];

    decodedData.forEach( (id, prod ) {
      final prodTemp = new ProductModel.fromJson(prod);
      prodTemp.id = id;
      products.add(prodTemp);
    }) ;
    return products;
  }

  Future<int> deleteProduct ( ProductModel product) async {

    final url = '$_url/products/${product.id}.json';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;

  }

  Future<bool> updateProduct (ProductModel product ) async {

    final url = '$_url/products/${product.id}.json';
    final response = await http.put(url, body: productModelToJson( product ));
    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;


  }
  
}