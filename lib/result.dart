import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submissionbmi/bmi.dart';

class ResultPage extends StatefulWidget{
  @override
  ResultPageState createState() => ResultPageState();
  
}

class ResultPageState extends State<ResultPage>{
  String _hasilBMI = '';
  String _keterangan = '';
  String _saran = '';

  Future<void> getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedTinggi = prefs.getString('tinggi');
      String? storedBerat = prefs.getString('berat');

      double tinggi = double.parse(storedTinggi!);
      double berat = double.parse(storedBerat!);
      double bmi = berat / ((tinggi/100)*(tinggi/100));
      String _ket = '';
      String _sar = '';
      if(bmi<18.5){
        _ket = 'Underweight';
        _sar = 'Tingkatkan asupan kalori dari makanan bergizi. Konsultasikan dengan dokter atau ahli gizi untuk mendapatkan program yang tepat.'; 
      }else if(bmi < 25){
        _ket = 'Normal';
        _sar = 'Pertahankan pola makan sehat dan seimbang. Rutin berolahraga secara teratur.';
      }else if(bmi < 30){
        _ket = 'Overweight';
        _sar = 'Kurangi asupan kalori, terutama dari makanan tinggi lemak dan gula. Tingkatkan aktivitas fisik. Konsultasikan dengan dokter atau ahli gizi untuk membuat rencana penurunan berat badan yang aman dan efektif.';
      }else{
        _ket = 'Obesitas';
        _sar = 'Segera konsultasikan dengan dokter untuk mendapatkan penanganan yang tepat. Lakukan perubahan gaya hidup yang signifikan, seperti diet sehat, olahraga teratur, dan manajemen stres.';
      }
      setState(() {
        _hasilBMI = bmi.toStringAsFixed(2);
        _keterangan = _ket;
        _saran = _sar;
      });
  }

  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(padding: EdgeInsets.all(12),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text('BMI Kamu',style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 20)),
           Text(_hasilBMI,style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 48)),
           SizedBox(height: 30),
           Text('Keterangan',style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 20)),
           Text(_keterangan,style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 30)),
           SizedBox(height: 30),
           Text(_saran,style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 16),textAlign: TextAlign.center),
           SizedBox(height: 30),
           ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context)=> BMIPage()));
           }, 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white,minimumSize: Size(200,50)),
            child: Text('Hitung BMI Lagi',style: TextStyle(color: Colors.blue,fontFamily: 'CustomFont',fontSize: 16))),
          ],
        ),
      ),
      ),
    );
  }

}