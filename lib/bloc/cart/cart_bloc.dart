import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc_api/bloc/login/login_bloc.dart';
import 'package:simple_bloc_api/repository/home_repositiory.dart';

import '../../controller/cart_controller.dart';
import '../../db services/db.dart';
import '../../model/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List ids = [];
  // List ids = [
  //   // {'id': "1299", "quantity": "4"},
  //   // {'id': "699", "quantity": "3"},
  //   // {'id': "1020", "quantity": "2"},
  //   // {'id': "1000", "quantity": "1"}
  // ];

  // ids.sort((a, b) => a.someProperty.compareTo(b.someProperty));
  MainCartModel? cartItems;
  CartBloc() : super(CartInitial()) {
    on<LoadCartItems>((event, emit) async {
      emit(CartLoading());

      ids = await CartController().getItemsFromTable();
      log(ids.toString(), name: 'ids');
      List<dynamic> responseData = await HomeRepository().getData(ids);
      log(responseData.toString());
      cartItems = MainCartModel.fromJson(responseData, ids);
      if (cartItems != null) {
        cartItems!.cars.isEmpty
            ? emit(CartEmpty())
            : emit(CartLoaded(cartItems: cartItems!));
      }
    });

    on<UpdateCartItems>((event, emit) async {
      if (cartItems != null) {
        CartController().updateCartItemQty(event.id, event.quantity);
        cartItems!.cars[event.index].setQty(event.quantity, event.price);
        emit(CartLoaded(cartItems: cartItems!));
      }
    });

    on<DeleteFromCart>((event, emit) async {
      if (cartItems != null) {
        CartController().deleteFromCart(event.id);
        cartItems!.cars.removeAt(event.index);
        if (cartItems!.cars.isEmpty) {
          emit(CartEmpty());
        } else {
          emit(CartLoaded(cartItems: cartItems!));
        }
      }
    });
  }
}
