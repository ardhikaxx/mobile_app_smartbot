import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SmartController {
  final String baseUrl = 'http://192.168.4.1';

  Future<void> sendYesCommand() async {
    try {
      final url = Uri.parse('$baseUrl/servo?state=up'); // Perintah untuk menggerakkan servo vertikal
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Servo vertical mengangguk");
      } else {
        print("Gagal mengirim perintah: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> sendNoCommand() async {
    try {
      final url = Uri.parse('$baseUrl/servo?state=down'); // Perintah untuk menggerakkan servo horizontal
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Servo horizontal geleng-geleng");
      } else {
        print("Gagal mengirim perintah: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<bool> modeAvoider(BuildContext context, bool isOn) async {
    String state = isOn ? 'on' : 'off';
    String endpoint = '/avoider?state=$state';
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        print('Avoider Mode ${isOn ? 'ON' : 'OFF'}');
        return true;
      } else {
        print('Failed to communicate with Wemos');
        return false;
      }
    } catch (e) {
      print('Error connecting to robot: $e');
      return false;
    }
  }

  Future<bool> toggleManualMode(bool isOn) async {
    String state = isOn ? 'on' : 'off';
    String endpoint = '/manual?state=$state';
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        print('Manual Mode ${isOn ? 'ON' : 'OFF'}');
        return true;
      } else {
        print('Failed to communicate with Wemos');
        return false;
      }
    } catch (e) {
      print('Error connecting to robot: $e');
      return false;
    }
  }

  Future<void> sendManualCommand(String command) async {
    try {
      final url = Uri.parse('$baseUrl/$command');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Command $command sent successfully: ${response.body}");
      } else {
        print("Failed to send command: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> handleJoystick(details) async {
    final double x = details.x;
    final double y = details.y;

    if (y < -0.5) {
      sendManualCommand("forward");
    } else if (y > 0.5) {
      sendManualCommand("backward");
    } else if (x < -0.5) {
      sendManualCommand("left");
    } else if (x > 0.5) {
      sendManualCommand("right");
    } else {
      sendManualCommand("stop");
    }
  }

  Future<bool> toggleGestureMode(bool isOn) async {
    String state = isOn ? 'on' : 'off';
    String endpoint = '/gesture?state=$state';
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        print('Gesture Mode ${isOn ? 'ON' : 'OFF'}');
        return true;
      } else {
        print('Failed to communicate with Wemos');
        return false;
      }
    } catch (e) {
      print('Error connecting to robot: $e');
      return false;
    }
  }

  Future<void> sendGestureCommand(String command) async {
    try {
      final url = Uri.parse('$baseUrl/gesture/$command');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Gesture Command $command sent successfully: ${response.body}");
      } else {
        print("Failed to send gesture command: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
