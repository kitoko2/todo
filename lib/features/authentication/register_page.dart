import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/gen/assets.gen.dart';
import 'package:todo/features/authentication/authentication_page.dart';
import 'package:todo/utils/extension.dart';
import '../../commons/buttons/custom_button.dart';
import '../../commons/buttons/custom_outline_btn.dart';
import '../../commons/textfield/custom_field.dart';
import '../../core/theme/app_colors.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "register";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthBloc bloc;
  bool showPassword = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

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
            ScaffoldMessenger.of(
              context,
            ).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.badge,
              ),
            );
          } else if (state.user != null) {
            ScaffoldMessenger.of(
              context,
            ).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Votre compte a été créé avec succès"),
                backgroundColor: AppColors.success,
              ),
            );
            context.go("/${AuthenticationPage.routeName}");
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
                      "Créer un compte",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      "Commencez à collaborer dès aujourd'hui",
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
                          "Nom d'utilisateur",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        6.verticalSpace,
                        CustomTextField(
                          controller: usernameController,
                          type: TextFieldType.text,
                          hintText: "john doe",
                        ),
                        20.verticalSpace,
                        Text(
                          "Email",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        6.verticalSpace,
                        CustomTextField(
                          controller: emailController,
                          type: TextFieldType.email,
                          hintText: "vous@example.com",
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
                        CustomTextField(
                          controller: passwordController,
                          type: TextFieldType.password,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    CustomButton(
                      text: "Créer un compte",
                      isLoading: state.isLoading == true,
                      onPressed: () {
                        if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty &&
                            usernameController.text.isEmpty) {
                          state.copyWith(
                            errorMessage: "Veuillez remplir tous les champs",
                          );
                        } else {
                          bloc.add(
                            RegisterEvent(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                    15.verticalSpace,
                    WhereDivider(),
                    22.verticalSpace,
                    CustomOutlinedButton(
                      prefixSvg: Assets.svgs.google,
                      onPressed: () {},
                      text: ("Continuer avec Google"),
                    ),

                    12.verticalSpace,
                    CustomOutlinedButton(
                      prefixSvg: Assets.svgs.github,
                      onPressed: () {},
                      text: ("Continuer avec Github"),
                    ),
                    12.verticalSpace,
                    CreateNewAccount(
                      label: "Vous avez déjà un compte ?",
                      txtBtn: "Connectez-vous",
                      onPressed: () {
                        context.go("/${AuthenticationPage.routeName}");
                      },
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
