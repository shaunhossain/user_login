
import 'package:user_login/data/model/user_model.dart';
import 'package:user_login/data/service/api_service.dart';

class Repository {
  final  ApiService apiService = ApiService();

  Future<UserModel> sendRequestToServer(
      String name, String jobTitle) async {
    final userLoginData = await apiService.sendDriverLoginRequest(
        name,jobTitle);
    return userLoginData;
  }
}