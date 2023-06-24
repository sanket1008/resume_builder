import 'package:flutter/material.dart';

import '../resorses/components/round_button.dart';
import '../util/utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  ValueNotifier<bool> _passwordNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    // TODO: implement dispose

    _emailController.dispose();
    _emailController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _passwordNotifier.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email)),
              onFieldSubmitted: (value) {
                Utils.fieldFocusNode(context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _passwordNotifier,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: passwordFocusNode,
                    obscureText: _passwordNotifier.value,
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: (){
                            _passwordNotifier.value=!_passwordNotifier.value;
                          },

                            child: Icon(_passwordNotifier.value?Icons.visibility_off:Icons.visibility))),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            RoundButton(title: "Login", onPress: (){

            })
          ],
        ),
      ),
    ));
  }
}
