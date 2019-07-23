import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';
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

  Future<String> uploadImage (File image) async {

    final url =  Uri.parse('https://api.cloudinary.com/v1_1/dyqatwbhn/image/upload?upload_preset=iw5ffq1h');
    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final response = await http.Response.fromStream(streamResponse);

    if ( response.statusCode != 200 && response.statusCode != 201) {

      print('algo mal');
      print(response.body);
      return null;
    }

    final respData = json.decode(response.body);
    print(respData);

    return respData['secure_url'];
  }
  
}