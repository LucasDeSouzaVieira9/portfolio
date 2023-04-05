import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/feature/projects/firebase/core/utils.dart';
import 'package:portfolio/feature/projects/firebase/feature/login_screen/login_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/registration_screen/registration_screen_cubit.dart';
import 'package:portfolio/feature/projects/firebase/feature/registration_screen/registration_screen_state.dart';
import 'package:portfolio/feature/projects/firebase/model/user_model.dart';
import 'package:portfolio/widgets/instant_page_route.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const route = "registration_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const RegistrationScreen();
      },
    );
  }

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final cubit = RegistrationScreenCubit();
  final appNavigator = inject<AppNavigator>();

  late GlobalKey<FormState> _formKey;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerFirsName;
  late TextEditingController _controllerLastName;

  @override
  void initState() {
    _formKey = GlobalKey();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerFirsName = TextEditingController();
    _controllerLastName = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                onPressed: () => appNavigator.navigateToLoginScreen(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xffFFCB2B),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset('assets/images/firebase.png', height: 200),
          ),
          const Spacer(),
          BlocConsumer<RegistrationScreenCubit, RegistrationScreenState>(
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
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/home', (route) => false);
                  return null;
                }),
            builder: (context, state) => state.maybeWhen(
              loading: () => const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              orElse: () => Container(
                height: 500,
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
                          controller: _controllerFirsName,
                          label: 'First Name',
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              return null;
                            }
                            return 'please enter the first name.';
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldWidget(
                          controller: _controllerLastName,
                          label: 'Last Name',
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              return null;
                            }
                            return 'please enter the last name.';
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldWidget(
                          controller: _controllerEmail,
                          label: 'Email',
                          validator: (email) {
                            if (email != null && emailValid(email)) {
                              return null;
                            }
                            return 'please enter a valid email address.';
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldWidget(
                          controller: _controllerPassword,
                          label: 'Password',
                          obscureText: true,
                          validator: (password) {
                            if (password != null && password.length > 7) {
                              return null;
                            }
                            return 'Your password must be at least 8 characters long.';
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.registration(
                                UserModel(id: '', firstName: _controllerFirsName.text, lastName: _controllerLastName.text, email: _controllerEmail.text),
                                _controllerPassword.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 28, 27, 27)),
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerFirsName.dispose();
    _controllerLastName.dispose();
  }
}
