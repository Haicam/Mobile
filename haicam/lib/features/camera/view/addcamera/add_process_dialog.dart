
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/features/camera/view/addcamera/qr_code_info_screen.dart';

import '../../../../core/utils/common_widget_utils.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';

class AddProcessDialog extends StatefulWidget {

  AddProcessDialog(){}

  @override
  _AddProcessDialogState createState() =>
      _AddProcessDialogState();
}

class _AddProcessDialogState extends State<AddProcessDialog> {

  _AddProcessDialogState(){}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement b
    return Container(
      //color: Colors.white,
      width: double.infinity,
      child: setUpViewPage(),
    );
  }

  Widget setUpViewPage() {
    return Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          shrinkWrap: true,
          children: getDataFields(),
        ));
  }

  List<Widget> getDataFields(){
    List<Widget> list = [];
    list.add(CommonWidgetUtils.getLabel(getTranslated(context, LocalString.add_camera_alert_message)!, 14, FontWeight.w400, AppColors.black));

    list.add(SizedBox(height: 20,));
    list.add(CommonWidgetUtils.getSeparator2(AppColors.black, 1));
    list.add(Row(children: [
      Expanded(child: getAppUpdateButton()),
    ],));

    return list;
  }

  Widget getAppUpdateButton(){
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new QrCodeInfoScreen()));

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          getTranslated(context, LocalString.ok)!,
          style: TextStyle(fontSize:14,fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}


