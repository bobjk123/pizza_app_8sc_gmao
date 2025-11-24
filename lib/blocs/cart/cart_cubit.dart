import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: []));

  void addToCart(Pizza pizza) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((e) => e.pizza.id == pizza.id);
    if (index >= 0) {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      items.add(CartItem(pizza: pizza, quantity: 1));
    }
    emit(state.copyWith(items: items));
  }

  void removeFromCart(Pizza pizza) {
    final items = List<CartItem>.from(state.items);
    items.removeWhere((e) => e.pizza.id == pizza.id);
    emit(state.copyWith(items: items));
  }

  void changeQuantity(Pizza pizza, int quantity) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((e) => e.pizza.id == pizza.id);
    if (index >= 0) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index] = items[index].copyWith(quantity: quantity);
      }
      emit(state.copyWith(items: items));
    }
  }

  void clear() {
    emit(const CartState(items: []));
  }
}
