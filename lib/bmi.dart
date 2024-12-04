import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submissionbmi/result.dart';

class BMIPage extends StatefulWidget{
  @override
  BMIPageState createState() => BMIPageState();
  
}

class BMIPageState extends State<BMIPage>{
  final formKey = GlobalKey<FormState>();
  final _textTinggi = TextEditingController();
  final _textBerat = TextEditingController();
  bool malePressed = false;
  bool femalePressed = false;

  Future<void> kirimData() async{
    if(formKey.currentState!.validate() && (malePressed == true || femalePressed == true)){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('tinggi', _textTinggi.text);
      await prefs.setString('berat', _textBerat.text);
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=>ResultPage()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pilih Gender terlebih dahulu')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator',style: TextStyle(fontFamily: 'CustomFont',fontSize: 24,color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child:Column(
            children: [
              Text('Gender',style: TextStyle(fontFamily: 'CustomFont',fontSize: 16,color: Colors.blue)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      malePressed = true;
                      femalePressed = false;
                    });
                  }, icon: Icon(Icons.boy_rounded),iconSize: 100,
                  color: malePressed ? Colors.blue:Colors.grey),
                  IconButton(onPressed: (){
                    setState(() {
                      malePressed = false;
                      femalePressed = true;
                    });
                  }, icon: Icon(Icons.girl_rounded),iconSize: 100,color: femalePressed ? Colors.pink:Colors.grey)
                ],
              ),
              SizedBox(height: 20),
              Text('Tinggi Badan (cm)',style: TextStyle(color: Colors.blue,fontFamily: 'CustomFont',fontSize: 16)),
              SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(10))),
                  controller: _textTinggi,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Tinggi tidak boleh kosong!';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Hanya angka yang diperbolehkan';
                    }
                      return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Berat Badan (kg)',style: TextStyle(color: Colors.blue,fontFamily: 'CustomFont',fontSize: 16)),
              SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(10))),
                  controller: _textBerat,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Berat tidak boleh kosong!';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Hanya angka yang diperbolehkan';
                    }
                      return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                kirimData();
              }, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, minimumSize: Size(200, 50)),
              child: Text('Hitung BMI',style: TextStyle(color: Colors.white,fontFamily: 'CustomFont',fontSize: 16)))
            ],
          )),
      ),
    );
  }
}