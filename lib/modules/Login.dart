import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/LoginCubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/modules/layout.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';
import '../Api/get.dart';
import '../shared/Content.dart';
import '../shared/helper/cach_Helper.dart';
import 'loading.dart';


class loginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_loginScreen();
}
class _loginScreen extends State<loginScreen>
{
  bool login = false ;

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController Namecontroller=TextEditingController();
  TextEditingController IDcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
     
      return BlocConsumer<Logincubit,posStates>(
         listener: (context,state){},

        builder: (context,state){
          var cubit=Logincubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:Text('تسجيل الدخول',maxLines: 2,
              style: TextStyle(fontSize: 18,
                  color: Colors.white),
            ),
          ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(textDirection: TextDirection.rtl,
                    children: [
                      Text('اسم الشركه'.toUpperCase(),
                        style: TextStyle(
                            color: defultblack,fontWeight:FontWeight.bold,height: 1.1,fontSize: 12 ),
                      ),
                    ],
                  ),
                  if(LeName != null)
                    Container(
                       height: 45,
                        width:MediaQuery.of(context).size.width*.9 ,
                        decoration: BoxDecoration(
                          color: TTF,
                          borderRadius: BorderRadius.circular(16),),
                        clipBehavior: Clip.antiAlias,
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Text(LeName.toString(), textDirection: TextDirection.rtl,
                            style: TextStyle(color: defultcolor,fontSize: 14),),
                        )
                    ),
                  if(LeName == null)
                    defultTextField(
                    context: context,
                    prefix: Icons.business,
                    type: TextInputType.text,
                    controller: Namecontroller,
                  ),

                  if(LE_ID == null || LeName == null)
                  Column( crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 20,),
                      Text('كود الشركه'.toUpperCase(),
                        style: TextStyle(fontSize: 12,
                            color: defultblack,fontWeight:FontWeight.bold,height: 1.1 ),
                      ),
               //   if(LeId == null)
                        defultTextField(
                      //  width:MediaQuery.of(context).size.width*.6 ,
                        context: context,
                        prefix: Icons.business,
                        type: TextInputType.number,
                        controller: IDcontroller,),
                      SizedBox(height: 20,),
                    ],
                  ),

                  if((LE_ID == null || LeName == null) )

                    Center(
                      child: defultButton(text: 'حفظ', width: MediaQuery.of(context).size.width*.9,
                          ontap: () async { print (LE_ID.toString() +LeName.toString() );
                            if(IDcontroller.text != ''&& IDcontroller.text != null&& Namecontroller.text !='')
                            {

                               setState(() {

                            });
                               await  cubit.GetDataFrist(LeId: int.parse(IDcontroller.text),context: context ,
                               name: Namecontroller.text );
                               setState(() {

                               });
                             }
                             else{openmessage_LE_Null(context);}
                          setState(() {

                          });
                          }
                      ),
                    ),
                  SizedBox(height: 10,),
                 if(state is LoadingGetDataFriststate)
                   Center(child: LinearProgressIndicator()),

                 SizedBox(height: 20,),

                  Text('اسم المستخدم'.toUpperCase(),
                    style: TextStyle(fontSize: 12,
                        color: defultblack ,fontWeight:FontWeight.bold,height: 1.1 ),
                  ),
                  defultTextField(
                    context: context,
                     prefix: Icons.person,
                     type: TextInputType.emailAddress,
                     controller: emailcontroller,
                     ),
                  SizedBox(height: 20,),
                  Text('الرمز'.toUpperCase(),
                    style: TextStyle(fontSize: 12,
                        color: defultblack ,fontWeight:FontWeight.bold,height: 1.1
                    ),
                  ),
                  defultTextField(
                    context: context,
                      prefix: Icons.lock,
                      suffix: cubit.icon,
                      onSuffix: cubit.changeVisibilty,
                     type: TextInputType.visiblePassword,
                     ispassword: cubit.ispassword,
                     controller: passwordcontroller,),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Spacer(),
                      Container(
                          width: 120,
                          child: Text(
                            'تذكرنى',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: defultblack,
                                fontWeight: FontWeight.bold, fontSize: 14),
                          )),

                      Checkbox(
                        value: cubit.checkRemberme,
                        onChanged: (bool? v) {
                          cubit.changeRembermeCheck();
                        },
                        activeColor: defultcolor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  BuildCondition(
                    condition:state is !Loadingloginstate &&  !login ,
                    builder: (context)=>defultButton(text: 'تسجيل الدخول',
                     ontap: () async {
                      if(LE_ID == null || LeName == null){ openmessage_LE_Null(context); }
                      else  if(emailcontroller.text != ''&&emailcontroller.text != null&& passwordcontroller.text !='')
                       {

                         await  cubit.Search_USER(Name:emailcontroller.text,password:passwordcontroller.text  );
                         if(cubit.login)
                         {
                           setState(() {
                             login = true;
                           });
                           print ('before If $device $Active ');
                           if(device == null || Active == 0) {
                             print ('IN 1 /////// If $device $Active ');

                                    await getInf(context: context);
                             print ('IN 2 //// If $device $Active ');
                                    Future.delayed(Duration(seconds: 2),(){NavigatorTo(context, Loading());})  ;
                                  }
                            else {
                             print ('IN else  /////// If $device $Active ');
                            // Future.delayed(Duration(seconds: 2),(){NavigatorTo(context, LayoutScreen());})  ;
                                    NavigatorAndFinish(
                                        context, LayoutScreen());
                                 }
                                }
                         else {openmessageNull(context);}


                       }
                       else{openmessageNull(context);}
                     }
                     ),
                    fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                  ),
                  SizedBox(height: 10,),
                 ],
              ),
            ),
          ),
        ),
        ); },
        );
  }

  Future openmessageNull(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: Text(
          'برجاء ادخال اسم المستخدم و الرمز صحيح',textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent ),
  ),
      ) );

  Future openmessage_LE_Null(context)=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        content: Text(
          'تاكد من ادخال اسم الشركة و كود الشركه',textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent ),

        ),
      ) );

}