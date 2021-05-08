import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

enum LoginType {
  Google,
  Facebook,
  Twitter,
  CredentialsSignIn,
  CredentialsSingUp,
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
      emit(AuthSuccess(user.user));
    } on FirebaseAuthException catch (e) {
      var message = "Something wen wrong, plase retry later.";
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
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'WHy9Y7Hqybv7ehDVtj3qayERr',
      consumerSecret: '7JS0CnEA0QMiDYaVQAVafXexVgOMCWj4ZxHXUyanaEsigf17Yq',
    );

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: twitterSession.token,
      secret: twitterSession.secret,
    );

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

  logut() async {
    emit(AuthLoading());
    await FirebaseAuth.instance.signOut();
    emit(AuthInitial());
  }
}

//  Future<void> login({LoginType type, String email, String password}) async {
//     emit(AuthLoading());
//     Response response;
//     try {
//       final parserJson = json.encode({"email": email, "password": password});
//       response = await Ht.post('/api/user/token/', body: parserJson);
//     } catch (e) {
//       print(e);
//       return emit(AuthFailed());
//     }

//     if (response.statusCode == 401 || response.statusCode == 400) {
//       return emit(AuthFailed());
//     }

//     var data = json.decode(response.body);

//     final prefs = await SharedPreferences.getInstance();

//     Ht.token = data['token'];

//     await prefs.setString('token', data['token']);

//     emit(AuthSuccess(
//         email: email, token: data['token'], expiryDate: DateTime.now()));
//   }

//   Future<bool> register(String email, String name, String password) async {
//     Response res;

//     emit(AuthLoading());
//     try {
//       final parserJson =
//           json.encode({"email": email, "password": password, "name": name});
//       res = await Ht.post('/api/user/create/', body: parserJson);
//     } catch (e) {
//       print(e);
//       return true;
//     }

//     if (res.statusCode == 400) return false;

//     emit(AuthFailed());
//     return true;
//   }
