import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/shared/Content.dart';
import 'package:pos/shared/helper/cach_Helper.dart';
import '../Api/Timer.dart';
import '../Api/get.dart';
import '../modules/Get_Post_Data_Screen.dart';

class Logincubit extends Cubit<posStates>{

  Logincubit() : super(posinitialState());
  static Logincubit get(context)=>BlocProvider.of(context);
  

 IconData icon=Icons.visibility_outlined;
 bool ispassword =true;
  
  void changeVisibilty()
  {
    ispassword=!ispassword;
    icon=ispassword ? Icons.visibility_outlined  :  Icons.visibility_off_outlined;
    emit(ChangeVisibilityloginstate());
  }

  bool checkRemberme = false;
  void changeRembermeCheck() {
    checkRemberme = !checkRemberme;
    emit(ChangeCheckRembermeButtonstate());
  }



bool  login = false ;
  Search_USER({ Name , password}) {
    login= false ;
    emit(Loadingloginstate());
    POS_USER_ModelList.forEach((element) async {
      if (element.UserName== Name &&  element.Password== password ) {
        Cach_helper.SaveData(key: 'UserId', value:  element.UserId);
        // if(checkRemberme)
        // {
          Cach_helper.SaveData(key: 'USER_NAME', value: Name);
          USER_NAME =Cach_helper.GetData(key: 'USER_NAME');
       // }
        UserId =Cach_helper.GetData(key: 'UserId') ;
        login= true ;
        emit(Successloginstate());
        await  getStockdata(LeId: LE_ID! ,UserId: UserId!);
        await  getTreasurydata(LeId: LE_ID! ,UserId: UserId! );
        }
      });

    emit(Errorloginstate());
  }


  bool  Load = false ;
  GetDataFrist({ required LeId ,required context ,required name }) async {
    emit(LoadingGetDataFriststate());
    await  CheckConnection();
    Cach_helper.SaveData(key: 'S_D', value: true);
    Load= false ;
   // final  isConnected =await InternetConnectionChecker().connectionStatus;
    if(ConnectionStatus) {
      try {
        Cach_helper.SaveData(key: 'LeName', value:  name);
        Cach_helper.SaveData(key: 'LeId', value : LeId );
        LE_ID = Cach_helper.GetData(key: 'LeId');
        await getUserdata(LeId: LeId) ;
        await getInvUomdata(LeId: LeId) ;
        await  getCitydata(LeId: LeId!);
        await  getCityRegionedata(LeId: LeId! );
        await getItemdata(LeId: LeId) ;
        await  getGroupItemdata(LeId: LeId );
        await  getCustVendata(LeId: LeId );
        await  getExpensedata(LeId: LeId );
        await  getPaymentMethoddata(LeId: LeId );
        Future.delayed(Duration(seconds: 7), () {
        Load = true;
         emit(SuccessGetDataFriststate());
       });

     //  emit(SuccessGetDataFriststate());
      }
      catch (error) {
        openmessageNullNetwork(context);
      }
  //    emit(SuccessGetDataFriststate());
    }

else{ openmessageNullNetwork(context);}
    await  GetFromAPI_Timer(LeId:LE_ID );
  Future.delayed(Duration(minutes: 15),(){PostToAPI_Timer();});
  }

}