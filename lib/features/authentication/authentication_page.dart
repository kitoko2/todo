import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/commons/buttons/custom_button.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/utils/extension.dart';
import '../../commons/buttons/custom_outline_btn.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

class AuthenticationPage extends StatefulWidget {
  static String routeName = "authentication";
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late AuthBloc bloc;
  bool showPassword = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            passwordController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.badge,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bienvenue",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      "Connectez-vous pour continuer",
                      style: TextStyle(
                        color: AppColors.neutral400,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    40.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        6.verticalSpace,
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            controller: emailController,
                            decoration: InputDecoration(
                              hint: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "vous@example.com",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                              ),
                              prefixIcon: Icon(CupertinoIcons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundTertiary,
                            ),
                          ),
                        ),
                        20.verticalSpace,

                        Text(
                          "Mot de passe",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        6.verticalSpace,
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            obscureText: !showPassword,
                            obscuringCharacter: "-",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.black,
                            ),
                            controller: passwordController,
                            decoration: InputDecoration(
                              hint: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "-------",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                              ),

                              prefixIcon: Icon(CupertinoIcons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  !showPassword
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundTertiary,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: Text("Mot de passe oublié ?"),
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    CustomButton(
                      text: "Se connecter",
                      isLoading: state.isLoading == true,
                      onPressed: () {
                        bloc.add(
                          LoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.neutral400)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text("ou"),
                        ),
                        Expanded(child: Divider(color: AppColors.neutral400)),
                      ],
                    ),
                    22.verticalSpace,
                    CustomOutlinedButton(
                      iconPrefix: CupertinoIcons.app,
                      onPressed: () {},
                      text: ("Continuer avec Google"),
                    ),
                    12.verticalSpace,
                    CustomOutlinedButton(
                      iconPrefix: CupertinoIcons.app,
                      onPressed: () {},
                      text: ("Continuer avec Github"),
                    ),
                    12.verticalSpace,
                    CustomOutlinedButton(
                      borderColor: AppColors.primary500,
                      textColor: AppColors.primary500,
                      iconPrefix: CupertinoIcons.app,
                      onPressed: () {},
                      text: ("Créer un compte"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
