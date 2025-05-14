import 'dart:io';

import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_controller.dart';
import 'package:skinscanning/src/page/ScanUrSkin/widget/live_camera_widget.dart';



class ScanurskinView extends StatefulWidget {
  const ScanurskinView({super.key});

  @override
  State<ScanurskinView> createState() => _ScanurskinViewState();
}

class _ScanurskinViewState extends State<ScanurskinView> {

  late final ScanurskinController controller;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ScanurskinController>()) {
      controller = Get.put(ScanurskinController());
    }
  }

  @override
  void dispose() {
    Get.delete<ScanurskinController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.onTapGestureDetector(context);
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  LiveCameraWidget(),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: controller.takePicture,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.image),
                      ),
                    )
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black,
                    width: 1
                  ),
                  boxShadow: [
                    const BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 0
                    ),
                    const BoxShadow(
                        color: Colors.white,
                        blurRadius: 10,
                        spreadRadius: 5
                    ),
                  ],
                ),
                child: Center(
                  child: Text('Info Penyakit...', style: TextStyle(color: Colors.grey, fontSize: 15),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Colors.black,
                              width: 1
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      controller.onTapHistory();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 1
                        )
                      ),
                    ),
                    child: Icon(Icons.history, color: Colors.black, size: 20,)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
