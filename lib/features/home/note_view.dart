import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/utils/extension.dart';

class NotesSize {
  NotesSize._();
  static double cardSize = 200.0;
  static double newBtnSize = 250.0;
}

class MyNotesView extends StatelessWidget {
  const MyNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 12,
        physics: BouncingScrollPhysics(),
        itemCount: 19,
        itemBuilder: (context, index) {
          return Container(
            height: index.isEven ? NotesSize.cardSize : NotesSize.cardSize + 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // create at
                  Text("20 APR"),
                  // title
                  Text(
                    "Exploration Ideas",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.verticalSpace,
                  // category
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(184, 168, 198, 186),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text("Design"),
                    ),
                  ),
                  10.verticalSpace,
                  // content
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim i",
                    maxLines: index.isEven ? 4 : 6,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
