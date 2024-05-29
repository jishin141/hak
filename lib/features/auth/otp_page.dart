import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final String mobileNumber;
  const OtpPage({super.key, required this.mobileNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.mobileNumber),
      ),
    );
  }
}
