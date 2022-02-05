import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ClockApp extends StatefulWidget {
  ClockApp({Key? key}) : super(key: key);

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  //validating key
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  var _formKey3 = GlobalKey<FormState>();

  //new test
  var test = '';
  //button text
  String btnText = 'C A L C U L A T E';
  //boolean to check if btn pressed
  bool btnPressed = false;
  bool toggleButton = true;
  //checking output green border
  bool isThereResult = false;

  double dig = 00;
  int min= 00;
  int sec = 00;


  String Valu(){
    String degree = controller.text;
    controller.text = degree.replaceAll(new RegExp(r'[^0-9]'),'');
    dig = double.parse(degree);

    String minutes = controller2.text;
    controller2.text = minutes.replaceAll(RegExp(r'[^0-9]'), '');
    min = int.parse(minutes);

    String seconds = controller3.text;
    controller3.text = seconds.replaceAll(RegExp(r'[^0-9]'), '');
    sec = int.parse(seconds);

    num   decDegree = dig + (min + (sec/60))/60;
    double radians = decDegree * (pi/180);

    //toStringAsFixed to round the result (3)
    String result = radians.toStringAsFixed(3);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    //media query library to fit all devies sizes
    MediaQueryData queryData = MediaQuery.of(context);

    String res = "00";
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Bitmap.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        //color: const Color(0xffb2978d),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline4,
                          children: [
                            TextSpan(
                              text: 'التحويل إلى ',
                            ),
                            TextSpan(
                              text: 'دائري (8)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 50),
                      padding: const EdgeInsets.only(left: 50),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Color(0xffb2978d),
                          ],
                        ),
                      ),
                      child: Text(
                        "تمنـــي كمـــال",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 50),
                      padding: const EdgeInsets.only(right: 55),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xffb2978d).withOpacity(0.6),
                              //Colors.white,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "ينـــاير 2022م",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height*0.06,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2 ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            color: Colors.black12,
                            blurRadius: 30,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "المــــدخلات",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height*0.02,
                    ),
                    //text fields
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            color: Colors.black12,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      height: queryData.size.height*0.19,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("درجة", style: TextStyle(),),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    validator: (String? value){
                                      if(value!.length<1)
                                        return 'أدخل الدرجة';
                                      else
                                        return null;
                                    },
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '00',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0.5, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: queryData.size.width*0.03,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("دقيقة"),
                                Form(
                                  key: _formKey3,
                                  child: TextFormField(
                                    //putting a range for the num been entered
                                    inputFormatters: [
                                      //LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.digitsOnly,
                                      CustomRangeTextInputFormatter(),
                                    ],
                                    style: TextStyle(fontSize: 20),
                                    validator: (String? value2){
                                      if(value2!.length<1)
                                        return 'أدخل الدقائق';
                                      else
                                        return null;
                                    },
                                    controller: controller2,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 2,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0.5, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      counterText: '',
                                      hintText: '00',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: queryData.size.width*0.03,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("ثانية"),
                                Form(
                                  key: _formKey2,
                                  child: TextFormField(
                                    //putting a range for the num been entered
                                    inputFormatters: [
                                      //LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.digitsOnly,
                                      CustomRangeTextInputFormatter(),
                                    ],
                                    style: TextStyle(fontSize: 20),
                                    validator: (String? value3){
                                      if(value3!.length<1)
                                        return 'أدخل الثواني';
                                      else
                                        return null;
                                    },
                                    controller: controller3,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 2,
                                    decoration: InputDecoration(
                                      filled: true,
                                      counterText: '',
                                      fillColor: Colors.white,
                                      hintText: '00',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0.5, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: queryData.size.height*0.038,),
                    //output
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            color: Colors.black12,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      height: queryData.size.height*0.1,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(width: queryData.size.width*0.12,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white.withOpacity(0.5),
                              border: Border.all(
                                color: isThereResult? Color(0xffb2978d):Colors.black12,
                                width: isThereResult? 2:1,
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            height: queryData.size.height*0.07,
                            width: queryData.size.width*0.27,
                            child: Text(test, textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 20,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          SizedBox(width: queryData.size.width*0.03,),
                          Expanded(
                            child: Text("المخرجات بالتقدير الدائري", style: TextStyle(
                                fontSize: 18
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: queryData.size.height*0.07,),
                    //button
                    InkWell(
                      onTap: () => ToggleButton(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              color: Colors.black12,
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: Text(btnText, style: TextStyle(
                          fontSize: 23,
                          letterSpacing: 2,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ToggleButton() {
    setState(() {
      _formKey.currentState!.validate();
      _formKey2.currentState!.validate();
      _formKey3.currentState!.validate();
      if(_formKey.currentState!.validate()){
        if(toggleButton){
          test = Valu();
          btnText = 'NEW';
          isThereResult = true;
          toggleButton =  false;
        }
        else{
          setState(() {
            test = '';
            controller.text = '';
            controller2.text = '';
            controller3.text = '';
            btnText = 'CALCULATE';
            isThereResult = false;
            toggleButton = true;
          });
        }
      }

    });
  }

}

class CustomRangeTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) {
    if(newValue.text == '')
      return TextEditingValue();
    else if(int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 59 ? TextEditingValue().copyWith(text: '59') : newValue;
  }
}
