import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'controller/smart_controller.dart';

class ManualMode extends StatefulWidget {
  const ManualMode({super.key});

  @override
  _ManualModeState createState() => _ManualModeState();
}

class _ManualModeState extends State<ManualMode> {
  final SmartController smartController = SmartController();
  bool isManualModeOn = false;

  void showSnackBar(String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2A),
      appBar: AppBar(
        title: const Text(
          'Manual Mode',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF252638),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Control your robot manually',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            LiteRollingSwitch(
              value: isManualModeOn,
              textOn: 'ON',
              textOnColor: Colors.white,
              textOff: 'OFF',
              textOffColor: Colors.white,
              colorOn: const Color(0xFF3666E6),
              colorOff: const Color(0xFF252638),
              iconOn: FontAwesomeIcons.check,
              iconOff: FontAwesomeIcons.xmark,
              onChanged: (bool position) async {
                bool success = await smartController.toggleManualMode(position);
                if (success) {
                  showSnackBar('Manual Mode ${position ? 'ON' : 'OFF'}');
                }
              },
              onTap: () {
                showSnackBar('Switch tapped!');
              },
              onDoubleTap: () {
                showSnackBar('Switch double tapped!');
              },
              onSwipe: () {
                showSnackBar('Switch swiped!');
              },
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252638),
                    borderRadius: BorderRadius.circular(150),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Joystick(
                    mode: JoystickMode.all,
                    listener: (details) {
                      if (isManualModeOn) {
                        smartController.handleJoystick(details);
                      }
                    },
                    base: JoystickBase(
                      decoration: JoystickBaseDecoration(
                        color: const Color(0xFF252638),
                        drawOuterCircle: false,
                      ),
                      arrowsDecoration: JoystickArrowsDecoration(
                        color: const Color(0xFF3666E6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Use the joystick to move the robot',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
