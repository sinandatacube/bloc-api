part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartEmpty extends CartState {}

class CartUpdate extends CartState {}

class CartLoaded extends CartState {
  MainCartModel cartItems;
  CartLoaded({required this.cartItems});
}
