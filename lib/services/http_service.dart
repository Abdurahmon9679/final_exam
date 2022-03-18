import 'dart:convert';
import 'package:benaficary/models/recopients_class.dart';
import 'package:benaficary/services/log_service.dart';
import 'package:http/http.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "62345b68debd056201e2f71d.mockapi.io";
  static String SERVER_PRODUCTION = "62345b68debd056201e2f71d.mockapi.io";

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    //Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200 || response.statusCode == 201)
      return response.body;
    return null;
  }


  Future <String?> MULTIPART(String api,String filePath,Map<String,String>params)async{
    var uri = Uri.https(getServer(), api);
    var request = MultipartRequest("POST", uri);

    request.headers.addAll(getHeaders());
    request.fields.addAll(params);
    request.files.add(await MultipartFile.fromPath('picture', filePath));

    var res =await request.send();
    return res.reasonPhrase;
  }



  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  /* Http Apis */
  static String API_LIST = "/recipients/recipients";
  static String API_CREATE = "/recipients/recipients";
  static String API_UPDATE = "/recipients/recipients/"; //{id}
  static String API_DELETE = "/recipients/recipients/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Recipients recipient) {
    Map<String, String> params = {};
    params.addAll({
      'name': recipient.name,
      'reletionship': recipient.relationship,
      'phoneNumber': recipient.phoneNumber,
      });
    return params;
  }

  static Map<String, String> paramsUpdate(Recipients recipient) {
    Map<String, String> params = {};
    params.addAll({
      'id': recipient.id.toString(),
      'name': recipient.name,
      'reletionship': recipient.relationship,
      'phoneNumber': recipient.phoneNumber,
    });
    return params;
  }

   /* Http Parsing */

  static List<Recipients> parseResponse(String response) {
    List<Recipients> recipent = recipientsFromJson(response);
    return  recipent;
  }
}