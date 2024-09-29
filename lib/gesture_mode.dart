import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'controller/smart_controller.dart';

class GestureModePage extends StatefulWidget {
  const GestureModePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GestureModePageState createState() => _GestureModePageState();
}

class _GestureModePageState extends State<GestureModePage> {
  String direction = 'Berhenti';
  bool isControlEnabled = false;
  final SmartController smartController = SmartController();

  void showSnackBar(String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  void _onVerticalDrag(DragUpdateDetails details) {
    if (!isControlEnabled) return;

    if (details.delta.dy < -3) {
      setState(() {
        direction = 'Maju';
      });
      smartController.sendGestureCommand("forward");
    } else if (details.delta.dy > 3) {
      setState(() {
        direction = 'Mundur';
      });
      smartController.sendGestureCommand("backward");
    }
  }

  void _onHorizontalDrag(DragUpdateDetails details) {
    if (!isControlEnabled) return;

    if (details.delta.dx < -3) {
      setState(() {
        direction = 'Kiri';
      });
      smartController.sendGestureCommand("left");
    } else if (details.delta.dx > 3) {
      setState(() {
        direction = 'Kanan';
      });
      smartController.sendGestureCommand("right");
    }
  }

  void _onGestureEnd(DragEndDetails details) {
    if (!isControlEnabled) return;
    setState(() {
      direction = 'Berhenti';
    });
    smartController.sendGestureCommand("stop");
    showSnackBar("Robot Stopped");
  }

  void _onDoubleTap() {
    if (!isControlEnabled) return;
    setState(() {
      direction = 'Berhenti';
    });
    smartController.sendGestureCommand("stop");
    showSnackBar("Robot Stopped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Gesture Control Mode',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDrag,
        onHorizontalDragUpdate: _onHorizontalDrag,
        onVerticalDragEnd: _onGestureEnd,
        onHorizontalDragEnd: _onGestureEnd,
        onDoubleTap: _onDoubleTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: LiteRollingSwitch(
                value: false,
                textOn: 'ON',
                textOnColor: Colors.white,
                textOff: 'OFF',
                textOffColor: Colors.white,
                colorOn: const Color(0xFF0078FD),
                colorOff: const Color(0xFF252638),
                iconOn: FontAwesomeIcons.check,
                iconOff: FontAwesomeIcons.xmark,
                onChanged: (bool state) {
                  setState(() {
                    isControlEnabled = state;
                  });
                  if (state) {
                    smartController.toggleGestureMode(true);
                    showSnackBar('Gesture mode aktif!');
                  } else {
                    smartController.toggleGestureMode(false);
                    showSnackBar('Gesture mode non-aktif!');
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
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: FaIcon(
                  direction == 'Maju'
                      ? FontAwesomeIcons.arrowUp
                      : direction == 'Mundur'
                          ? FontAwesomeIcons.arrowDown
                          : direction == 'Kanan'
                              ? FontAwesomeIcons.arrowRight
                              : direction == 'Kiri'
                                  ? FontAwesomeIcons.arrowLeft
                                  : FontAwesomeIcons.xmark,
                  size: 150,
                  color: const Color(0xFF0078FD),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              direction,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
