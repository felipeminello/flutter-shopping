import 'package:flutter/material.dart';
import 'package:shopping/models/product-details.model.dart';
import 'package:shopping/models/product-list-item.model.dart';
import 'package:shopping/repositories/product.repository.dart';
import 'package:shopping/ui/shared/widgets/add-to-cart.widget.dart';
import 'package:shopping/ui/shared/widgets/progress-indicator.widget.dart';

class ProductPage extends StatelessWidget {
  final String tag;
  final ProductRepository _repository = new ProductRepository();

  ProductPage({@required this.tag});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductDetailsModel>(
      future: _repository.get(tag),
      builder: (context, snapshot) {
        ProductDetailsModel product = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Aguardando...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: GenericProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            }
            return content(product, context);
        }

        return null;
      },
    );
  }

  Widget content(ProductDetailsModel product, context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Produto: ${product.title}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          new Expanded(
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200,
                  child: Image.network(product.images[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
          ),
          AddToCart(
            item: ProductListItemModel(
              id: product.id,
              brand: product.brand,
              title: product.title,
              price: product.price,
              tag: product.tag,
            ),
          )
        ],
      ),
    );
  }
}
