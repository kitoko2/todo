import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/commons/buttons/custom_button.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/domain/entities/home/notes.dart';
import 'package:todo/features/authentication/authentication_page.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/features/authentication/bloc/auth_state.dart';
import 'package:todo/features/home/bloc/notes/note_bloc.dart';
import 'package:todo/features/home/note_view.dart';
import 'package:todo/utils/extension.dart';

import '../authentication/bloc/auth_bloc.dart';

class NotesSize {
  NotesSize._();
  static double cardSize = 200.0;
  static double newBtnSize = 250.0;
}

class HomePage extends StatefulWidget {
  static String routeName = "home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AuthBloc authbloc;
  late NoteBloc noteBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    authbloc = context.read<AuthBloc>();
    noteBloc = context.read<NoteBloc>();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiBlocListener(
              listeners: [
                // --- AUTH LISTENER ---
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.user == null) {
                      context.goNamed(AuthenticationPage.routeName);
                    }
                  },
                ),

                // --- NOTIFICATION LISTENER ---
                BlocListener<NoteBloc, NoteState>(
                  listener: (context, state) {
                    if (state.message != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("🔔 ${state.message}")),
                      );
                    }
                  },
                ),
              ],
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: "Nouvelle note",
                    //  isLoading: state.isLoading ?? false,
                    onPressed: () {
                      print(authbloc.user!.id);
                      noteBloc.add(
                        CreateNoteEvent(
                          note: Notes(
                            title: "Welcome ",
                            description: "Welcome to abidjan",
                            tags: ["Personnel", "Travail", "Finance"],
                            //createdAt: DateTime.now(),
                            todoItems: [
                              Todo(title: "Todo1", check: false),
                              Todo(title: "Todo2", check: false),
                              Todo(title: "Todo3", check: false),
                            ],
                            uid: authbloc.user!.id,
                          ),
                        ),
                      );
                    },
                    width: NotesSize.newBtnSize,
                    prefix: Icon(Icons.add_box_rounded, color: Colors.white),
                  ),
                ),
                // second scaffold pour les tabs views
                backgroundColor: AppColors.background,
                appBar: AppBar(
                  backgroundColor: AppColors.background,
                  centerTitle: false,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary500,
                    child: CircleAvatar(
                      radius: 25.0,
                      child: ClipOval(
                        child: Image.network(
                          "https://images.pexels.com/photos/3785079/pexels-photo-3785079.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "Johny Johny ",
                    style: TextStyle(
                      color: AppColors.primary500,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.search, color: AppColors.link),
                    ),
                    IconButton(
                      onPressed: () {
                        authbloc.add(LogoutEvent());
                      },
                      icon: Icon(
                        CupertinoIcons.ellipsis,
                        color: AppColors.link,
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: [
                        4.verticalSpace,
                        Divider(color: AppColors.greenDivider, thickness: 2),
                        TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.primary600,
                          unselectedLabelColor: AppColors.neutral500,
                          tabs: const [
                            Tab(text: "Mes Notes"),
                            Tab(text: "Groupes"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              MyNotesView(bloc: noteBloc),
                              Center(child: Text("Groupes")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
