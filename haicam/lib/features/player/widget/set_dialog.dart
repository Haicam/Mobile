import 'package:flutter/material.dart';

class ShowTimelapseBox extends StatefulWidget {
  final String? title, descriptions, text;
  final Image? img;

  const ShowTimelapseBox(
      {Key? key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _ShowTimelapseBoxState createState() => _ShowTimelapseBoxState();
}

class _ShowTimelapseBoxState extends State<ShowTimelapseBox> {
  static const double peddingValue = 20;
  bool selectedOneMinute = false;
  bool selectedThirtySecond = false;
  bool selectedtenSecond = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(peddingValue),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(peddingValue),
          margin: const EdgeInsets.only(top: peddingValue),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(peddingValue),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Timelapse',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          selectedOneMinute
                              ? Icons.circle_sharp
                              : Icons.circle_outlined,
                        ),
                        color: Colors.grey,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            selectedOneMinute = !selectedOneMinute;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pop(context, false);
                          });
                        },
                      ),
                      const Text('1 minute')
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          selectedThirtySecond
                              ? Icons.circle_sharp
                              : Icons.circle_outlined,
                        ),
                        color: Colors.grey,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            selectedThirtySecond = !selectedThirtySecond;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pop(context, false);
                          });
                        },
                      ),
                      const Text('30 second')
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          selectedtenSecond
                              ? Icons.circle_sharp
                              : Icons.circle_outlined,
                        ),
                        color: Colors.grey,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            selectedtenSecond = !selectedtenSecond;
                          });
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pop(context, false);
                          });
                        },
                      ),
                      const Text('10 second')
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
