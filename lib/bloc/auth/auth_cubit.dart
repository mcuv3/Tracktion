import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:twitter_login/twitter_login.dart' as tw;

part 'auth_state.dart';

enum LoginType {
  Google,
  Facebook,
  Twitter,
  CredentialsSignIn,
  CredentialsSingUp,
}

class AuthCubit extends Cubit<AuthState> {
  final SQLDatabase db;
  AuthCubit(this.db) : super(AuthInitial());

  void listenUser() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null) {
        emit(AuthSuccess(user));
      }
    });
  }

  Future<void> login({LoginType type, String email, String password}) async {
    emit(AuthLoading());

    try {
      UserCredential user;
      switch (type) {
        case LoginType.Facebook:
          user = await this._signInWithFacebook();
          break;
        case LoginType.Twitter:
          user = await this._signInWithTwitter();
          break;
        case LoginType.Google:
          user = await this._signInWithGoogle();
          break;
        case LoginType.CredentialsSignIn:
        case LoginType.CredentialsSingUp:
          user = await this._signInWithCredentials(
              email, password, type == LoginType.CredentialsSignIn);
          break;
      }
      final isNew = user.additionalUserInfo.isNewUser;
      if (isNew) await this.saveUserName(user);
      emit(AuthSuccess(user.user));
    } on FirebaseAuthException catch (e) {
      var message = "Something wen wrong, please retry later.";
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
      }
      emit(AuthFailed(message));
    } catch (e) {
      print(e);
      emit(AuthFailed("Something went really wrong."));
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> _signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> _signInWithTwitter() async {
    // Create a TwitterLogin instance
    final consumerKey = dotenv.env['TWITTER_CUSTOMER_KEY'];
    final consumerSecret = dotenv.env['TWITTER_CUSTOMER_SECRET'];

    // final TwitterLogin twitterLogin = new TwitterLogin(
    //   consumerKey: consumerKey,
    //   consumerSecret: consumerSecret,
    // );

    // Trigger the sign-in flow
    // final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    // final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    // final twitterAuthCredential = TwitterAuthProvider.credential(
    //   accessToken: twitterSession.token,
    //   secret: twitterSession.secret,
    // );

    final twitterLogin = tw.TwitterLogin(
      /// Consumer API keys
      apiKey: consumerKey,

      /// Consumer API Secret keys
      apiSecretKey: consumerSecret,

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'example://',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken, secret: authResult.authTokenSecret);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  }

  Future<UserCredential> _signInWithCredentials(
      String email, String password, bool isSignIn) async {
    final Future<UserCredential> Function({String email, String password})
        authenticate = isSignIn
            ? FirebaseAuth.instance.sendSignInLinkToEmail
            : FirebaseAuth.instance.createUserWithEmailAndPassword;

    return authenticate(email: email, password: password);
  }

  logout() async {
    emit(AuthLoading());
    await FirebaseAuth.instance.signOut();
    emit(AuthInitial());
  }

  saveUserName(UserCredential user) {
    return this.db.savePreference(
        PreferencesCompanion.insert(key: "name", value: user.user.displayName));
  }
}
