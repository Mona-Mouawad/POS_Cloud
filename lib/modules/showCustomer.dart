import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/cubit/cubit.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/CUST_VEN_Model.dart';
import 'package:pos/modules/clien.dart';
import 'package:pos/modules/registerscreen.dart';
import 'package:pos/shared/component.dart';
import 'package:pos/shared/style/colors.dart';

import '../DataBase/DataBase.dart';

class showCustomer extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();
  Color? colors;

  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<posCubit, posStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = posCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    NavigatorAndFinish(context, clienScreen());
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              title: Text(
                "عرض العملاء",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defultTextField(
                    context: context,
                    controller: searchcontroller,
                    hintText: 'اسم العميل - الهاتف المحمول ',
                    hintcolor: Colors.grey,
                    prefix: Icons.search,
                    Texttcolor: defultcolor,
                    ontap: () {
                      cubit.Search_CUST(CUSTNAME: searchcontroller.text);
                    },
                    onchange: (v) {
                      cubit.Search_CUST(CUSTNAME: v);
                    },
                    onsubmit: (v) {
                      cubit.Search_CUST(CUSTNAME: v);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: bar,
                  height: 50,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Spacer(),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'بيانات العميل',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'رقم الهاتف',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                BuildCondition(
                  condition: cubit.CUST_ModelListSearch.length > 0,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          colors = list;
                        } else {
                          colors = list2;
                        }
                        return Users(
                            colors, context, cubit.CUST_ModelListSearch[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: cubit.CUST_ModelListSearch.length,
                    ),
                  ),
                  fallback: (context) => Expanded(child: Center()),
                )
              ],
            ),
          );
        });
  }
}

Widget Users(colors, context, CUST_VEN_Model CUST_Model)  {
  if(CUST_Model.CityId != null ) {
    database
        .rawQuery(
        'SELECT CityName FROM MobPosCity WHERE CityId =${CUST_Model.CityId}')
        .then((v) {
      print(v);
      CUST_Model.CityName = v[0]['CityName'] as String;
    });
  }
  if (CUST_Model.RegionId != null )  {
    database
        .rawQuery(
        'SELECT CityRegionName FROM MobPosCityRegion  WHERE CityRegionId =${CUST_Model.RegionId}')
        .then((v) {
      print(v);
      CUST_Model.CityRegionName = v[0]['CityRegionName'] as String;
    });
  }
  return Container(
    height: 122,
    color: colors,
    child: InkWell(
      onTap: () {
        if (CUST_Model.status == 'new') {
          NavigatorTo(context, register_screen(CUST_ModelEdit: CUST_Model));
        }
      },
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: 15,
          ),
          if (CUST_Model.status == 'new') Icon(Icons.edit, size: 18),
          SizedBox(
            width: 11,
          ),

          Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${CUST_Model.NAME}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: defultblack,
                      height: 1.1,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                if (CUST_Model.CityName != null)
                  Text(
                    '${CUST_Model.CityName}',
                    maxLines: 2,
                    style: TextStyle(
                        color: defultblack,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 5),
                if (CUST_Model.CityRegionName != null)
                  Text(
                    '${CUST_Model.CityRegionName}',
                    maxLines: 2,
                    style: TextStyle(
                        color: defultblack,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 5),
                if (CUST_Model.Address != null)
                  Container(width: MediaQuery.of(context).size.width *.38,
                    child: Text(
                      '${CUST_Model.Address}',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: defultblack,
                          height: 1.1,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: 11,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (CUST_Model.Phone1 != '' && CUST_Model.Phone1 != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                    child: Text(
                      '${CUST_Model.Phone1}',
                      style: TextStyle(
                          color: defultblack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 8),
              if (CUST_Model.Phone2 != '' && CUST_Model.Phone2 != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                    child: Text(
                      '${CUST_Model.Phone2}',
                      style: TextStyle(
                          color: defultblack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 8),
              if (CUST_Model.Phone3 != '' && CUST_Model.Phone3 != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                    child: Text(
                      '${CUST_Model.Phone3}',
                      style: TextStyle(
                          color: defultblack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 8),
              if (CUST_Model.Phone4 != '' && CUST_Model.Phone4 != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                    child: Text(
                      '${CUST_Model.Phone4}',
                      style: TextStyle(
                          color: defultblack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          Spacer(),
          SizedBox(
            width: 11,
          ),
//  SizedBox(width: 15,),
        ],
      ),
    ),
  ) ;
}
