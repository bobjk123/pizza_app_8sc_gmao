import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import '../../home/views/details_screen.dart';
import '../../../blocs/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double buttonHeight = width < 600 ? 50 : 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state.items.isEmpty) {
                      return const Center(child: Text('Your cart is empty'));
                    }
                    return ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final item = state.items[i];
                        return Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12),
                          child: ListTile(
                            leading: SizedBox(
                              width: 60,
                              child: Image.asset(
                                  'assets/images/${Uri.parse(item.pizza.picture).pathSegments.last}'),
                            ),
                            title: Text(item.pizza.name),
                            subtitle: Text(
                                '\$${item.pizza.price - (item.pizza.price * (item.pizza.discount) / 100)} x ${item.quantity}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => context
                                        .read<CartCubit>()
                                        .changeQuantity(
                                            item.pizza, item.quantity - 1),
                                    icon: const Icon(Icons.remove)),
                                Text('${item.quantity}'),
                                IconButton(
                                    onPressed: () => context
                                        .read<CartCubit>()
                                        .changeQuantity(
                                            item.pizza, item.quantity + 1),
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          DetailsScreen(item.pizza)));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${state.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: state.items.isEmpty
                            ? null
                            : () {
                                // Placeholder: implement checkout flow
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Order placed (demo)')));
                                context.read<CartCubit>().clear();
                                Navigator.of(context).pop();
                              },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const Text('Order Now',
                            style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
