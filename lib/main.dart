import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/screens/add-edit-exercise.dart';
import 'package:tracktion/screens/auth.dart';
import 'package:tracktion/screens/loading.dart';
import 'package:tracktion/screens/main.dart';
import 'screens/body-part.dart';
import './colors/custom_colors.dart';
import './screens/search-exercise.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit()..checkCredentials(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: WidgetsBinding.instance.window.platformBrightness,
            fontFamily: 'CarterOne',
            primarySwatch: Colors.red,
            primaryColor: Color(0xFFB71C1C),
            accentColor: Color(0xFF9E9E9E),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
                title: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            buttonTheme: const ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            )),
        home: BlocBuilder<AuthCubit, AuthState>(builder: (ctx, state) {
          if (state is AuthSuccess) return MainScreen();
          if (state is AuthFailed) return AuthScreen();
          return LoadingScreen();
        }),
        routes: {
          ExerciseScreen.routeName: (ctx) => ExerciseScreen(),
          SearchExercise.routeName: (ctx) => SearchExercise(),
          AddEditExerciseScreen.routeName: (ctx) => AddEditExerciseScreen()
        },
      ),
    );
  }
}
