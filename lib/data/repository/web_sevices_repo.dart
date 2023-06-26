import 'package:puzzle_game/data/data_source/web_services.dart';
import 'package:puzzle_game/data/model/auth_response.dart';
import 'package:puzzle_game/data/model/register_request.dart';

import '../model/coins_model.dart';
import '../model/login_request.dart';
import '../model/ranked_user.dart';
import '../model/user.dart';

class WebServicesRepo {
  final WebServices _webServices;

  WebServicesRepo(this._webServices);

  Future<AuthResponse> registerNewUser(RegisterRequest registeredUser) async {
    return await _webServices.registerNewUser(registeredUser);
  }

  Future<AuthResponse> loginUser(LoginRequest loginRequest) async {
    return await _webServices.loginUser(loginRequest);
  }

  Future<List<RankedUser>> getRankedUsers(String token) async {
    return await _webServices.getRankedUsers(token);
  }

  Future<void> putUpdatedCoins(CoinsModel coins, String token) async {
    return await _webServices.putUpdatedCoins(coins, token);
  }

  Future<User> checkUserAndGetValues(String token) async {
    return await _webServices.checkUserAndGetValues(token);
  }
}
