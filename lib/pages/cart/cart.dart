import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    List ids = [
      {'id': "1299", "quantity": "3"},
      {'id': "699", "quantity": "2"}
    ];
    context.read<CartBloc>().add(LoadCartItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text('cart'),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartEmpty || state is CartLoading) {
            return const SizedBox.shrink();
          }
          // if (state is CartLoading) {
          //   return Container(
          //     width: width,
          //     height: 2,
          //     color: Colors.purple,
          //   );
          // }

          if (state is CartLoaded) {
            double total = 0.0;

            state.cartItems.cars.forEach((e) {
              total = total + e.sub;
            });
            return Container(
              width: width,
              height: 70,
              color: Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(total.toString(), style: TextStyle(color: Colors.white))
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartEmpty) {
            return const Center(
              child: Text("Cart is Emrty"),
            );
          }
          if (state is CartLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemCount: state.cartItems.cars.length,
                      itemBuilder: (context, index) {
                        var current = state.cartItems.cars[index];
                        return cartTile(
                            width,
                            current.name,
                            current.price,
                            current.quantity,
                            current.sub.toString(),
                            current.id,
                            index);
                      })
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget cartTile(double width, String name, String price, String quantity,
      String sub, String id, int index) {
    return Container(
      width: width,
      height: 100,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(price),
                Text(id),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Expanded(child: Text(quantity)),
          Expanded(child: Text(sub)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    int qty = int.parse(quantity);
                    qty = qty + 1;
                    context.read<CartBloc>().add(UpdateCartItems(
                        id: id,
                        quantity: qty.toString(),
                        index: index,
                        price: price));
                  },
                  icon: Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    int qty = int.parse(quantity);
                    qty = qty - 1;
                    context.read<CartBloc>().add(UpdateCartItems(
                        id: id,
                        quantity: qty.toString(),
                        index: index,
                        price: price));
                  },
                  icon: Icon(Icons.minimize)),
            ],
          ),
          IconButton(
              onPressed: () {
                context.read<CartBloc>().add(DeleteFromCart(index: index));
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade600,
              ))
        ],
      ),
    );
  }
}
