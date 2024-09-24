import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'; // Add this import for context

class SmartController {
  final String baseUrl = 'http://192.168.4.1'; // Replace with your Wemos IP

  Future<bool> modeAvoider(BuildContext context, bool isOn) async {
    String state = isOn ? 'on' : 'off';
    String endpoint = '/avoider?state=$state'; // Update endpoint with state parameter
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

  Future<void> sendCommand(String command) async {
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
      sendCommand("forward");
    } else if (y > 0.5) {
      sendCommand("backward");
    } else if (x < -0.5) {
      sendCommand("left");
    } else if (x > 0.5) {
      sendCommand("right");
    } else {
      sendCommand("stop");
    }
  }
}