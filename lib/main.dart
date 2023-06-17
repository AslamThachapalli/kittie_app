import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:cat_brochure_app/features/cat_list/presentation/bloc/cat_list_bloc.dart';
import 'package:cat_brochure_app/features/cat_list/presentation/pages/home_page.dart';
import 'package:cat_brochure_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String defaultBreed = "beng";

    return BlocProvider(
      create: (context) =>
          di<CatListBloc>()..add(const FetchNextPage(breed: defaultBreed)),
      child: MaterialApp(
        title: 'Cat Brochure App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.accentColor,
            circularTrackColor: AppColors.mainColor,
          ),
        ),
        home: const HomePage(currentBreed: defaultBreed),
      ),
    );
  }
}
