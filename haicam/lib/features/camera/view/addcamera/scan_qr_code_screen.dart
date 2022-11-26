import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prac_haicam/features/camera/view/addcamera/preparation_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../core/utils/utils.dart';
import '../../../../localization/language_constants.dart';

class ScanQrCodeScreen extends StatefulWidget {

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {

  final TextEditingController _didEditingController = TextEditingController();
  String didError = "";

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerEventListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(),
          centerTitle: true,
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.add_camera)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
    );
  }

// Build main view
  Widget _buildMainMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _buildQrView(context)),
        Padding(padding: EdgeInsets.only(left: 10, right: 10),
          child: getDidField(),),
        Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.qr_code_info)!, 15,
              FontWeight.w500, AppColors.black),),

        Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
          child: getBottomBar(),)
        /*Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                else
                  const Text('Scan a code'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Text('Flash: ${snapshot.data}');
                            },
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                    'Camera facing ${describeEnum(snapshot.data!)}');
                              } else {
                                return const Text('loading');
                              }
                            },
                          )),
                    )
                  ],
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.pauseCamera();
                        },
                        child: const Text('pause',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: const Text('resume',
                            style: TextStyle(fontSize: 20)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )*/
      ],
    );
  }

  Widget getDidField() {
    return Row(
      children: [
        
        CommonWidgetUtils.getLabel(getTranslated(context, LocalString.did_id)!, 15, FontWeight.w500, AppColors.black),
        SizedBox(width: 10,),
        Expanded(child: addTextView(_didEditingController,
            didError))
      ],
    );
  }

  Widget addTextView(TextEditingController editingController,
      String error) {

    List<Widget> list = [];

    list.add(Padding(
      padding: new EdgeInsets.only(top: 10),
      child: getTextField(editingController),
    ));
    list.add(getErrorLabel(error));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }


  Widget getErrorLabel(String errorMsg) {
    if(!Utils.isEmpty(errorMsg)){
      return new Padding(
        padding: new EdgeInsets.only(top: 5, left: 5),
        child: CommonWidgetUtils.getLabel(errorMsg,
            11, FontWeight.w500, Colors.red),
      );
    }
    return Container();
  }

  Widget getTextField(TextEditingController editingController) {
    TextInputType textInputType = TextInputType.text;
    int maxlines = 1;


    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(10),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black.withAlpha(10)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10,),
        child: SizedBox(
          height: 40,
          child: TextField(
              controller: editingController,
              keyboardType: textInputType,
              maxLines: maxlines,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border:InputBorder.none,
              )
          ),
        ));
  }


  Widget getBottomBar(){
    return Row(
      children: [
        Expanded(child: Container(),),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              //background color of button
              side: const BorderSide(
                width: 1,
                color: AppColors.primary,
              ),
              //border width and color
              elevation: 3,
              //elevation of button
              shape: RoundedRectangleBorder(
                //to set border radius to button
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(10) //content padding inside button
          ),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new PreparationScreen()));
          },
          child: Text(
            getTranslated(context, LocalString.next)!,
            style: const TextStyle(fontSize: AppFonts.buttonTextSize),
          ),
        ),
        Expanded(child: Container(),),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  /**
   * Broadcaste event listener
   */

  StreamSubscription? receiver;

  @override
  void dispose() {
    controller?.dispose();
    unRegisterEventListener();
    super.dispose();
  }

  void registerEventListener() {

    receiver = Constants.eventBus!.on().listen((event) {
      print("home::event.toString() = " + event.toString());
      // Print the runtime type. Such a set up could be used for logging.
      if (event.toString().indexOf(Constants.CAMERA_SETUP_FINISHED_BROADCASTE_RECEIVER_ACTION) >=0) {
        Navigator.pop(context);
      }
    });
  }

  void unRegisterEventListener() {
    try {
      if (receiver != null) {
        receiver!.cancel();
      }
    } catch (myemailError) {}
  }
}

