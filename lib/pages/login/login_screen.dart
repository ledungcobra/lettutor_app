import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  late double _width;
  late double _height;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PADDING),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _introductionSection(),
                  const SizedBox(height: 10),
                  FormFields(width: _width),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: _width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: PRIMARY_COLOR,
                    onPressed: () {
                      print('Handle Login');
                    },
                    child: const Text('LOG IN',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _introductionSection() {
    return Column(
      children: [
        Image.asset(getAssetImage("intro_photo.png")),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Say hello your English tutors',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Become fluent faster through one on one video chat lessons tailored to your goals.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  bool showPassword = false;
}

class FormFields extends StatefulWidget {
  FormFields({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget._width,
          child: Text(
            'EMAIL',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your email',
          ),
          validator: validateEmail,
          onSaved: (value) {},
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: widget._width,
          child: Text(
            'PASSWORD',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
              suffixIcon: Container(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
              )),
          validator: validatePassword,
          obscureText: !showPassword,
        )
      ],
    );
  }
}
