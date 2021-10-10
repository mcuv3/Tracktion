import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/user/user_cubit.dart';
import 'package:tracktion/global.dart';
import 'package:tracktion/screens/index.dart';

class WithPreferences extends StatefulWidget {
  final Widget child;
  const WithPreferences(this.child);

  @override
  _WithPreferencesState createState() => _WithPreferencesState();
}

class _WithPreferencesState extends State<WithPreferences> {
  var isLoading = true;

  @override
  void didChangeDependencies() async {
    try {
      final preferences =
          await BlocProvider.of<UserCubit>(this.context).loadUserPreferences();
      TracktionGlobals.of(context).updatePreferences(preferences);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return LoadingScreen();

    return widget.child;
  }
}
