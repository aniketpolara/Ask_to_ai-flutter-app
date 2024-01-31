import 'dart:convert';
import 'dart:developer';
import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/models/photos_model.dart';
import 'package:http/http.dart' as http;

class ApiServicesData {
  static var client = http.Client();

  static Future<String> chatCompeleteResponse(String prompt) async {
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    log("prompt : $prompt");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringResource.txtAPIKEY}',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": prompt}
        ]
      }),
    );
    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    return newresponse['choices'][0]['message']['content'];
  }

  static Future<List> imageGenerateResponse(String prompt, String size) async {
    var url = Uri.https("api.openai.com", "/v1/images/generations");
    log("prompt : $prompt");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StringResource.txtAPIKEY}',
      },
      body: json.encode({"prompt": prompt, "n": 10, "size": size}),
    );

    return json
        .decode(response.body)['data']
        .map((data) => PhotosModel.fromJson(data).url)
        .toList();
  }
}
