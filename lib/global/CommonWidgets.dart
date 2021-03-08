import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgets{
  //width
  static double widthFactor(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double textSize(BuildContext context,{double size}){
    double width=MediaQuery.of(context).size.width;
    double defaultSize=12;
    if(size!=null) {
      defaultSize = size;
    }
      defaultSize=defaultSize*0.2;
      return (defaultSize/100)*width;

  }

  //height
  static heightFactor(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

 static InputDecoration loginFormDecoration(String text,IconData data){
    return InputDecoration(
      prefixIcon: Icon(data,color: AppColours.white,),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      fillColor: AppColours.textFeildBG,

      hintStyle: TextStyle( color: AppColours.off_white,fontSize: Size.size(16)),
      hintText: text,
    );
  }

  static TextEditingController formFieldFixText(String value){
    TextEditingController _controller = new TextEditingController();
    _controller.text=value;
   return _controller;
  }
 static Widget goldenFullWidthButton(String text,{Function onClick})
 {
   return Row(
       children: [
         Expanded(
           child: RaisedButton(
               padding: EdgeInsets.all(Size.width(14)),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8.0)),
               color: AppColours.golden_button_bg,
               child: Text(text,style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: Size.size(16)),),
               onPressed: onClick),
         )]);
 }
 //check the validation
 static bool isValidate(GlobalKey<FormState> formKey) {
   final FormState form = formKey.currentState;
   if (form.validate()) {
     return true;
   } else {
     return false;
   }
 }

 static Widget requestTextContainer(String title,String text,IconData icon){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       SizedBox(height: 10,),
       Padding(
         padding: const EdgeInsets.only(left: 6,bottom: 6),
         child: Text(title,style: TextStyle(color: AppColours.white,fontSize: 16),),
       ),
       Container(
         decoration: BoxDecoration(
             color: AppColours.textFeildBG,
             borderRadius: BorderRadius.all(Radius.circular(10))
         ),
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Row(
             children: [
               Icon(icon,color: AppColours.white,),
               SizedBox(width: 5,),
               Expanded(child: Text(text,style: TextStyle(color: AppColours.white,fontSize: 16),)),
             ],
           ),
         ),
       ),
       SizedBox(height: Size.height(10),),
     ],
   );
 }
 static showMessage(BuildContext context,String message) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: AppColours.textFeildBG,
        title: Text("Message",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 20)),
        content: Text(message,style: TextStyle(color: AppColours.golden_button_bg,fontSize: 14)),
        actions: [okButton]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  static Widget settingsIcon(IconData icon){
   return Container(
       padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         color: AppColours.black,
         borderRadius: BorderRadius.circular(100),),
       child: Icon(
         icon,
         color: AppColours.golden_button_bg,
       ));
  }
 //selectedFont text
 static Widget selectedFontWidget(String title,Color textColor,double fontSize,FontWeight _boldOrNot){
   return Text(title, style: new TextStyle( fontSize: fontSize,color: textColor,
       fontFamily: "Lato",fontWeight: _boldOrNot));
 }
}