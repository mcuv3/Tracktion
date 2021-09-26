import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/screens/routine/routine-main-screen.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/screens/workout/workout-routine-search-screen.dart';

import './screens/index.dart';
import 'bloc/exercise-stream/exercisestream_cubit.dart';
import 'bloc/routine-group/routine_bloc.dart';
import 'bloc/routine/routine_bloc.dart';
import 'bloc/routines/routines_bloc.dart';
import 'plugins/desktop/desktop.dart';

// TODO: migrate to null safety

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setTargetPlatformForDesktop();
  runApp(TracktionApp());
}

class TracktionApp extends StatefulWidget {
  @override
  _TracktionAppState createState() => _TracktionAppState();
}

class _TracktionAppState extends State<TracktionApp> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        // ServerMigrator(db: database).migrate();
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SQLDatabase>(
      create: (context) => constructDb(),
      child: BlocProvider(
          create: (BuildContext context) => AuthCubit()..listenUser(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ExerciseBloc>(
                create: (BuildContext context) => ExerciseBloc(
                  RepositoryProvider.of<SQLDatabase>(context),
                ),
              ),
              BlocProvider<WorkoutBloc>(
                create: (context) => WorkoutBloc(
                  RepositoryProvider.of<SQLDatabase>(context),
                ),
              ),
              BlocProvider<WorkoutpickerBloc>(
                create: (context) => WorkoutpickerBloc(
                    db: RepositoryProvider.of<SQLDatabase>(context)),
              ),
              BlocProvider<RoutineBloc>(
                create: (context) =>
                    RoutineBloc(RepositoryProvider.of<SQLDatabase>(context)),
              ),
              BlocProvider<RoutinesBloc>(
                create: (context) =>
                    RoutinesBloc(RepositoryProvider.of<SQLDatabase>(context)),
              ),
              BlocProvider<RoutineGroupBloc>(
                create: (context) => RoutineGroupBloc(
                    RepositoryProvider.of<SQLDatabase>(context)),
              ),
              BlocProvider(
                  create: (BuildContext context) => ExerciseStreamCubit(
                      db: RepositoryProvider.of<SQLDatabase>(context))),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              color: Colors.black,
              builder: (BuildContext context, Widget widget) {
                Widget error = Text('...rendering error...');
                if (widget is Scaffold || widget is Navigator)
                  error = Scaffold(body: Center(child: error));
                ErrorWidget.builder =
                    (FlutterErrorDetails errorDetails) => error;
                return widget;
              },
              theme: ThemeData(
                  brightness: WidgetsBinding.instance.window.platformBrightness,
                  fontFamily: 'CarterOne',
                  primarySwatch: Colors.red,
                  primaryColor: Color(0xFFB71C1C),
                  accentColor: Color(0xFF9E9E9E),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  iconTheme: IconThemeData(color: Colors.black),
                  textTheme: TextTheme(
                    caption: TextStyle(color: Colors.black),
                    headline6:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).apply(
                    bodyColor: Colors.red,
                    displayColor: Colors.black,
                  ),
                  buttonTheme: const ButtonThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                  )),
              home: StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, stream) {
                  final user = stream.data;

                  final state = stream.connectionState;

                  if (state == ConnectionState.waiting ||
                      state == ConnectionState.none) return LoadingScreen();

                  if (user != null) return MainScreen();

                  return AuthScreen();
                },
              ),
              routes: {
                MainScreen.routeName: (ctx) => MainScreen(),
                BodyPartsScreen.routeName: (ctx) => BodyPartsScreen(),
                SearchExercise.routeName: (ctx) => SearchExercise(),
                AddEditBodyPartsScreen.routeName: (ctx) =>
                    AddEditBodyPartsScreen(),
                ExerciseWorkOut.routeName: (ctx) => ExerciseWorkOut(),
                WorkOutScreen.routeName: (ctx) => WorkOutScreen(),
                RoutineMainScreen.routeName: (ctx) => RoutineMainScreen(),
                RoutinesScreen.routeName: (ctx) => RoutinesScreen(),
                WorkoutRoutinePicker.routeName: (ctx) => WorkoutRoutinePicker(),
                ConfigurationUserScreen.routeName: (ctx) =>
                    ConfigurationUserScreen(),
              },
            ),
          )),
    );
  }
}
