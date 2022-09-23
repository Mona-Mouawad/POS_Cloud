import 'package:dio/dio.dart';

class Dio_Helper
{
  static var dio=Dio();
  static init()
  {
    dio= Dio(BaseOptions(
    baseUrl:'http://185.219.134.68:7008/REST/rest',
    receiveDataWhenStatusError: true));

  }
  static Future <Response>getData({
    required String url,
  })async
  {
    dio.options.headers={
      'Content-Type':'application/vnd.oracle.adf.resourceitem+json',

    };

    return await dio.get(url);
  }

   static Future <Response>PostData({
    required String url,
     Map<String,dynamic>? query,
     required Map<String,dynamic> data,
  })async
  {
    dio.options.headers={
      'Content-Type':'application/vnd.oracle.adf.resourceitem+json',
  //    'Content-Type':'application/x-www-form-urlencoded',
    };
    return await dio.post(
      url,queryParameters: query,
      data: data);
  }


  static Future <Response>PutData({
    required String url,
   ///  Map<String,dynamic>? query,
     required Map<String,dynamic> data,
   // String lang='ar',
   //  String? token,
  })async
  {

    dio.options.headers={
     // 'Content-Type':'application/json',
      'Content-Type':'application/vnd.oracle.adf.resourceitem+json',
    };

    return await dio.put(
      url,data: data);
  }

}