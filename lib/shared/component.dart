import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/shared/style/colors.dart';

String token = '';

Widget defultTextField({
  required context,
  TextEditingController? controller,
  TextInputType? type,
  String? initivalue,
  Function(String)? onsubmit,
  Function(String)? onchange,
  Function() ? ontap,
   String? Function(String?) ?vaildate,
  bool ispassword = false,
  enable = true,
  String?  hintText,
  Color? hintcolor,
  Color? Texttcolor = Colors.black,
  Color? CursorColor,
  IconData? prefix ,
  IconData? suffix ,
  Function()? onSuffix,
  double?  height= 48 ,
  double?  width= double.infinity ,
}) =>
    Container(
      width:width ,
      height:height ,
      decoration: BoxDecoration(
        color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),),
     clipBehavior: Clip.antiAlias,
      child: TextFormField(
        cursorColor: CursorColor,
        controller: controller,
        keyboardType: type,
        obscureText: ispassword,
        textAlign: TextAlign.right,
        autocorrect: true,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsetsDirectional.zero,
          prefixIcon:Icon(prefix)  ,
          suffixIcon: IconButton(icon:Icon(suffix) ,onPressed:onSuffix),
          hintStyle: TextStyle(color: hintcolor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),),
        //  border: OutlineInputBorder(),
        ),
        validator: vaildate,
        onChanged: onchange,
        strutStyle: StrutStyle(fontStyle:FontStyle.normal),
        onTap: ontap,
       // onTap: ontap ,
        onFieldSubmitted: onsubmit,
        initialValue: initivalue,
        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black,fontSize: 12),
        textAlignVertical: TextAlignVertical.center,
      ),
    );

Widget defultButton({required String text,double width=double.infinity,double height= 50,
  required ontap}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: buttonColor)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5, horizontal: 5),
            child: Text(text, maxLines: 2,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 12
              ),),
          ),
          onPressed: ontap ),
    );

void NavigatorTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NavigatorAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => Widget), (route) {
    return false;
  });
}

Widget myDivited() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 2,
        color: Colors.black,
      ),
    );


Widget borderContainer({required text,width , double borderWidth =1 ,double ? height, Color color=Colors.black
,double Size= 12 })=>Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: Colors.white ,
        border:Border.all(color: Colors.black,width: borderWidth,style: BorderStyle.solid)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Center(
        child: Text(text.toString(), textAlign: TextAlign.center,
          style: TextStyle(color: color,
              fontWeight: FontWeight.bold, fontSize: Size),),
      ),
    ));