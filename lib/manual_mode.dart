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
  // ignore: library_private_types_in_public_api
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
      backgroundColor: const Color(0xFF171719),
      appBar: AppBar(
        title: const Text('Manual Mode',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF171719),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          LiteRollingSwitch(
            value: false,
            textOn: 'ON',
            textOnColor: Colors.white,
            textOff: 'OFF',
            textOffColor: Colors.white,
            colorOn: const Color(0xFF3666E6),
            colorOff: const Color(0xFF23222A),
            iconOn: Icons.check,
            iconOff: Icons.close,
            onChanged: (bool position) async {
              bool success = await smartController.toggleManualMode(position);
              if (success) {
                setState(() {
                  isManualModeOn = position;
                });
              } else {
                print('Failed to toggle manual mode');
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
              child: Joystick(
                mode: JoystickMode.all,
                listener: (details) {
                  if (isManualModeOn) {
                    smartController.handleJoystick(details);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
