import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import './screens/index.dart';
import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  //SharedPreferences.setMockInitialValues();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_connectionStatus);

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
                  title: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
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
              MainScreen.routeName: (ctx) => MainScreen(),
              BodyPartsScreen.routeName: (ctx) => BodyPartsScreen(),
              SearchExercise.routeName: (ctx) => SearchExercise(),
              AddEditBodyPartsScreen.routeName: (ctx) =>
                  AddEditBodyPartsScreen(),
              ExerciseWorkOut.routeName: (ctx) => ExerciseWorkOut(),
            },
          ),
        ));
  }
}
