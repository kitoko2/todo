import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/commons/buttons/custom_button.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/features/authentication/register_page.dart';
import 'package:todo/utils/extension.dart';
import '../../commons/buttons/custom_outline_btn.dart';
import '../../commons/textfield/custom_field.dart'
    show CustomTextField, TextFieldType;
import '../../core/gen/assets.gen.dart';
import '../home/home_page.dart';
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
                content: Text("Bienvenue ${state.user!.name}"),
                backgroundColor: AppColors.success,
              ),
            );
            context.go("/${HomePage.routeName}");
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    20.verticalSpace,
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

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            // alignment: AlignmentGeometry.centerRight,
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
                        if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          state.copyWith(
                            errorMessage: "Veuillez remplir tous les champs",
                          );
                        } else {
                          bloc.add(
                            LoginEvent(
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
                      label: "Vous n'avez pas de compte ?",
                      txtBtn: "Créer un compte",
                      onPressed: () {
                        context.go("/${RegisterPage.routeName}");
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

class CreateNewAccount extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final String txtBtn;
  const CreateNewAccount({
    super.key,
    required this.onPressed,
    required this.label,
    required this.txtBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(foregroundColor: AppColors.primary500),
          child: Text(txtBtn, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class WhereDivider extends StatelessWidget {
  const WhereDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.neutral400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("ou"),
        ),
        Expanded(child: Divider(color: AppColors.neutral400)),
      ],
    );
  }
}
