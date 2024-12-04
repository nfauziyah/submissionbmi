import 'package:flutter/material.dart';
import 'package:submissionbmi/bmi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeApp(),
    );
  }
}

class WelcomeApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Center(child: Image(image: AssetImage('assets/images/scale.png'),width: 300)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Ingin tahu apakah berat badan Anda ideal? Coba aplikasi BMI kami! Hitung BMI Anda dalam hitungan detik!',
                style: TextStyle(fontFamily: 'CustomFont',fontSize: 16)),
              ),
              SizedBox(height: 18),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context) => BMIPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,minimumSize: Size(200, 50)), 
              child: Text('Mulai Hitung BMI',
                     style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 16)))
            ],
          ),
        ),
    );
  }
  
}