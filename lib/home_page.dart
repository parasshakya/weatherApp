
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weather_app/common/constants.dart';
import 'package:weather_app/help_screen.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/location_service.dart';






class HomePage extends ConsumerWidget {



  final searchController = TextEditingController();
  final position =  LocationService.getCurrentPosition();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();



  @override
  Widget build(BuildContext context, ref) {

    final weatherState = ref.watch(weatherProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text('Weather App', style: AppBarTitleStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HelpScreen()));

            }, style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              elevation: 0,
            ),


                child: const Text('Go to Help Screen', style: TextStyle(color: Colors.white),)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  onFieldSubmitted: (value){
                    if(_formKey.currentState!.validate()) {
                      ref.read(weatherProvider.notifier).getWeatherFromCity(
                          location: value.trim());
                    }
                  },
                  focusNode: _focusNode,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter location";
                    }
                    return null;
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      enabledBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter location"
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ElevatedButton(onPressed: (){
                        position.then((value) => ref.read(weatherProvider.notifier).getWeatherFromLongLat(long: value.longitude.toString(), lat: value.latitude.toString()));
                  }, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white
                  ),


                      child: const Text('Temp in your Area', style: TextStyle(color: Colors.black),)),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      ref.read(weatherProvider.notifier).getWeatherFromCity(location: searchController.text.trim());
                      _focusNode.unfocus();
                    }
                  }, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white
                  ),


                      child: const Text('Search', style: TextStyle(color: Colors.black),)),
                ],
              ),
            ),
           SizedBox(height: 20,),
           Expanded(
             child: Container(
               padding: EdgeInsets.all(10),
               color: Colors.red,
               width: double.infinity,
               child: weatherState.isLoading ? Center(child: CircularProgressIndicator()) :
                   weatherState.errorMessage.isNotEmpty ? Center(child: Text(weatherState.errorMessage, style: errorMessageStyle,)) :
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 50,),
                       Text(weatherState.weatherData.location, style: locationStyle,),
                       SizedBox(height: 10,),
                       Row(
                         children: [
                           Text(weatherState.weatherData.conditionText, style: conditionTextStyle,),
                           CachedNetworkImage(
                             imageUrl: weatherState.weatherData.iconUrl,
                             placeholder: (context, url) => const CircularProgressIndicator(),
                             errorWidget: (context, url, error) => const Icon(Icons.error),
                           ),
                         ],
                       ),
                       SizedBox(height: 10,),
                       Text(weatherState.weatherData.temp, style: tempStyle,),
                       SizedBox(height: 10,),
                     ],
                   ),


             ),
           )

          ],
        ),
      )
      );

  }
}
