import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nt_ten/data/api_client.dart';
import 'package:flutter_nt_ten/data/models/ebooks_model.dart';

class ApiProvider extends ApiClient {

  Future<List<EbooksModel>> getEbooks() async {
    List<EbooksModel> ebooks = [];

    try {
      Response response = await dio.get("https://crudapi.co.uk/api/v1/products");
      if (response.statusCode == 200) {
        ebooks = (response.data["items"] as List?)
                ?.map((e) => EbooksModel.fromJson(e))
                .toList() ??
            [];
        return ebooks;
      }
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    return ebooks;
  }
}
