import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/forgot_password/forgot_password.dart';
import 'package:lettutor_app/utils/helper.dart';

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
        ),
        SizedBox(height: 10),
        SizedBox(
          width: widget._width,
          child: Text(
            'RePassword',
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
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          TextButton(
            onPressed: _openForgotPassword,
            child: const Text('Forgot Password?'),
            style: ButtonStyle(alignment: Alignment.topLeft),
          ),
        ])
      ],
    );
  }

  void _openForgotPassword() {
    Get.to(ForgotPasswordScreen());
  }
}
