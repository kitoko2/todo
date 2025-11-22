import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/domain/entities/home/notes.dart';
import 'package:todo/features/home/home_page.dart';
import 'package:todo/utils/constants/note_tags.dart';
import 'package:todo/utils/extension.dart';

import '../bloc/notes/note_bloc.dart';

class CreateNoteSize {
  static const double leadingWidth = 150;
  static const double createBtnSize = 200;
}

class CreateNoteView extends StatefulWidget {
  static String routeName = 'create-note';
  const CreateNoteView({super.key, required this.userID});

  final String userID;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  late NoteBloc noteBloc;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteBloc = context.read<NoteBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state.success == true) {
          context.goNamed(HomePage.routeName);
        }
      },
      builder: (context, state) {
        return CreateNote(
          noteLogic: noteBloc,
          titleController: titleController,
          contentController: contentController,
          userID: widget.userID,
        );
      },
    );
  }
}

class CreateNote extends StatelessWidget {
  const CreateNote({
    super.key,
    required this.noteLogic,
    required this.titleController,
    required this.contentController,
    required this.userID,
  });
  final NoteBloc noteLogic;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leadingWidth: CreateNoteSize.leadingWidth,
        centerTitle: false,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: AppColors.primary500,
              ),
            ),

            8.horizontalSpace,
            Text(
              "Créer",
              style: TextStyle(color: AppColors.primary500, fontSize: 18.0),
            ),
          ],
        ),
        actions: appBarActions(
          logic: noteLogic,
          uid: userID,
          title: titleController.value.text,
          content: contentController.value.text,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ajouter un titre",
                  hintStyle: TextStyle(
                    color: AppColors.neutral500,
                    fontSize: 20.0,
                  ),
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              // label components
              NoteTagsComponents(noteLogic: noteLogic),
              Column(
                children: [
                  TextField(
                    controller: contentController,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Contenu...",
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.neutral400,
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteTagsComponents extends StatelessWidget {
  const NoteTagsComponents({super.key, required this.noteLogic});

  final NoteBloc noteLogic;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: noteLogic.state.tags.isEmpty
                ? Text(
                    "Ajouter un tag",
                    style: TextStyle(
                      color: AppColors.neutral500,
                      fontSize: 13.0,
                    ),
                  )
                : Row(
                    children: noteLogic.state.tags
                        .map(
                          (tag) => Row(
                            children: [
                              (noteLogic.state.tags.indexOf(tag) != 0)
                                  ? Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 1,
                                          color: AppColors.neutral200,
                                        ),
                                        SizedBox(width: 10.0),
                                      ],
                                    )
                                  : SizedBox(),
                              Text(
                                tag.label,
                                style: TextStyle(
                                  color: tag.color,
                                  fontSize: 16.0,
                                ),
                              ),
                              8.horizontalSpace,
                            ],
                          ),
                        )
                        .toList(),
                  ),
          ),
        ),

        PopupMenuButton(
          position: PopupMenuPosition.under,
          icon: Icon(
            CupertinoIcons.tags,
            size: 20.0,
            color: AppColors.primary500,
          ),
          color: AppColors.white,
          itemBuilder: (context) {
            return NoteTags.tagsList
                .map(
                  (tagM) => PopupMenuItem(
                    child: StatefulBuilder(
                      // pour reconstruire le widget apes un clic
                      builder: (context, setStatePopup) {
                        return CheckboxListTile(
                          value: noteLogic.state.tags.any(
                            (tag) => tag.label == tagM.label,
                          ),
                          onChanged: (value) {
                            noteLogic.add(AddTagEvent(tag: tagM));
                            setStatePopup(
                              () {},
                            ); // met à jour l'affichage du popup
                          },
                          title: Text(
                            tagM.label,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toList();
          },
        ),
      ],
    );
  }
}

List<Widget> appBarActions({
  required NoteBloc logic,
  required String uid,
  required String title,
  required String content,
}) {
  return [
    IconButton(
      icon: Icon(
        CupertinoIcons.arrow_uturn_left_circle,
        color: AppColors.primary500,
      ),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(
        CupertinoIcons.arrow_uturn_right_circle,
        color: AppColors.neutral400,
      ),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(CupertinoIcons.share, color: AppColors.primary500),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(CupertinoIcons.check_mark, color: AppColors.primary500),
      onPressed: () {
        logic.add(
          CreateNoteEvent(
            note: Notes(
              title: title,
              description: content,
              tags: logic.state.tags.map((e) => e.label).toList(),
              //createdAt: DateTime.now(),
              todoItems: [],
              uid: uid,
            ),
          ),
        );
      },
    ),
  ];
}
