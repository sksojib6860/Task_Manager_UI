import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/user_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/user_provider.dart';
import 'package:task_managment_app/utils/url.dart';

class SignInProvider extends ChangeNotifier {
  bool signInProgress = false;

  Future<NetworkResponse> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    signInProgress = true;
    notifyListeners();

    try {
      final Map<String, dynamic> requestedBody = {
        "email": email,
        "password": password,
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        Url.signInUrl,
        body: requestedBody,
      );

      if (response.isSuccess) {
        String token = response.body["token"];
        UserModel user = UserModel.fromJson(response.body["data"]);
        await context.read<UserProvider>().saveUserData(token, user);
        return NetworkResponse(isSuccess: true, statusCode: 200);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "User not found or wrong password",
        );
      }
    } catch (e) {
      debugPrint("sign in failed failed $e");
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      signInProgress = false;
      notifyListeners();
    }
  }
}
