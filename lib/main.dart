import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [
    CartItem(name: 'Item 1', unitPrice: 51.0),
    CartItem(name: 'Item 2', unitPrice: 30.0),
    CartItem(name: 'Item 3', unitPrice: 43.0),
    //CartItem(name: 'Item 4', unitPrice: 25.0),
    //CartItem(name: 'Item 5', unitPrice: 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var item in cartItems)
              CartItemWidget(
                item: item,
                onAdd: () {
                  setState(() {
                    item.quantity++;
                    if (calculateTotalQuantity() == 5) {
                      showAddedToBagDialog();
                    }
                  });
                },
                onRemove: () {
                  if (item.quantity > 0) {
                    setState(() {
                      item.quantity--;
                    });
                  }
                },
              ),
            SizedBox(height: 20),
            Text('Total Amount: ${calculateTotalAmount().toStringAsFixed(2)}\$'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (calculateTotalQuantity() == 5) {
                  showCongratulatorySnackbar();
                }
              },
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var item in cartItems) {
      totalAmount += item.quantity * item.unitPrice;
    }
    return totalAmount;
  }

  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (var item in cartItems) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  void showAddedToBagDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Column(
            children: [
              Text('You have added'),
              Text('5'),
              Text('T-shirt on your bag!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showCongratulatorySnackbar() {
    final snackBar = SnackBar(
      content: Text('Congratulations! Your order has been placed.'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CartItem {
  final String name;
  final double unitPrice;
  int quantity;

  CartItem({required this.name, required this.unitPrice, this.quantity = 0});
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  CartItemWidget({
    required this.item,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onRemove,
        ),
        Text('${item.name} (${item.quantity}x)'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onAdd,
        ),
      ],
    );
  }
}
