import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> baseDio() async{

  SharedPreferences pref  = await SharedPreferences.getInstance();
  String userJwtToken = await pref.get(kUserJwtTokenPrefKey);
  return new Dio(BaseOptions(
      baseUrl: kBaseApiUrl,
      headers:(userJwtToken != null)? {
        HttpHeaders.authorizationHeader: 'bearer $userJwtToken' , // set content-length
      } : null,
    ));
}

handleError({@required dynamic error, @required String message}){

    String exceptionMessage = 'Error occured';
    if(error is DioError){
        if(error.response != null && error.response.data['message'] != null){
          exceptionMessage = error.response.data['message'];
        }else if(error.response != null){
          exceptionMessage = 'Error occured in server while $message';
        }else{
          exceptionMessage = 'Error connecting to server';
        }
    }else{
      exceptionMessage = 'An unknown occured while $message';
    }
    throw Exception(exceptionMessage);
}