import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/feature/projects/firebase/core/utils.dart';
import 'package:portfolio/feature/projects/firebase/feature/login_screen/login_screen_cubit.dart';
import 'package:portfolio/feature/projects/firebase/feature/login_screen/login_screen_state.dart';
import 'package:portfolio/widgets/instant_page_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const route = "login_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const LoginScreen();
      },
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  final appNavigator = inject<AppNavigator>();
  final cubit = LoginScreenCubit();
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

  @override
  void initState() {
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _formKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      body: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        bloc: cubit,
        listener: (context, state) => state.maybeWhen(
            orElse: () => null,
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(error),
              ));
              return null;
            },
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Account created successfully.'),
              ));
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              return null;
            }),
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Image.asset('assets/images/firebase.png', height: 200),
            ),
            const Spacer(),
            Container(
              height: 350,
              decoration: const BoxDecoration(color: Color(0xffFFCB2B)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      TextFormFieldWidget(
                        controller: _controllerEmail,
                        label: 'e-mail',
                        validator: (email) {
                          if (email != null && emailValid(email)) {
                            return null;
                          }
                          return 'please enter a valid email address.';
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        label: 'password',
                        controller: _controllerPassword,
                        obscureText: true,
                        validator: (password) {
                          if (password != null && password.length > 7) {
                            return null;
                          }
                          return 'Your password must be at least 6 characters long.';
                        },
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('Forgot Password'),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => appNavigator.navigateToRegisterScreen(context),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 28, 27, 27)),
                        child: const Text('''Don't have an account? Sign Up Now'''),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            if (state is! LoginScreenLoadingState) {
                              if (_formKey.currentState!.validate()) {
                                cubit.login(_controllerEmail.text, _controllerPassword.text);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 28, 27, 27)),
                          child: state is LoginScreenLoadingState
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(color: Colors.white),
                                )
                              : const Text('Login')),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    cubit.close();
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const TextFormFieldWidget({
    Key? key,
    required this.label,
    this.obscureText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: const Color.fromARGB(255, 28, 27, 27),
        style: const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            errorStyle: const TextStyle(height: .4),
            label: Text(label),
            labelStyle: const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
            hintStyle: const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 28, 27, 27), width: 3.0),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
