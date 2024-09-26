import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_car/manual_mode.dart';
import 'controller/smart_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SmartController smartController = SmartController();
  Color shieldIconColor = const Color(0xFF0078FD);

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
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'GOGOBOT',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Card untuk Mode Avoider
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Avoider Mode',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.shieldCat,
                          size: 55,
                          color: shieldIconColor,
                        ),
                        const SizedBox(width: 10),
                        // Switch Mode Avoider
                        LiteRollingSwitch(
                          value: false,
                          textOn: 'ON',
                          textOnColor: Colors.white,
                          textOff: 'OFF',
                          textOffColor: Colors.white,
                          colorOn: const Color(0xFF0078FD),
                          colorOff: const Color(0xFF3A3A3A),
                          iconOn: FontAwesomeIcons.check,
                          iconOff: FontAwesomeIcons.xmark,
                          textSize: 16.0,
                          onChanged: (bool position) async {
                            setState(() {
                              shieldIconColor = position
                                  ? Colors.white
                                  : const Color(0xFF0078FD);
                            });
                            bool success = await smartController.modeAvoider(
                                context, position);
                            if (success) {
                              showSnackBar('Mode ${position ? 'ON' : 'OFF'}');
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
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Card untuk Mode Manual
              GestureDetector(
                onTap: () {
                  Get.to(() => const ManualMode());
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.gamepad,
                        color: Color(0xFF0078FD),
                        size: 55,
                      ),
                      SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manual Mode',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Control your bot manually',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Footer
              const Text(
                'Created by Ardhika',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
