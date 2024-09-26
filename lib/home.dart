import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_car/manual_mode.dart';
import 'controller/smart_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final SmartController smartController = SmartController();

    void showSnackBar(String message) {
      AnimatedSnackBar.material(
        message,
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        duration: const Duration(seconds: 2),
      ).show(context);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2A),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF252638),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 65,
                          height: 65,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'GOGOBOT - SMART BOT',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 25),
              //         padding: const EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //         child: const Column(
              //           children: [
              //             SizedBox(height: 5),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Center(
              //                   child: Icon(
              //                     FontAwesomeIcons.circleCheck,
              //                     color: Color(0xFF03E2AC),
              //                     size: 25,
              //                   ),
              //                 ),
              //                 SizedBox(width: 5),
              //                 Text(
              //                   'IYA',
              //                   style: TextStyle(
              //                     fontSize: 25,
              //                     color: Color(0xFF00303C),
              //                     fontWeight: FontWeight.w900,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(right: 25),
              //         padding: const EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //         child: const Column(
              //           children: [
              //             SizedBox(height: 5),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Center(
              //                   child: Icon(
              //                     FontAwesomeIcons.circleXmark,
              //                     color: Color(0xFF03E2AC),
              //                     size: 25,
              //                   ),
              //                 ),
              //                 SizedBox(width: 5),
              //                 Text(
              //                   'TIDAK',
              //                   style: TextStyle(
              //                     fontSize: 25,
              //                     color: Color(0xFF00303C),
              //                     fontWeight: FontWeight.w900,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF252638),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    const Text(
                      'MODE AVOIDER',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Icon(
                            FontAwesomeIcons.shieldCat,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        LiteRollingSwitch(
                          value: false,
                          textOn: 'ON',
                          textOnColor: Colors.white,
                          textOff: 'OFF',
                          textOffColor: Colors.white,
                          colorOn: const Color(0xFF0078FD),
                          colorOff: const Color(0xFF171719),
                          iconOn: FontAwesomeIcons.check,
                          iconOff: FontAwesomeIcons.xmark,
                          textSize: 18.0,
                          onChanged: (bool position) async {
                            bool success = await smartController.modeAvoider(context, position);
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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ManualMode());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252638),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              FontAwesomeIcons.gamepad,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MODE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'MANUAL',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
