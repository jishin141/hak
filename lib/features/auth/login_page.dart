import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:hak/features/auth/bloc/auth_bloc.dart';
import 'package:hak/features/auth/otp_page.dart';

//  context.read<AuthBloc>().add(SentOtpEvent(
//                           moblileNumber: mobileNumberController.text));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(370)),
              child: Image.asset(
                "assets/images/login_image.jpg",
                fit: BoxFit.cover,
                height: height * 0.6,
                width: width,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            const Text(
              "Verify Your Mobile Number",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 214, 134, 190)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'We will sent you an OTP on your Mobile Number',
              style: TextStyle(
                  fontSize: 15, color: Color.fromARGB(255, 214, 134, 190)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: const Color.fromARGB(226, 237, 164, 188),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: mobileNumberController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Mobile number",
                    hintStyle: TextStyle(fontWeight: FontWeight.w200)),
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
                  // ScaffoldMessenger.of(context).showSnackBar();
                  IconSnackBar.show(context,
                      label: ' OTP Sent To ${state.mobileNumber}',
                      snackBarType: SnackBarType.success);
                }
              },
              builder: (context, state) {
                if (state is OtpLoadingState) {
                  return CircularProgressIndicator.adaptive();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(SentOtpEvent(
                          moblileNumber: mobileNumberController.text));
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 193, 195),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 173, 169, 169),
                                offset: Offset(10, 10),
                                blurRadius: 10),
                          ]),
                      child: const Center(
                          child: Text(
                        'Send OTP',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
