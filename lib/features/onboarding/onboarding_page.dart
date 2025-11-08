import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/commons/buttons/custom_button.dart';
import 'package:todo/core/gen/assets.gen.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/authentication/authentication_page.dart';
import 'package:todo/utils/extension.dart';

class _Constants {
  static const double bottomContainerHeight = 250;
}

class ItemOnboarding {
  final String title;
  final String description;
  final String imagePath;
  final Color color;

  ItemOnboarding({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
  });
}

class OnboardingPage extends StatefulWidget {
  static String routeName = "onboarding";
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final List<ItemOnboarding> items = [
    ItemOnboarding(
      title: "Prenez des notes en équipe",
      description:
          "Capturez vos idées et partagez-les instantanément avec votre groupe.",
      imagePath: Assets.images.on1.path,
      color: Color(0xFF1F7D53),
    ),
    ItemOnboarding(
      title: "Restez synchronisés",
      description:
          "Toutes les notes sont mises à jour en temps réel, pour tout le monde.",
      imagePath: Assets.images.on2.path,
      color: Color(0xFF8D6E63),
    ),
    ItemOnboarding(
      title: "Allez plus vite ensemble",
      description:
          "Organisez, classez et retrouvez vos informations en quelques secondes.",
      imagePath: Assets.images.on3.path,
      color: Color(0xFF4E342E),
    ),
  ];

  ItemOnboarding get currentItem => items[currentIndex];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              currentIndex = value;
              setState(() {});
            },
            children: items
                .map(
                  (item) => Container(
                    color: item.color,
                    child: Center(child: Image.asset(item.imagePath)),
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _Constants.bottomContainerHeight,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Todo App",
                    style: TextStyle(color: AppColors.neutral500),
                  ),
                  12.verticalSpace,
                  Text(
                    currentItem.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  6.verticalSpace,
                  Text(currentItem.description),
                  Spacer(),
                  CustomButton(
                    text: "Commencer",
                    backgroundColor: currentItem.color,
                    onPressed: () {
                      context.go("/${AuthenticationPage.routeName}");
                    },
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
