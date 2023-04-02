

import '../models/weather_model.dart';


class WeatherState{


     final bool isLoading;
  final String errorMessage;
   final Weather weatherData;

   WeatherState({required this.errorMessage, required this.isLoading, required this.weatherData});

   WeatherState copyWith({bool? isLoading, String? errorMessage , Weather? weatherData}){
     return WeatherState(errorMessage: errorMessage ?? this.errorMessage, isLoading: isLoading ?? this.isLoading, weatherData: weatherData ?? this.weatherData);
   }

   factory WeatherState.empty(){
     return WeatherState(errorMessage: '', isLoading: false, weatherData: Weather(
       conditionText: '', temp: '' , location: '', iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/48/BLANK_ICON.png'
     ));
   }


}