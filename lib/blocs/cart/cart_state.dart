part of 'cart_cubit.dart';

class CartItem extends Equatable {
  final Pizza pizza;
  final int quantity;

  const CartItem({required this.pizza, required this.quantity});

  CartItem copyWith({Pizza? pizza, int? quantity}) {
    return CartItem(pizza: pizza ?? this.pizza, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [pizza, quantity];
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({required this.items});

  int get totalItems => items.fold(0, (s, e) => s + e.quantity);

  double get totalPrice => items.fold(0.0,
      (s, e) => s + (e.pizza.price - (e.pizza.price * (e.pizza.discount) / 100)) * e.quantity);

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
