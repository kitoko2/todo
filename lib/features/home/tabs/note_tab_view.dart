import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/home/bloc/notes/note_bloc.dart';
import 'package:todo/utils/extension.dart';

class NotesSize {
  NotesSize._();
  static double cardSize = 200.0;
  static double newBtnSize = 250.0;
}

class MyNotesView extends StatelessWidget {
  const MyNotesView({super.key, required this.bloc});
  final NoteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: StreamBuilder(
        stream: bloc.getUserNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return Center(child: Text("Aucune note ajoutée"));
          }
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
            physics: BouncingScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Container(
                height: index.isEven
                    ? NotesSize.cardSize
                    : NotesSize.cardSize + 50,
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
                      Text(note.date),
                      // title
                      Text(
                        note.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      // TAG
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: note.tags
                              .map((tag) => TagItem(tag: tag))
                              .toList(),
                        ),
                      ),

                      10.verticalSpace,
                      // content
                      Text(
                        note.description ?? "",
                        maxLines: index.isEven ? 4 : 6,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      10.verticalSpace,
                      Expanded(
                        child: Column(
                          children: note.todoItems
                              .map(
                                (todo) => Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.circle_filled,
                                      size: 10.0,
                                    ),
                                    10.horizontalSpace,
                                    Text(todo.title),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  const TagItem({super.key, required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color.fromARGB(184, 168, 198, 186),
      ),
      child: Padding(padding: const EdgeInsets.all(6.0), child: Text(tag)),
    );
  }
}
