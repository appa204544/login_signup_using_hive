import 'package:appentus_project/apis/providers/dashboard_provider.dart';
import 'package:appentus_project/apis/providers/user_provider.dart';
import 'package:appentus_project/theme/theme_manager.dart';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/comman.dart';
import 'package:appentus_project/utils/fade_animator.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/utils/validations.dart';
import 'package:appentus_project/widgets/buttons/primary_button.dart';
import 'package:appentus_project/widgets/textfields/email_textfield.dart';
import 'package:appentus_project/widgets/textfields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:textless/textless.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool _passObsecure = false;
  bool loginAutovalidation = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        backwardsCompatibility: false,
        actions: [
          Consumer<ThemeManager>(builder: (context, themeManager, child) {
            return Switch(
                value: themeManager.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeManager.toggleTheme(value);
                });
          })
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Comman.sizeBoxheight(height * 0.12),
                  FadeAnimation(
                    delay: 1.0,
                    child: login.h2,
                  ),
                  Comman.sizeBoxheight(height * 0.12),
                  FadeAnimation(
                      delay: 0.2,
                      child: EmailTextfield(
                        controller: _emailController,
                        autovalidateMode: loginAutovalidation ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      )),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                      delay: 0.3,
                      child: passTextField(
                          controller: _passwordController, height: height)),
                  Comman.sizeBoxheight(height * 0.12),
                  FadeAnimation(
                      delay: 0.5,
                      child: PrimaryButton(
                        btnTxt: login,
                        onPressed: () async {
                          Comman.removeFocus(context);
                          var box = await Hive.openBox(isLoggedIn);
                          box.put(isLoggedIn, false);
                          if (!_loginFormKey.currentState!.validate()) {
                            setState(() {
                                  loginAutovalidation = true;
                                });
                          } else {
                            UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                            userProvider.login(context, email: _emailController.text.trim(), password: _passwordController.text.trim());
                          }
                        },
                      )),
                      Comman.sizeBoxheight(height * 0.02),
                      FadeAnimation(delay: 0.6, child: dontHaveAcc(),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget dontHaveAcc(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dontAcc.h5,
        InkWell(
          onTap: (){
            Navigator.pushNamedAndRemoveUntil(context, '/signUpScreen', (route) => false);
          },
          child: signUp.h5.bold,
        )
      ],
    );
  }

  Widget passTextField(
      {required TextEditingController controller, required double height}) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextFieldWidget(
          controller: _passwordController,
          labelText: password,
          hintText: enterPassword,
          autovalidateMode: loginAutovalidation ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          maxLength: 15,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(Icons.lock_outline_rounded, size: height * 0.04),
            splashRadius: 1,
          ),
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            return Validations.pwdValidator(value!.trim());
          },
          obscureText: !_passObsecure,
        ),
        Positioned(
          child: IconButton(
            splashRadius: 1,
            icon: Icon(
                _passObsecure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: lightGrey),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _passObsecure = !_passObsecure;
              });
            },
          ),
        ),
      ],
    );
  }
}
