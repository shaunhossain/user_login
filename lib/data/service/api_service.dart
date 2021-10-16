import 'package:http/http.dart' as http;
import 'package:user_login/core/utlity/utlity.dart';
import 'package:user_login/data/model/user_model.dart';

abstract class BaseApiService {
  Future<UserModel> sendDriverLoginRequest(
      String name, String jobTitle);
}

class ApiService implements BaseApiService {
  @override
  Future<UserModel> sendDriverLoginRequest(
      String name, String jobTitle) async {

    Map<String, String> jsonBody = {
      "name": name,
      "job": jobTitle
    };
    try {
      final response = await http.post(
        Uri.parse(baseUrl+loginUrlPath),
        body: jsonBody,
      );

      // check the status code for the result
      if(response.statusCode == 201){
        final String responseString = response.body;

        return userModelFromJson(responseString);
      }else{
        final String responseString = response.body;

        return userModelFromJson(responseString);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}