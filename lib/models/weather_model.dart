class Weather{
  final String location;
  final String temp;
  final String conditionText;
  final String iconUrl;

  Weather({required this.location, required this.temp, required this.conditionText, required this.iconUrl});

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(location: json['location']['name'], temp: '${json['current']['temp_c']} °C', conditionText: json['current']['condition']['text'],
    iconUrl: 'https:${json['current']['condition']['icon']}'
    );
  }

}