import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/colors/constants.dart';
import "package:tracktion/colors/custom_colors.dart";

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  void loginHandler(LoginType type) async {
    BlocProvider.of<AuthCubit>(context).login(
        type: type,
        email: emailController.text,
        password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: shadowList),
          child: TextFormField(
              controller: emailController,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.caption,
              cursorRadius: Radius.circular(10),
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.email,
                    size: 20,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email')),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(boxShadow: shadowList),
          child: TextFormField(
              controller: passwordController,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.caption,
              cursorRadius: Radius.circular(10),
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.security,
                    size: 20,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password')),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  )),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.routines),
              ),
              onPressed: () => loginHandler(LoginType.CredentialsSingUp),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.routines,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  )),
              child: Text(
                'Sign In',
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
              ),
              onPressed: () => loginHandler(LoginType.CredentialsSignIn),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Row(children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
          Text("OR"),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
        ]),
        SignInButtonBuilder(
          key: ValueKey("Twitter"),
          text: 'Sign in with Twitter',
          icon: FontAwesomeIcons.twitter,
          backgroundColor: Color(0xFF1DA1F2),
          onPressed: () => loginHandler(LoginType.Twitter),
        ),
        SignInButtonBuilder(
          key: ValueKey("Facebook"),
          text: "Sing in with Facebook",
          icon: FontAwesomeIcons.facebookF,
          backgroundColor: Color(0xFF3B5998),
          onPressed: () => loginHandler(LoginType.Facebook),
        ),
        SignInButtonBuilder(
          key: ValueKey("Google"),
          text: 'Sign in with Google',
          textColor: Color.fromRGBO(0, 0, 0, 0.54),
          image: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage('assets/icons/google_light.png'),
                height: 36.0,
              ),
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          onPressed: () => loginHandler(LoginType.Google),
          innerPadding: EdgeInsets.all(0),
          height: 36.0,
        )
      ],
    );
  }
}

@immutable
class SignInButtonBuilder extends StatelessWidget {
  final IconData icon;
  final Widget image;
  final bool mini;
  final String text;
  final double fontSize;
  final Color textColor,
      iconColor,
      backgroundColor,
      splashColor,
      highlightColor;
  final Function onPressed;
  final EdgeInsets padding, innerPadding;
  final ShapeBorder shape;
  final double elevation;
  final double height;
  final double width;
  SignInButtonBuilder({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.text,
    this.icon,
    this.image,
    this.fontSize = 14.0,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.splashColor = Colors.white30,
    this.highlightColor = Colors.white30,
    this.padding,
    this.innerPadding,
    this.mini = false,
    this.elevation = 2.0,
    this.shape,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      minWidth: mini ? width ?? 35.0 : null,
      height: height,
      elevation: elevation,
      padding: padding ?? EdgeInsets.all(0),
      color: backgroundColor,
      onPressed: onPressed as void Function(),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: _getButtonChild(context),
      shape: shape ?? ButtonTheme.of(context).shape,
    );
  }

  Container _getButtonChild(BuildContext context) {
    if (mini) {
      return Container(
        width: height ?? 35.0,
        height: width ?? 35.0,
        child: _getIconOrImage(),
      );
    }
    return Container(
      constraints: BoxConstraints(
        maxWidth: width ?? 220,
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: innerPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
              child: _getIconOrImage(),
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconOrImage() {
    if (image != null) {
      return image;
    }
    return Icon(
      icon,
      size: 20,
      color: this.iconColor,
    );
  }
}
