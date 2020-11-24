import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import './screens/index.dart';

void main() {
  //SharedPreferences.setMockInitialValues();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit()..checkCredentials(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ExerciseBloc>(
              create: (BuildContext context) => ExerciseBloc(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget widget) {
              Widget error = Text('...rendering error...');
              if (widget is Scaffold || widget is Navigator)
                error = Scaffold(body: Center(child: error));
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
              return widget;
            },
            theme: ThemeData(
                brightness: WidgetsBinding.instance.window.platformBrightness,
                fontFamily: 'CarterOne',
                primarySwatch: Colors.red,
                primaryColor: Color(0xFFB71C1C),
                accentColor: Color(0xFF9E9E9E),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: TextTheme(
                    title:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
              AddEditExerciseScreen.routeName: (ctx) => AddEditExerciseScreen(),
              ExerciseWorkOut.routeName: (ctx) => ExerciseWorkOut(),
            },
          ),
        ));
  }
}
