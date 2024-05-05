import 'dart:async';
import 'package:flutter/material.dart';
import 'package:background_slider_flutter
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomThumbShape.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({Key? key}) : super(key: key);

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volumeValue = 0.0; // initial value
  String _mood = 'Fine';

  var counter = 0;

  List<Color> colorsList = [
    const Color(0xFF006E7F),
    const Color(0xFFF8CB2E),
    const Color(0xFFEE5007),
    const Color(0xFFB22727),
  ];

  List<Alignment> alignmentsList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  _startBgColorAnimationTimer() {
    ///Animating for the first time.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counter++;
      setState(() {});
    });

    const interval = Duration(seconds: 3);
    Timer.periodic(
      interval,
      (Timer timer) {
        counter++;
        setState(() {});
      },
    );
  }

  _updateColors() {
    // Calculate the new colors based on the value of _volumeValue
    if (_mood == "Fine") {
      colorsList = [
        const Color(0xFF70B030),
        const Color(0xFF70B030),
        const Color(0xFFF7DC6F),
        Colors.blueAccent,
      ];
    } else if (_mood == "Sad") {
      colorsList = [
        const Color(0xff0a2675),
        const Color(0xff0a2675),
        Colors.blue,
        Colors.indigo,
        Colors.indigo,
      ];
    } else if (_mood == "Angry") {
      colorsList = [
        const Color(0xFFFC564F),
        Colors.pinkAccent.shade700,
        const Color(0xFFFC566F),
      ];
    }
  }

  _updateMood() {
    // Update the mood based on the value of _volumeValue
    if (_volumeValue < 0.33) {
      _mood = "Fine";
    } else if (_volumeValue < 0.66) {
      _mood = "Sad";
    } else {
      _mood = "Angry";
    }
  }

  Color _getThumbColorByValue() {
    if (_volumeValue < 0.33) {
      return Colors.green;
    } else if (_volumeValue < 0.66) {
      return Colors.indigo;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  void initState() {
    super.initState();
    _startBgColorAnimationTimer();
  }

  @override
  Widget build(BuildContext context) {
    _updateColors();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: alignmentsList[counter % alignmentsList.length],
                end: alignmentsList[(counter + 2) % alignmentsList.length],
                colors: colorsList,
                tileMode: TileMode.clamp,
              ),
            ),
            duration: const Duration(seconds: 2),
            child: Padding(
              padding: const EdgeInsets.only(top: 75, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How are you\nfeeling today?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 175.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _mood,
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Align(
                    alignment: Alignment.center,
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: CustomThumbShape(
                          thumbRadius: 20,
                          thumbHeight: 2.5,
                          thumbColor: _getThumbColorByValue(),
                          borderColor: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _volumeValue,
                        min: 0,
                        max: 1.0,
                        inactiveColor: Colors.white,
                        onChanged: (newValue) {
                          setState(() {
                            _volumeValue = newValue;
                            _updateMood();
                            _updateColors();
                          });
                        },
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SizedBox(
                height: 55.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XFFFFFFFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        letterSpacing: 0,
                        color: _getThumbColorByValue(),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}