import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:hak/features/auth/bloc/auth_bloc.dart';
import 'package:hak/features/auth/otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: height * 0.3,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 221, 229),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 181, 190, 197),
                      offset: Offset(10, 10)),
                  BoxShadow(
                      blurRadius: 20,
                      color: Color.fromARGB(255, 179, 204, 224),
                      offset: Offset(-10, -10)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 233, 233, 233),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: mobileNumberController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Enter Mobile Number')),
                    ),
                  ),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is OtpReceived) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpPage(
                                    mobileNumber: state.mobileNumber,
                                  )));
                      ScaffoldMessenger.of(context).showSnackBar(
                          IconSnackBar.show(context,
                              label: ' OTP Sent To ${state.mobileNumber}',
                              snackBarType: SnackBarType.success));
                    }
                  },
                  builder: (context, state) {
                    if (state is OtpLoadingState) {
                      return CircularProgressIndicator.adaptive();
                    }
                    return ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SentOtpEvent(
                              moblileNumber: mobileNumberController.text));
                        },
                        child: const Text('Send OTP'));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
