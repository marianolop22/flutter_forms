import 'package:flutter/material.dart';
import 'package:flutter_forms/src/bloc/login_bloc.dart';
export 'package:flutter_forms/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  static Provider _instace;

  factory Provider ( { Key key, Widget child } ) {

    if (_instace == null ) {
      _instace = new Provider._internal( key: key, child:child);
    }

    return _instace;
  }

  Provider._internal ( { Key key, Widget child } ) //Constructor
    : super (key: key, child: child);

  final loginBloc = LoginBloc();

  //Se comenta esto para que al reiniciar la info persista
  // Provider( { Key key, Widget child } ) //Constructor
  //   : super (key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {

    return ( context.inheritFromWidgetOfExactType( Provider ) as Provider ).loginBloc;


  }




  

}