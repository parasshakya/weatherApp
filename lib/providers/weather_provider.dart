
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/states/weather_state.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState> ((ref) => WeatherNotifier(
  WeatherState.empty()
) );

class WeatherNotifier extends StateNotifier<WeatherState>{
  WeatherNotifier(super.state);

  Future<void> getWeatherFromCity({required String location}) async{

    state = state.copyWith(isLoading: true, errorMessage: '');
    final response = await WeatherService.getWeatherFromCity(location: location);
    response.fold((l) {
      state = state.copyWith(isLoading: false, errorMessage: l);
    }
        , (r) {
      state = state.copyWith(isLoading: false, errorMessage: '' , weatherData: r);
        });

  }
  Future<void> getWeatherFromLongLat({required String long, required String lat}) async {

    state = state.copyWith(isLoading: true, errorMessage: '');
    final response = await WeatherService.getWeatherFromLongLat(long: long, lat: lat);
    response.fold((l) {
      state = state.copyWith(isLoading: false, errorMessage: l);
    }
        , (r) {
          state = state.copyWith(isLoading: false, errorMessage: '' , weatherData: r);
        });

  }




}