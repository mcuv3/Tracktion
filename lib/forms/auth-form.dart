import 'package:flutter/material.dart';
import 'package:tracktion/components/Buttons/GradientButton.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp,
              colors: [
                const Color.fromRGBO(201, 36, 36, 1),
                const Color.fromRGBO(58, 0, 30, 1),
              ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign Up and Kill It',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
              cursorRadius: Radius.circular(10),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'test@test.com')),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
              cursorRadius: Radius.circular(10),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Password')),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
              cursorRadius: Radius.circular(10),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.confirmation_num),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Confirm Password')),
          SizedBox(
            height: 20,
          ),
          Text('Already have an account?',
              style: TextStyle(color: Theme.of(context).accentColor)),
          SizedBox(
            height: 10,
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
                onPressed: () {},
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
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
