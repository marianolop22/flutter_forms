import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_forms/src/models/product_model.dart';
import 'package:flutter_forms/src/providers/products_provider.dart';
import 'package:flutter_forms/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  //const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = ProductsProvider();
  ProductModel product = new ProductModel();
  bool _saving = false;

  File photo;

  @override
  Widget build(BuildContext context) {

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;

    if ( prodData != null ) {
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,//identificador unico del formulario
            child: Column(
              children: <Widget>[
                _showPhoto(),
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) {
        product.title = value;
      },
      validator: ( value ) { //si retorno algo, es el error
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) {
        product.price = double.parse(value);
      },
      validator: (value) {
        if ( utils.isNumeric( value )) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon (Icons.save),
      onPressed: (_saving == true) ? null : _submit,
    );
  }


  Widget _createAvailable() {

    return SwitchListTile(

      value: product.available,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        product.available = value;
        setState(() {});
      },
    );
  }


  void _submit() async {
    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save(); //esto hace que se guarden los valores dentro de los campos

    _saving = true;
    setState(() {});

    if ( photo != null ) {
      product.urlPhoto = await productProvider.uploadImage(photo);
    }


    if ( product.id == null ) {
     productProvider.createProduct(product);
    } else {
      productProvider.updateProduct(product);
    }
    showSnackBar('Registro guardado');
    Navigator.pop(context);
  }

  void showSnackBar ( String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _showPhoto () {

    if (product.urlPhoto != null ) {
      return FadeInImage(
        image: NetworkImage(product.urlPhoto),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage( photo?.path ?? 'assets/no-image.png'), //el doble ?? quiere decir que si es nulo pone lo que estaá a continuación
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _selectPhoto() async{
    _processImage ( ImageSource.gallery);
  }

  _takePhoto() async {

    _processImage ( ImageSource.camera);
  }

  _processImage (ImageSource source) async {
    photo =  await ImagePicker.pickImage(
      source: source
    );
    if ( photo != null ) {
      //limpieza de cosas
      product.urlPhoto = null;
    }
    setState(() {});
  }


  
}