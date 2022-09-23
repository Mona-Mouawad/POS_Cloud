import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/DataBase/Insert_City&Region.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/CUST_VEN_Model.dart';
import 'package:pos/modules/Customer&Stock.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/INSERTS.dart';
import '../shared/Content.dart';

class register_screen extends StatefulWidget {
  bool? Invoice;

  CUST_VEN_Model ? CUST_ModelEdit ;
  register_screen({this.Invoice,this.CUST_ModelEdit});

  @override
  State<StatefulWidget> createState() => _register_screen(Invoice: Invoice,CUST_ModelEdit:CUST_ModelEdit );
}

class _register_screen extends State<register_screen> {
  bool? Invoice;
  CUST_VEN_Model ? CUST_ModelEdit ;
  int ? CityId ;
  int ? RegionId ;

  _register_screen({this.Invoice,this.CUST_ModelEdit});

  // var registerKey =GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Citycontroller = TextEditingController();
  TextEditingController Regioncontroller = TextEditingController();
  TextEditingController SearchCitycontroller = TextEditingController();
  TextEditingController SearchRegioncontroller = TextEditingController();
  TextEditingController phone_1controller = TextEditingController();
  TextEditingController phone_2controller = TextEditingController();
  TextEditingController phone_3controller = TextEditingController();
  TextEditingController phone_4controller = TextEditingController();
  TextEditingController money = TextEditingController();
  TextEditingController maxIndebtedness = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController Address = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if( CUST_ModelEdit != null ){
      print('  CUST_ModelEdit!.CUST_VEN_ID  ' + CUST_ModelEdit!.CUST_VEN_ID.toString());
      namecontroller.text =='' ?  namecontroller.text= CUST_ModelEdit!.NAME! : null ;
      phone_1controller.text =='' ? phone_1controller.text= CUST_ModelEdit!.Phone1! : null ;
      phone_2controller.text =='' ? phone_2controller.text = CUST_ModelEdit!.Phone2! : null;
      CUST_ModelEdit!.Phone3 != null ? phone_3controller.text = CUST_ModelEdit!.Phone3! : phone_3controller.text = '' ;
      CUST_ModelEdit!.Phone4 != null ? phone_4controller.text = CUST_ModelEdit!.Phone4! : phone_4controller.text = '' ;
      CUST_ModelEdit!.CityName != '' && CUST_ModelEdit!.CityName != null &&  Citycontroller.text == '' ? Citycontroller.text = CUST_ModelEdit!.CityName! : Citycontroller.text = Citycontroller.text ;
      CUST_ModelEdit!.CityRegionName != '' && CUST_ModelEdit!.CityRegionName != null && Regioncontroller.text == '' ? Regioncontroller.text = CUST_ModelEdit!.CityRegionName! : Regioncontroller.text = Regioncontroller.text ;
      CUST_ModelEdit!.Address != null ? Address.text = CUST_ModelEdit!.Address! : Address.text ='' ;
   //   CUST_ModelEdit!.CityId != null ? CityId = CUST_ModelEdit!.CityId! : CityId = null ;
    //  CUST_ModelEdit!.RegionId != null ? RegionId = CUST_ModelEdit!.RegionId! : RegionId = null ;
       notes.text = CUST_ModelEdit!.Notes! ;
      money.text = CUST_ModelEdit!.AmountPaid!.toString() ;
      maxIndebtedness.text = CUST_ModelEdit!.MaxDebtLimt!.toString() ;

    }

    return BlocConsumer<posCubit, posStates>(
      builder: (context, state) {
        var cubit = posCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text(
              "تسجيل عميل جديد",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Icon(
                              Icons.people,
                              color: defultcolor,
                              size: 80,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'الاسم بالكامل'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                            context: context,
                            Texttcolor: defultcolor,
                            CursorColor: defultcolor,
                            type: TextInputType.name,
                            controller: namecontroller,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'المحافظه'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: text_1,
                                            fontWeight: FontWeight.bold,
                                            height: 1.6,
                                            fontSize: 12),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openCITY(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              .5 -
                                          45,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.grey[200]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Icon(Icons.arrow_drop_down),
                                          Text(
                                            Citycontroller.text.toString(),
                                            // textAlign: TextAlign.end,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: defultcolor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'المنطقه'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: text_1,
                                            fontWeight: FontWeight.bold,
                                            height: 1.6,
                                            fontSize: 12),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openRegion(context, cubit);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              .5 -
                                          45,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.grey[200]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Icon(Icons.arrow_drop_down),
                                          Text(
                                            Regioncontroller.text.toString(),
                                            // textAlign: TextAlign.end,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: defultcolor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'رقم الهاتف 1'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.phone,
                              controller: phone_1controller,
                              onsubmit: (value) {}),
                          Text(
                            'رقم الهاتف 2'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.phone,
                              controller: phone_2controller,
                              onsubmit: (value) {}),
                          Text(
                            'رقم الهاتف 3'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.phone,
                              controller: phone_3controller,
                              onsubmit: (value) {}),
                          Text(
                            'رقم الهاتف 4'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.phone,
                              controller: phone_4controller,
                              onsubmit: (value) {}),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'العنوان '.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                fontSize: 12,
                                color: text_1,
                                fontWeight: FontWeight.bold,
                                height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.text,
                              controller: Address,
                              onsubmit: (value) {}),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'المبلغ الي عليه'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                            context: context,
                            type: TextInputType.number,
                            controller: money,
                            hintText: '0',
                            hintcolor: defultcolor,
                            Texttcolor: defultcolor,
                            CursorColor: defultcolor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'حد اقصي للمديونيه'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                              context: context,
                              Texttcolor: defultcolor,
                              CursorColor: defultcolor,
                              type: TextInputType.number,
                              controller: maxIndebtedness,
                              onsubmit: (value) {}),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            ' ملاحظات  ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 12,
                                    color: text_1,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                          ),
                          defultTextField(
                            context: context,
                            Texttcolor: defultcolor,
                            CursorColor: defultcolor,
                            type: TextInputType.text,
                            controller: notes,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                 Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient:
                                          LinearGradient(colors: buttonColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: MaterialButton(
                                        child: Text(
                                          'حفظ بيانات العميل',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        onPressed: () async {
                                          if (maxIndebtedness.text == null ||
                                              maxIndebtedness.text == '') {
                                            maxIndebtedness.text = '0.0';
                                          }
                                          if (money.text == null ||
                                              money.text == '') {
                                            money.text = '0.0';
                                          }

                                          if (namecontroller.text != '' &&
                                              namecontroller.text != null &&
                                              phone_1controller.text != null &&
                                            //  Citycontroller.text != '' &&
                                             // Regioncontroller.text != '' &&
                                              phone_1controller.text != '' ) {
                                            if(CUST_ModelEdit != null)
                                              {
                                                if(CityId ==null ){CityId =CUST_ModelEdit!.CityId ;}
                                                if(RegionId ==null && Regioncontroller.text !='' ){RegionId =CUST_ModelEdit!.RegionId ;}
                                                if(RegionId ==null && Regioncontroller.text =='' ){RegionId = null ;}
                                                await updateCUST(
                                                  context: context,
                                                  id: CUST_ModelEdit!.CUST_VEN_ID!,
                                                  NAME: namecontroller.text,
                                                  MAX_DEBT_LIMT:
                                                  maxIndebtedness.text,
                                                  Address: Address.text,
                                                  CITY: CityId,
                                                  REGION: RegionId,
                                                  PHONE_2: phone_2controller.text,
                                                  NOTES: notes.text,
                                                  PHONE_1: phone_1controller.text,
                                                  AMOUNT_PAID: money.text,
                                                  PHONE_4: phone_4controller.text,
                                                  PHONE_3: phone_3controller.text,
                                                  CityName: Citycontroller.text ,
                                                  CityRegionName: Regioncontroller.text,
                                                );

                                              }
                                            else
                                            {
                                              if( CityId == Null ) CityId=null ;
                                              if( RegionId == Null ) RegionId=null ;
                                            await insertCUST(
                                              context: context,
                                              NAME: namecontroller.text,
                                              MAX_DEBT_LIMT:
                                                  maxIndebtedness.text,
                                              Address: Address.text,
                                              CITY: CityId,
                                              REGION: RegionId,
                                              PHONE_2: phone_2controller.text,
                                              NOTES: notes.text,
                                              PHONE_1: phone_1controller.text,
                                              AMOUNT_PAID: money.text,
                                              PHONE_4: phone_4controller.text,
                                              PHONE_3: phone_3controller.text,
                                            );

                                          }

                                          setState(() {
                                              if (insertCUSTS) {
                                                print (Invoice);
                                                if (Invoice == true) {

                                                  // Future.delayed(const Duration(milliseconds: 20), () async {
                                                  //
                                                  // });

                                                  print ('CUST_ModelList[CUST_ModelList.length - 1].NAME');
                                                  print (CUST_ModelList.length);
                                                  // Cust_Model = CUST_ModelList[CUST_ModelList.length - 1] ;
                                                  // print ('Cust_Model!.NAME');
                                                  // print (Cust_Model!.NAME);
                                                  Cache.play('m.mp3',mode: PlayerMode.LOW_LATENCY) ;
                                                  NavigatorAndFinish(context , Customer_Stock());
                                                }

                                              namecontroller.text = '';
                                              Citycontroller.text = '';
                                              notes.text = '';
                                              phone_1controller.text = '';
                                              maxIndebtedness.text = '';
                                              Regioncontroller.text = '';
                                              money.text = '';
                                              phone_2controller.text = '';
                                              phone_3controller.text = '';
                                              phone_4controller.text = '';
                                                Address.text = '';
                                              }
                                            });

                                          } else {
                                            openmessageNull(context);
                                          }
                                        }),
                                  ),
                                ),

                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //  ),
        );
      },
      listener: (context, state) {},
    );
  }

  Future openmessageNull(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(
              'لم يتم اضافه العميل , من فضلك تأكد من ادخال الاسم و رقم الهاتف 1',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.redAccent),
            ),
          ));


  Future openCITY(context) => showDialog(
      context: context,
      builder: (context) {
        var cubit = posCubit.get(context);
        return AlertDialog(
          alignment: Alignment.centerRight,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: SearchCitycontroller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.zero,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          cubit.Search_CITY(Name: '');
                        });
                      },
                      onChanged: (v) {
                        setState(() {
                          cubit.Search_CITY(Name: v);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                Citycontroller.text = cubit
                                    .Search_CITY_REGIONList[index].CITY_NAME
                                    .toString();
                                CityId= cubit
                                    .Search_CITY_REGIONList[index].CITY_ID ;
                                if(CUST_ModelEdit != null ){CUST_ModelEdit!.CityRegionName ='' ; }
                                Get_REGIONS(
                                    ID: cubit
                                        .Search_CITY_REGIONList[index].CITY_ID);
                                SearchCitycontroller.text = '';
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              cubit.Search_CITY_REGIONList[index].CITY_NAME
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * .2,
                              color: defultcolor,
                            ),
                          ),
                      itemCount: cubit.Search_CITY_REGIONList.length)
                ],
              ),
            ),
          ),
        );
      });

  Future openRegion(context, cubit) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            alignment: Alignment.centerRight,
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width * .3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      // child: TextFormField(
                      //   controller: SearchRegioncontroller,textAlign: TextAlign.center,
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsetsDirectional.zero,
                      //     prefixIcon:Icon(Icons.search)  ,
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),),
                      //   ),
                      //   onTap: (){
                      //     setState(() {
                      //       cubit.Search_CITY(Name: '');
                      //     });
                      //
                      //   },
                      //   onChanged: (v){
                      //     setState(() {
                      //       cubit.Search_CITY(Name: v);
                      //     });
                      //
                      //   },
                      // ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  Regioncontroller.text =
                                      REGIONList[index].CITY_REGION_NAME.toString();
                                  print(Regioncontroller.text);
                                  if(CUST_ModelEdit != null){CUST_ModelEdit!.CityRegionName = Regioncontroller.text ;}
                                  RegionId= REGIONList[index].RegionId ;
                                  SearchRegioncontroller.text = '';
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                REGIONList[index].CITY_REGION_NAME.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * .2,
                                color: defultcolor,
                              ),
                            ),
                        itemCount: REGIONList.length)
                  ],
                ),
              ),
            ),
          ));
}

Future openmessageEditSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'تم تعديل العميل بنجاح',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ));

Future openmessageEXistNameSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'الاسم موجود سابقا قم بتعديل الاسم',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent),
      ),
    ));

Future openmessageEXistPhoneSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'رقم الهاتف 1 موجود سابقا قم بتعديله',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.redAccent),
      ),
    ));
Future openmessageCustSuccess(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        'تم اضافة العميل بنجاح',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ));

//ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: DatabaseException(UNIQUE constraint failed: