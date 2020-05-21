import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

  //flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> stremFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatos => stremFirebase;

  //casos de uso
  //1. SignIn a la aplicacion de Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  signOut() {
    _auth_repository.signOut();
  }

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  //3. Agregar places
  Future<void> updatePlaceDate(Place place) => _cloudFirestoreRepository.updatePlaceDataFirestore(place);

    @override
  void dispose() {

  }

}