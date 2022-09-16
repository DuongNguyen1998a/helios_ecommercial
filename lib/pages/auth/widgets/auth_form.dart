import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Blocs
import '../../../blocs/auth_bloc/auth_bloc.dart';

/// Colors
import '../../../colors/app_colors.dart';

import '../../../routes/app_routes.dart';

/// Constants
import '../../../utils/constants.dart';

/// Responsive
import '../../../utils/responsive.dart';

/// Widgets
import 'auth_input.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final loginFormKey = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  void login() {
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      context.read<AuthBloc>().add(
            DoLogin(
              username: userTextController.text,
              password: passTextController.text,
            ),
          );

      //Navigator.pushReplacementNamed(context, AppRoutes.mainWrapper);
    }
  }

  void checkRememberMe(bool val) {
    context.read<AuthBloc>().add(
          CheckRememberMe(rememberMe: val),
        );
  }

  Future<void> setRememberData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? userName = sharedPrefs.getString(KeyUtils.userName);
    String? password = sharedPrefs.getString(KeyUtils.password);
    if (userName != null && password != null) {
      userTextController.text = userName;
      passTextController.text = password;
    }
  }

  @override
  void initState() {
    setRememberData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    userTextController.dispose();
    passTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.mainWrapper);
        } else if (state is AuthFailed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Thông báo',
                style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 18 : 18 * 1.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              content: Text(
                'Đăng nhập thất bại, vui lòng kiểm tra lại thông tin đăng nhập',
                style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontFamily: 'MyriadProRegular',
                      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              AuthInput(
                label: 'Tên đăng nhập',
                textInputAction: TextInputAction.next,
                controller: userTextController,
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 20 * 1.5,
              ),
              AuthInput(
                label: 'Mật khẩu',
                textInputAction: TextInputAction.done,
                controller: passTextController,
                obscureText: true,
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 20 * 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 20 : 40),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: Responsive.isMobile(context) ? 50 : 100,
                        child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: SizedBox(
                                height: 100,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Responsive.isMobile(context) ? 16 : 32),
                                ),
                              ),
                              onPressed: () {
                                login();
                              },
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 16 : 32,
                                  fontFamily: 'MyriadProRegular',
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.isMobile(context) ? 0 : 50,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: Responsive.isMobile(context) ? 20 : 40,
                                  right:
                                      Responsive.isMobile(context) ? 10 : 20),
                              alignment: Alignment.center,
                              width: Responsive.isMobile(context) ? 20 : 40,
                              height: Responsive.isMobile(context) ? 20 : 40,
                              color: const Color(0xFFF2F2F2),
                              child: Transform.scale(
                                scale: Responsive.isMobile(context) ? 1 : 2,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthInitial) {
                                      return Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: primaryColor,
                                        value: state.rememberMe,
                                        onChanged: (value) {
                                          checkRememberMe(value!);
                                        },
                                      );
                                    } else {
                                      return Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: primaryColor,
                                        value: false,
                                        onChanged: (value) {
                                          checkRememberMe(value!);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.isMobile(context) ? 0 : 20,
                          ),
                          Text(
                            'Nhớ tôi',
                            style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 15 : 32,
                              color: Colors.white,
                              fontFamily: 'MyriadProRegular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
