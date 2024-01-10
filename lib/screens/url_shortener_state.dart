import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/url_shortner_response_model.dart';

class UrlShortenerState extends ChangeNotifier {
  final urlController = TextEditingController();

  String shortUrlMessage = "Give some long url to convert";

  handleGetLinkButton() async {
    final longUrl = urlController.text;

    final String shortUrl = await getShortLink(longUrl);

    shortUrlMessage = "$shortUrl";

    notifyListeners();

  }

  Future<String> getShortLink(String longUrl) async {
    final result = await http.post(Uri.parse("https://cleanuri.com/api/v1/shorten"), body: {"url" : longUrl});

    if(result.statusCode == 200){
      print("Successfully Completed");

      final response = urlShortnerResponseFromJson(result.body);

      return response.resultUrl;
    }else{
      print("Error in Api");
      print(result.body);
      return "There is some error in shortening the url";
    }
  }
}