import 'dart:async';

import 'package:flutter_forms/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{



  final _emailController = BehaviorSubject<String>(); //originalmente es un StreamController.broadcaste pero con la libreria de rx se cambia
  final _passwordController = BehaviorSubject<String>(); //el broadcast es para que varias instancias escuchen

  //Recuperar los datos
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform( passwordValidator );

  Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true ); //si hay data en los dos devuelve true, de lo contrario devuelve un null


  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //obtener el valor de los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close(); 
  }

}