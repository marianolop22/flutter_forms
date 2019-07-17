import 'package:flutter/material.dart';
import 'package:flutter_forms/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(

      ),
      floatingActionButton: _createButton( context ),
      //esto es el contenido del ejercicio anterior
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('Email: ${bloc.email}'),
      //     Divider(),
      //     Text('Password ${bloc.password}')
      //   ],
      // ),
    );
  }

  FloatingActionButton _createButton( BuildContext context ) {
    return FloatingActionButton(
      child: Icon (Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }
}