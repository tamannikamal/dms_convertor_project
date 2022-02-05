import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

//شاشة التطبيق الرئيسية
class ClockApp extends StatefulWidget {
  ClockApp({Key? key}) : super(key: key);

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  //لاستقبال وتخزين القيم من المستخدم
  TextEditingController controller = TextEditingController();
  // لاستقبال قيمة الدقائق
  TextEditingController controller2 = TextEditingController();
  // لاستقبال قيمة الثواني
  TextEditingController controller3 = TextEditingController();
  
  //validating key
  //يستخدم لمعرفة ماهية القيم التي تم ادخالها
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  var _formKey3 = GlobalKey<FormState>();

  //new test
  var test = '';
  //button text
  //متغير يحتوي على قيمة النص الدي يظهر على الزر
  String btnText = 'C A L C U L A T E';
  
  //boolean to check if btn pressed
  //متغير لمعرفة هل تم ضغط الزر أم لا
  bool btnPressed = false;
  //متغير لمراقبة حالة الزر ان كانت مضغوطة
  bool toggleButton = true;
  
  //checking output green border
  //متغير لمعرفة هل تم إدخال قيم من المستخدم ام لا
  bool isThereResult = false;

  //ثلاث متغيرات للدرجات والدقائق والثواني على التوالي
  double dig = 00;
  int min= 00;
  int sec = 00;
  
  //دالة تقوم بحساب وتحويل من درجات ودقائق وثواني إلى القيم الدائرية
  String Valu(){
    //متغير  "ديقري" يخزن القيمة المدخلة في خانة الدرجات ويخزنها في المتغير الخاص بالدرجات
    String degree = controller.text;
    controller.text = degree.replaceAll(new RegExp(r'[^0-9]'),'');
    dig = double.parse(degree);

    //متغير "مينتس" يخزن القيمة المقروءة من خانة ادخال الدقائق ويضعها في المتغير الخاص بالدقائق
    String minutes = controller2.text;
    controller2.text = minutes.replaceAll(RegExp(r'[^0-9]'), '');
    min = int.parse(minutes);
    
    //متغير "سيكندس" يخزن القيمة المقروءة من خانة ادخال الثواني ويضعها في المتغير الخاص بالثواني
    String seconds = controller3.text;
    controller3.text = seconds.replaceAll(RegExp(r'[^0-9]'), '');
    sec = int.parse(seconds);

    //متغير يحسب الدرجات العشرية أولا من ثم يحسب الدائرية منها عبر المعادلة
    num   decDegree = dig + (min + (sec/60))/60;
    double radians = decDegree * (pi/180);

    //تخزين القيمة النهائية في متغير "ريزلت" وتقريب النتيجة الى ثلاث خانات عشرية
    //toStringAsFixed to round the result (3)
    String result = radians.toStringAsFixed(3);
    //النتيجة العائدة النهائية - حيث يتم استخدام اسم الدالة اعلاه فتقوم بارجاع القيمة الدائئرية
    return result;
  }

  //هنا الكود الخاص بالشاشة وتصميمها واستخدام المتغيرات أعلاه فيها وكدلك استخدام الدالة
  @override
  Widget build(BuildContext context) {
    //media query library to fit all devies sizes
    //الميديا كيوري يتم استخدامها لضمان ان التطبيق سيعمل على كل أحجام الشاشات دون مشاكل
    MediaQueryData queryData = MediaQuery.of(context);

    String res = "00";
    return SafeArea(
      child: Scaffold(
        //خلفية الصورة للتطبيق موجودة في هدا الكونتينر
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              //صورة الخلفية
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

  //تم عمل هده الميثود حتى يتم تغيير الزر وتبعا له تفريغ محتويات خانات الادخال
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

//تم عمل هدا الكلاس حتى نضمن ان محتويات خانة الدقائق والثواني لاتزيد عن ال60
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
