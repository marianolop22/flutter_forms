import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_forms/src/bloc/provider.dart';
import 'package:flutter_forms/src/models/product_model.dart';
import 'package:flutter_forms/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _createList(),
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

  Widget _createList() {

    return FutureBuilder(
      future: productsProvider.loadProducts(),
      // initialData: <ProductModel>[],
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        
        if (snapshot.hasData ) {
          final productList = snapshot.data;
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: ( context, i) => _createItem(context, productList[i]),
          );
        } else  {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _createItem ( BuildContext context, ProductModel product) {

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Eliminar', style: TextStyle(color: Colors.white, fontSize: 25.0 ),),
          ],
        ),
        color: Colors.red,
      ),
      child: ListTile(
        title: Text('${product.title} - ${product.price}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
      ),
      onDismissed: ( direction ){
        //TODO delete product
        productsProvider.deleteProduct(product);
      },
    );

  }

}