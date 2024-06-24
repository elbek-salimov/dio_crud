import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api_client.dart';
import 'models/ebooks_model.dart';

class ApiProvider extends ApiClient {
  Future<List<EbooksModel>> getEbooks() async {
    List<EbooksModel> ebooks = [];

    try {
      Response response = await dio.get("https://crudapi.co.uk/api/v1/ebooks");
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

  Future<EbooksModel?> createEbook(EbooksModel ebook) async {
    try {
      Response response = await dio.post(
        "https://crudapi.co.uk/api/v1/ebooks",
        data: [ebook.toJson()],
      );
      if (response.statusCode == 201) {
        return EbooksModel.fromJson(response.data);
      }
    } catch (error) {
      debugPrint("ERROR: $error");
    }
    return null;
  }

  Future<EbooksModel?> updateEbook(EbooksModel ebook) async {
    try {
      Response response = await dio.put(
        "https://crudapi.co.uk/api/v1/ebooks",
        data: [ebook.toJson()],
      );
      if (response.statusCode == 200) {
        return EbooksModel.fromJson(response.data);
      }
    } catch (error) {
      debugPrint("ERROR: $error");
    }
    return null;
  }

  Future<bool> deleteEbook(String id) async {
    try {
      Response response = await dio.delete(
        "https://crudapi.co.uk/api/v1/ebooks",
        data: [{"_uuid": id}],
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      debugPrint("ERROR: $error");
    }
    return false;
  }
}
