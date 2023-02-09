part of 'cart_bloc.dart';

// =["678","3220","750","1299"]
@immutable
abstract class CartEvent {}

class LoadCartItems extends CartEvent {}

class DeleteFromCart extends CartEvent {
  final int index;
  DeleteFromCart({required this.index});
}

class UpdateCartItems extends CartEvent {
  String id;
  String quantity;
  String price;
  int index;

  UpdateCartItems(
      {required this.id,
      required this.quantity,
      required this.index,
      required this.price});
}
