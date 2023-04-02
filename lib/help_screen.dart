import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/home_page.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Future.delayed(const Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage())),);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundFrame.png"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children:  [
                Text('We show weather for you', style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 24
                )),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('SHOW_SPLASH', false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade700
                  ),
                  child:  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Text('Skip', style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w300
                    ),),
                  ),
                ),


              ],
            ),
          ],
        ),
      )

    );
  }
}
