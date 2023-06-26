import 'package:dio/dio.dart';
import 'package:puzzle_game/data/model/auth_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/app_constants.dart';
import '../model/coins_model.dart';
import '../model/login_request.dart';
import '../model/ranked_user.dart';
import '../model/register_request.dart';
import '../model/user.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @POST(AppConstants.signUpEndPoint)
  Future<AuthResponse> registerNewUser(@Body() RegisterRequest registerRequest);

  @POST(AppConstants.loginEndPoint)
  Future<AuthResponse> loginUser(@Body() LoginRequest loginRequest);

  @GET(AppConstants.rankEndPoint)
  Future<List<RankedUser>> getRankedUsers(
      @Header('Authorization') String token);

  @PUT(AppConstants.coinsEndPoint)
  Future<void> putUpdatedCoins(
      @Body() CoinsModel coins, @Header('Authorization') String token);

  @GET(AppConstants.checkAuthEndPoint)
  Future<User> checkUserAndGetValues(@Header('Authorization') String token);
}

Dio initDio() {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
  );
  Dio dio = Dio(baseOptions);
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
    error: true,
  ));
  return dio;
}
