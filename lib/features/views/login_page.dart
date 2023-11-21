import 'package:chat_application/features/views/chats_page.dart';
import 'package:chat_application/features/views/signup_page.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../constants/color_constants.dart';
import '../methods/large_text_methods.dart';
import '../mixins/navigator_manager.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget with NavigatorManager {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> signIn() async {
      // get the auth service
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signInUser(
            mailController.text, passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextLargeWidget(text: 'LOGIN')),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Never Lost. Discover New Music.')),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                child: TextFieldWidget(
                  hintText: 'email address',
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                child: TextFieldWidget(
                  hintText: ' password',
                  visiblePassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBottonWidget(
                      title: 'LOGIN',
                      width: size.width * 0.5,
                      color: ColorsConstants.blueColor,
                      callback: () {
                        if (formKey.currentState!.validate()) {
                          // LoginProcess();
                          signIn();
                          widget.navigateToWidget(context,  ChatsScreen());
                        }
                      },
                    ),
                    SvgPicture.asset(
                      'assets/spotify.svg',
                      width: 50,
                      height: 50,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const Text("Don't you have account?  "),
                    InkWell(
                        onTap: () {
                          widget.navigateToWidget(context, const SignUpPage());
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: ColorsConstants.blueColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
