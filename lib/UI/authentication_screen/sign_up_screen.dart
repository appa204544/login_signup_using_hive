import 'package:appentus_project/apis/providers/user_provider.dart';
import 'package:appentus_project/theme/app_colors.dart';
import 'package:appentus_project/utils/comman.dart';
import 'package:appentus_project/utils/fade_animator.dart';
import 'package:appentus_project/utils/get_image_provider.dart';
import 'package:appentus_project/utils/strings.dart';
import 'package:appentus_project/utils/validations.dart';
import 'package:appentus_project/widgets/buttons/primary_button.dart';
import 'package:appentus_project/widgets/dialogs.dart';
import 'package:appentus_project/widgets/textfields/email_textfield.dart';
import 'package:appentus_project/widgets/textfields/name_textField.dart';
import 'package:appentus_project/widgets/textfields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:textless/textless.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPassController;
  final _signUpFormKey = GlobalKey<FormState>();
  bool _passObsecure = false;
  bool _cPassObsecure = false;
  bool signUpAutovalidation = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Comman.sizeBoxheight(height * 0.05),
                  FadeAnimation(
                    delay: 1.0,
                    child: signUp.h2,
                  ),
                  Comman.sizeBoxheight(height * 0.03),
                  Consumer<GetImage>(builder: (context, modal, child) {
                    return FadeAnimation(
                      delay: 0.1,
                      child: Stack(
                        children: [
                          modal.imageFile != null
                              ? CircleAvatar(
                                  radius: height * 0.08,
                                  backgroundColor: white,
                                  child: ClipOval(
                                      child: Image.file(
                                    modal.imageFile!,
                                    height: height * 0.2,
                                    width: height * 0.2,
                                    fit: BoxFit.cover,
                                  )),
                                )
                              : Icon(
                                  Icons.person,
                                  size: height * 0.15,
                                  color: primary.withOpacity(0.4),
                                ),
                          Positioned(
                            bottom: 10,
                            right: modal.imageFile != null ? 0 : 10,
                            child: GestureDetector(
                              onTap: () async {
                                if (modal.imageFile != null) {
                                  modal.removeImage(0);
                                } else {
                                  Comman.removeFocus(context);
                                  Provider.of<GetImage>(context, listen: false)
                                      .gallerybottomSheet(context);
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: primary, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: modal.imageFile != null
                                    ? Icon(
                                        Icons.close,
                                        color: primary,
                                      )
                                    : Icon(
                                        Icons.add,
                                        color: primary,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                      delay: 0.2,
                      child: NameTextField(
                        controller: _nameController,
                        autovalidateMode: signUpAutovalidation
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      )),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                      delay: 0.3,
                      child: EmailTextfield(
                        controller: _emailController,
                        autovalidateMode: signUpAutovalidation
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      )),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                    delay: 0.4,
                    child: TextFieldWidget(
                      controller: _phoneController,
                      labelText: phone,
                      keyboardType: TextInputType.number,
                      maxLength: 15,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: signUpAutovalidation
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      hintText: enterPhone,
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.call_outlined, size: height * 0.03),
                        splashRadius: 1,
                      ),
                      validator: (value) {
                        return Validations.phoneValidator(value!.trim());
                      },
                    ),
                  ),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                      delay: 0.5,
                      child: passTextField(
                          controller: _passwordController, height: height)),
                  Comman.sizeBoxheight(height * 0.03),
                  FadeAnimation(
                      delay: 0.6,
                      child: conPassTextField(
                          controller: _confirmPassController, height: height)),
                  Comman.sizeBoxheight(height * 0.05),
                  FadeAnimation(
                      delay: 0.7,
                      child: PrimaryButton(
                        btnTxt: signUp,
                        onPressed: () async {
                          Comman.removeFocus(context);
                          var box = await Hive.openBox(isLoggedIn);
                          box.put(isLoggedIn, false);
                          GetImage getImage =
                              Provider.of<GetImage>(context, listen: false);
                          UserProvider userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          if (!_signUpFormKey.currentState!.validate()) {
                            setState(() {
                              signUpAutovalidation = true;
                            });
                          } else if (_passwordController.text.trim() !=
                              _confirmPassController.text.trim()) {
                            Dialogs.infoDiallog(
                              context,
                              title: oops,
                              image: errorImg,
                              discription: passDoesntMatchError,
                            );
                          } else if (getImage.base64Image == null) {
                            Dialogs.infoDiallog(
                              context,
                              title: oops,
                              image: errorImg,
                              discription: addPhotoError,
                            );
                          } else {
                            userProvider.signUp(context,
                                image: getImage.base64Image!,
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                password: _passwordController.text.trim());
                          }
                        },
                      )),
                  Comman.sizeBoxheight(height * 0.02),
                  FadeAnimation(delay: 0.8, child: alreadyHaveAcc()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget alreadyHaveAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        alreadyAcc.h5,
        InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/loginScreen', (route) => false);
          },
          child: login.h5.bold,
        ),
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
          maxLength: 15,
          autovalidateMode: signUpAutovalidation
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(Icons.lock_outline_rounded, size: height * 0.03),
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

  Widget conPassTextField(
      {required TextEditingController controller, required double height}) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextFieldWidget(
          controller: _confirmPassController,
          maxLength: 15,
          autovalidateMode: signUpAutovalidation
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(Icons.lock_outline_rounded, size: height * 0.03),
            splashRadius: 1,
          ),
          labelText: reEnterPass,
          hintText: confirmPass,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          keyboardType: TextInputType.visiblePassword,
          obscureText: _cPassObsecure,
          validator: (value) {
            return Validations.confirmPwdValidator(
                _confirmPassController.text, _passwordController.text);
          },
        ),
        Positioned(
          child: IconButton(
            splashRadius: 1,
            icon: Icon(
              !_cPassObsecure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: lightGrey,
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _cPassObsecure = !_cPassObsecure;
              });
            },
          ),
        ),
      ],
    );
  }
}
