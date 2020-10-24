import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/cubit/auth_cubit.dart';
import 'package:tracktion/screens/auth.dart';
import 'package:tracktion/screens/loading.dart';
import 'package:tracktion/screens/main.dart';
import './screens/exercise.dart';
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
            // textTheme: ThemeData.light().textTheme.copyWith(
            //     body2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          SearchExercise.routeName: (ctx) => SearchExercise()
        },
      ),
    );
  }
}
