import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final form = GlobalKey<FormState>();
  Map<String, String?> fields = {};
  var isSingUp = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkCredentials();
  }

  void submitForm() async {
    final isValid = form.currentState!.validate();
    if (isValid) {
      if (isSingUp) {
        BlocProvider.of<AuthCubit>(context)
            .register(fields['email']!, fields['name']!, fields['password']!);
      } else
        BlocProvider.of<AuthCubit>(context)
            .login(fields['email']!, fields['password']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
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
            Column(
              children: [
                TextFormField(
                    onChanged: (v) {
                      fields['email'] = v;
                    },
                    validator: (val) {
                      if (val != null && val.length < 7)
                        return 'Must be a valid email.';
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
                if (isSingUp)
                  TextFormField(
                      onChanged: (v) {
                        fields['name'] = v;
                      },
                      validator: (val) {
                        if (val != null && val.length < 7)
                          return 'Most be grater than 10 characters.';
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                      cursorRadius: Radius.circular(10),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.person_pin),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0)),
                          isDense: true,
                          hintText: 'Name')),
                if (isSingUp)
                  SizedBox(
                    height: 10,
                  ),
                TextFormField(
                    onChanged: (v) {
                      fields['password'] = v;
                    },
                    validator: (val) {
                      if (val != null && val.length < 7)
                        return 'Password should be at least 7 characters';
                      return null;
                    },
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                    cursorRadius: Radius.circular(10),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                          onChanged: (v) {
                            fields['confirmPassword'] = v;
                          },
                          validator: (val) {
                            if (fields['password'] != val)
                              return 'Passwords must match';
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                        if (!isSingUp) {
                          form.currentState!.reset();
                          setState(() {
                            isSingUp = true;
                          });
                        } else
                          submitForm();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          )),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        if (isSingUp) {
                          form.currentState!.reset();
                          setState(() {
                            isSingUp = false;
                          });
                        } else
                          submitForm();
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
