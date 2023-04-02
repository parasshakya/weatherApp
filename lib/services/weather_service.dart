

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/models/weather_model.dart';

import '../exceptions/api_exception.dart';


class WeatherService{
  static final dio = Dio();

  static Future<Either<String, Weather>> getWeatherFromCity({required String location}) async{
    try{
      print(Api.apiEndPoint);
      final response = await dio.get(Api.apiEndPoint, queryParameters: {
        'key' : '510596c1a5f04d1c81c104433232903',
        'q' : location
      });
      print('The Response Data is ${response.data}');
      print('The Response Code is ${response.statusCode}');
      final weather = Weather.fromJson(response.data);
      return Right(weather);
    }on DioError catch (err){
      return Left(DioException.getDioError(err));
    }


  }


  static Future<Either<String, Weather>> getWeatherFromLongLat({required String long, required String lat}) async{
    try{
      final response = await dio.get(Api.apiEndPoint, queryParameters: {
        'key' : '510596c1a5f04d1c81c104433232903',
        'q' : '$long,$lat'
      });

      final weather = Weather.fromJson(response.data);
      return Right(weather);
    }on DioError catch (err){
      return Left(DioException.getDioError(err));
    }


  }



}
