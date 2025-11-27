import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/home/bloc/groupes/group_bloc.dart';

class GroupSize {
  GroupSize._();
  static double cardSize = 200.0;
  static double newBtnSize = 250.0;
}

class GroupTabView extends StatelessWidget {
  const GroupTabView({super.key, required this.bloc});
  final GroupBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: StreamBuilder(
        stream: bloc.getUserGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final groupes = snapshot.data ?? [];

          if (groupes.isEmpty) {
            return Center(child: Text("Aucun groupe créé"));
          }
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
            physics: BouncingScrollPhysics(),
            itemCount: groupes.length,
            itemBuilder: (context, index) {
              final groupe = groupes[index];
              return GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                      height: index.isEven
                          ? GroupSize.cardSize
                          : GroupSize.cardSize + 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(99, 203, 173, 66),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // create at
                            Text(groupe.dateFormated),
                            // title
                            Text(
                              groupe.name,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: 3,

                      child: GestureDetector(
                        onTap: () {
                          bloc.add(DeleteGroupEvents(groupId: groupe.id!));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                            color: AppColors.badge,
                          ),
                          child: Icon(
                            CupertinoIcons.xmark,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
