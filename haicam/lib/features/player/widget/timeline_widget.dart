import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/player/widget/line_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class cardTimeline extends StatelessWidget {
  const cardTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // color: Colors.lightBlue,
          child: Column(
            children: const [
              Text(
                '02.00 PM',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              LineGen(
                lines: [10.0, 5.0, 5.0, 5.0],
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            ClipOval(
              child: Material(
                color: Colors.green, // Button color
                child: InkWell(
                  splashColor: Colors.red, // Splash color
                  onTap: () {},
                  child: const SizedBox(
                    width: 10,
                    height: 10,
                    // child: Icon(Icons.circle),
                  ),
                ),
              ),
            ),
            addHeight(10.0),
            ClipOval(
              child: Material(
                color: Colors.green, // Button color
                child: InkWell(
                  splashColor: Colors.green, // Splash color
                  onTap: () {},
                  child: const SizedBox(
                    width: 10,
                    height: 10,
                    // child: Icon(Icons.circle),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            Row(
              children: [
                ClipPath(
                  clipper: ArrowClipper(10, 0, Edge.LEFT),
                  child: Container(
                    height: 20,
                    color: Colors.green,
                    child: const Center(
                        child: Text(
                      "A",
                      style: TextStyle(color: Colors.green),
                    )),
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 150.0,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(40.0),
                        //   topRight: Radius.circular(40.0),
                        // ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image:
                              ExactAssetImage('assets/images/cam_pic_01.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: const Center(
                          // child: Text("test"),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
