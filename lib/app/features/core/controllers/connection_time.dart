

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../../core/local/storage.dart';
import '../../../../core/utils/app_constant.dart';

class ConnectionTime {
  static final ConnectionTime instance = ConnectionTime._internal();

  ConnectionTime._internal();
  bool _inLoad=false;
  Timer? timer;
  Future< void > connectTime()async {
    _connectTime(true);
    timer??=Timer.periodic(Duration(seconds: 60), (time)=>_connectTime(true));
    SystemChannels.lifecycle.setMessageHandler((message){

      log('state channels: $message');
      if(message.toString().contains('resume')) {
        _connectTime(true,isRequired: true);
        if(!(timer?.isActive??false)){
          timer=Timer.periodic(Duration(seconds: 60), (time)=>_connectTime(true));
        }
      }
      if(message.toString().contains('pause')) {
        _connectTime(false,isRequired: true);
        timer?.cancel();
      }
      return Future.value(message);
    });

    // Timer timer=Timer.periodic(Duration(seconds: 1), (time)=>_connectTime(true));


    /// To cancel time
    // TimerConfiguration.addTimer(timer);

  }

  Future< void > _connectTime(bool isOnline,{bool isRequired=false}) async {

    if((await AppStorage.storageRead(key: AppConstants.uidKEY))==null){
      // log("connection Duration $isOnline ${DateTime.now()}");
      Future.delayed(Duration(seconds: 10),()=> _connectTime(isOnline,isRequired: isRequired));
    }

    else if((!_inLoad||isRequired)){

      // log("connection $isOnline ${DateTime.now()}");
      _inLoad=true;
      try{
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc('${(await AppStorage.storageRead(key: AppConstants.uidKEY))}')
            .set({
          'last_seen':Timestamp.now(),
          'status':isOnline?'online':'offline'
        }).timeout(Duration(seconds: 10));
      }catch(e){
        if(!isOnline)
        _connectTime(isOnline,isRequired:isRequired );
        // log('connection time error ${e}');
      }
      _inLoad=false;
    }
  }
}