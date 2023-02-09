import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api/pages/cart/cart.dart';
import 'package:simple_bloc_api/repository/home_repositiory.dart';
import 'package:simple_bloc_api/utils/utils.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api bloc call"),
        actions: [
          IconButton(
            onPressed: () => navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => CartBloc(),
                      child: Cart(),
                    ))),
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is DataLoaded) {
            return Center(
                child: Text(
              state.data,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ));
          }
          return Center(
            child: Text(
              "press button",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            context.read<HomeBloc>().add(FetchApi());
          },
          label: Text("call")),
    );
  }
}
