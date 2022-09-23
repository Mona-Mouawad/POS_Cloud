import 'package:pos/models/CITYModel.dart';
import 'package:pos/models/CITY_REGION_Model.dart';


List<CITYModel> MobPosCityList = [];

getMobPosCity(database)async{
  MobPosCityList = [];
  database.rawQuery('SELECT * FROM MobPosCity').then((value) {
    value.forEach((element) {
      CITYModel Cmodel =CITYModel.fromJson(element);
      MobPosCityList.add(Cmodel);

    });

    print(MobPosCityList);
    print('iiiiii  ii ' + MobPosCityList.length.toString());
    // emit(C_getdatabase());
  });
}


List<CITY_REGION_Model> MobPosCity_REGIONList = [];

getMobPosCity_REGION(database)async{
  MobPosCity_REGIONList = [];
  database.rawQuery('SELECT * FROM MobPosCityRegion').then((value) {
    value.forEach((element) {
      CITY_REGION_Model CRmodel =CITY_REGION_Model.fromJson(element);
      MobPosCity_REGIONList.add(CRmodel);
    });
    print('iiiiii  ii ' + MobPosCity_REGIONList.length.toString());
    // emit(C_getdatabase());
  });
}


List<CITY_REGION_Model> REGIONList = [];
Get_REGIONS({ ID = 0})
{
  REGIONList = [];
  if(ID != 0)
  {
    MobPosCity_REGIONList.forEach((element) {
      if (element.CITY_ID == ID) {
        REGIONList.add(element);

        print(element.CITY_REGION_NAME);


      }
    });
  }
}

Search_REGIONS({ Name= ''}) {
  REGIONList = [];

  {
    REGIONList.forEach((element) {
      // if (element['CityId'] == Name) {
      //   REGIONList.add(element['CITY_REGION_NAME']);
     // }
    });
  }
}