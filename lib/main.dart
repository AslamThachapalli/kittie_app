import 'dart:developer';

import 'package:cat_brochure_app/features/cat_list/presentation/bloc/cat_list_bloc.dart';
import 'package:cat_brochure_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String defaultBreed = "beng";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<CatListBloc>()..add(FetchNextPage(breed: defaultBreed)),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: BlocBuilder<CatListBloc, CatListState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            loadInProgress: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            catsFetched: (state) {
              return NotificationListener<ScrollNotification>(
                onNotification: (not) => _handleScrollNotification(not, "beng"),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.cats.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.cats.length) {
                      if (state.hasReachedTheEnd) {
                        return const Center(child: Text("Has Reached End"));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(
                          "$index ${state.cats[index].id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            },
            loadFailure: (state) => Center(
              child: Text(state.message),
            ),
          );
        },
      ),
    );
  }

  bool _handleScrollNotification(
      ScrollNotification notification, String breed) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      BlocProvider.of<CatListBloc>(context).add(FetchNextPage(breed: breed));
    }

    return false;
  }
}
