import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_repository/pizza_repository.dart';
import '../../../components/macro.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza;
  const DetailsScreen(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double contentMaxWidth = width > 900 ? 800 : width - 40;
    final double imageAspect = width > 900 ? 16 / 10 : 4 / 3;
    final double titleSize = width < 600 ? 20 : (width < 1024 ? 24 : 28);
    final double priceSize = width < 600 ? 20 : (width < 1024 ? 22 : 26);
    final double macroIconSize = width < 600 ? 16 : (width < 1024 ? 18 : 20);
    final double macroFontSize = width < 600 ? 10 : (width < 1024 ? 12 : 14);
    final double appBarTitleSize = width < 600 ? 20 : (width < 1024 ? 24 : 28);
    final double appBarIconSize = width < 600 ? 22 : (width < 1024 ? 24 : 28);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, size: appBarIconSize, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          pizza.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: appBarTitleSize,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border,
                size: appBarIconSize, color: Colors.black),
            onPressed: () {},
            tooltip: 'Favorite',
          ),
          IconButton(
            icon: Icon(Icons.share, size: appBarIconSize, color: Colors.black),
            onPressed: () {},
            tooltip: 'Share',
          ),
          IconButton(
            icon: Icon(Icons.add_shopping_cart,
                size: appBarIconSize, color: Colors.black),
            onPressed: () {},
            tooltip: 'Add to cart',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: AspectRatio(
                    aspectRatio: imageAspect,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              blurRadius: 5)
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            Uri.parse(pizza.picture).pathSegments.isNotEmpty
                                ? 'assets/images/${Uri.parse(pizza.picture).pathSegments.last}'
                                : 'assets/images/${pizza.picture}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(3, 3),
                          blurRadius: 5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                pizza.name,
                                style: TextStyle(
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${pizza.price - (pizza.price * (pizza.discount) / 100)}",
                                      style: TextStyle(
                                          fontSize: priceSize,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    Text(
                                      "\$${pizza.price}.00",
                                      style: TextStyle(
                                          fontSize: priceSize - 4,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            MyMacroWidget(
                              title: "Calories",
                              value: pizza.macros.calories,
                              icon: FontAwesomeIcons.fire,
                              iconSize: macroIconSize,
                              fontSize: macroFontSize,
                            ),
                            const SizedBox(width: 10),
                            MyMacroWidget(
                              title: "Protein",
                              value: pizza.macros.proteins,
                              icon: FontAwesomeIcons.dumbbell,
                              iconSize: macroIconSize,
                              fontSize: macroFontSize,
                            ),
                            const SizedBox(width: 10),
                            MyMacroWidget(
                              title: "Fat",
                              value: pizza.macros.fat,
                              icon: FontAwesomeIcons.oilWell,
                              iconSize: macroIconSize,
                              fontSize: macroFontSize,
                            ),
                            const SizedBox(width: 10),
                            MyMacroWidget(
                              title: "Carbs",
                              value: pizza.macros.carbs,
                              icon: FontAwesomeIcons.breadSlice,
                              iconSize: macroIconSize,
                              fontSize: macroFontSize,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: width < 600 ? 50 : 60,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width < 600 ? 18 : 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
