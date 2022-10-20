import 'dart:convert';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/product/models/product_list_model.dart';
import 'package:suppwayy_mobile/suppwayy_config.dart';
import 'package:http/http.dart' as http;

class ProductsService extends MainRepository {
  ///
  /// Get list of product
  ///
  Future<ProductListModel> fetchProducts() async {
    Uri uri = Uri.parse(SuppWayy.getProducts);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);

    if (response.statusCode == HttpStatus.ok) {
      final String rawProductsList = response.body.toString();
      return ProductListModel.fromJson(rawProductsList);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<bool> addProduct(Product product) async {
    Uri uri = Uri.parse(SuppWayy.getProducts);
    String data = """{
            "name": "${product.name}",
            "gtin": "${product.gtin}",
            "quantity": ${product.quantity},
            "volume": "${product.volume}",
            "taxe": ${product.taxe},
            "standardprice": "${product.standardprice}"
        }""";
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == HttpStatus.created) {
      return true;
    } else {
      return false;
    }
  }

  /// Update data of product with patch
  /// send request with product Id and the data updated
  ///
  Future<bool> patchProduct(int productID, Map updatedProductData) async {
    Uri uri = Uri.parse(SuppWayy.getProducts + '$productID');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.patch(uri,
        headers: headers, body: jsonEncode(updatedProductData));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  ///Delete Product with Id
  Future<bool> deleteProduct(int productId) async {
    Uri uri = Uri.parse(SuppWayy.getProducts + '$productId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      return false;
    }
  }

  ///Add new medias to product with post
  /// params(productId , XFile photo)
  ///
  Future<bool> postNewMedia(int productId, XFile? photo) async {
    String name = photo!.name;
    String description = photo.path;
    var stream = http.ByteStream(Stream.castFrom(photo.openRead()));
    var length = await photo.length();
    var uri = Uri.parse(SuppWayy.getProductMedias(productId));
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(getHeadersWithAuthorization);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(photo.path));
    request.files.add(multipartFile);
    request.fields["name"] = name;
    request.fields["description"] = description;
    var response = await request.send();
    if (response.statusCode == HttpStatus.created) {
      return true;
    } else {
      throw Exception();
    }
  }

  /// Delete media of product
  /// params(productId , photoId)
  ///
  Future<bool> deletePhotoProduct(int productId, int photoId) async {
    Uri uri = Uri.parse(SuppWayy.getProductMedias(productId) + '/$photoId');
    var headers = getHeadersWithAuthorization;
    headers["content-type"] = "application/json";
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      return false;
    }
  }

  ///
  ///
  ///
  Future<bool> postProductImage(int productId, XFile? image) async {
    var stream = http.ByteStream(Stream.castFrom((image!.openRead())));
    var length = await image.length();

    var uri = Uri.parse(SuppWayy.getProductImage(productId));
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(getHeadersWithAuthorization);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(image.path));
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == HttpStatus.created) {
      imageCache!.clear();
      imageCache!.clearLiveImages();
      return true;
    } else {
      throw Exception();
    }
  }
}
