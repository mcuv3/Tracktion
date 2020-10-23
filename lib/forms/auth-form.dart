import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/cubit/auth_cubit.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final form = GlobalKey<FormState>();
  Map<String, String> fields = {};
  var isSingUp = true;

  void submitForm() {
    final isValid = form.currentState.validate();
    if (isValid) {
      BlocProvider.of<AuthCubit>(context)
          .login(fields['email'], fields['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isSingUp ? 'Sign Up and Kill It' : 'Sign In Fella',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                      onSaved: (v) {
                        fields['email'] = v;
                      },
                      validator: (val) {
                        if (val.length < 7) return 'Must be a valid email.';
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                      cursorRadius: Radius.circular(10),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0)),
                          isDense: true,
                          hintText: 'test@test.com')),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      onSaved: (v) {
                        fields['password'] = v;
                      },
                      validator: (val) {
                        if (val.length < 7)
                          return 'Password should be at least 7 characters';
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                      cursorRadius: Radius.circular(10),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.vpn_key),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0)),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Password')),
                  SizedBox(
                    height: 10,
                  ),
                  //  if (isSingUp)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    height: isSingUp ? 80 : 0,
                    child: isSingUp
                        ? TextFormField(
                            onSaved: (v) {
                              fields['confirmPassword'] = v;
                            },
                            validator: (val) {
                              if (fields['password'] != val)
                                return 'Passwords must match';
                              return null;
                            },
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                            cursorRadius: Radius.circular(10),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.confirmation_num),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0)),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Confirm Password'))
                        : null,
                  ),

                  GestureDetector(
                    onTap: () {
                      if (isSingUp)
                        setState(() {
                          isSingUp = false;
                        });
                    },
                    child: Text('Already have an account?',
                        style: TextStyle(color: Theme.of(context).accentColor)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        color: Colors.white,
                        textColor: Colors.white,
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          if (!isSingUp)
                            setState(() {
                              isSingUp = true;
                            });
                          else
                            submitForm();
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        color: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        // borderSide: BorderSide(
                        //     color: Theme.of(context).primaryColor, width: 2.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          if (isSingUp)
                            setState(() {
                              isSingUp = false;
                            });
                          else
                            submitForm();
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}