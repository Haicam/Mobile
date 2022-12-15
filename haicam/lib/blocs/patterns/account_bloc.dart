import 'dart:async';

import 'package:prac_haicam/blocs/models/account.dart';
import 'package:prac_haicam/blocs/models/camera.dart';

enum AccountAction { GetData}

class AccountBloc {

  Account? _account = null;

  final _stateStreamController = StreamController<Account>();
  StreamSink<Account> get _accountSink => _stateStreamController.sink;
  Stream<Account> get accountStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<AccountAction>();
  StreamSink<AccountAction> get eventSink => _eventStreamController.sink;
  Stream<AccountAction> get _eventStream => _eventStreamController.stream;

  AccountBloc(){

    _eventStream.listen((event) {
      if(event == AccountAction.GetData){
        _account = Account();
        _account!.cameras = getMockupList();
        _accountSink.add(_account!);
      }
    });
  }

  List<Camera> getMockupList(){

    List<Camera> dataList = [];

    Camera pi = Camera();
    pi.name = "Doorbell";
    pi.lastImage = "cam_pic_01.png";
    pi.videoSize = "1920:1080";
    dataList.add(pi);

    pi = Camera();
    pi.name = "Garden";
    pi.lastImage = "cam_pic_02.png";
    pi.videoSize = "1920:1080";
    dataList.add(pi);

    pi = Camera();
    pi.name = "Gate-02";
    pi.lastImage = "cam_pic_03.png";
    pi.videoSize = "1920:1080";
    dataList.add(pi);

    return dataList;

  }

}