import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OtpCodeScreen extends StatelessWidget {
  const OtpCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP Code')),
      body: Center(child: Text('Verify your OTP code here')),
    );
  }
}
