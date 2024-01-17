import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Pullover',
      unitPrice: 51.0,
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      // Replace with your image URL
      color: Colors.black,
      size: 'M',
    ),
    CartItem(
      name: 'T-Shirt',
      unitPrice: 35.0,
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      // Replace with your image URL
      color: Colors.black,
      size: 'M',
    ),
    CartItem(
      name: 'Sport Dress',
      unitPrice: 20.0,
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      // Replace with your image URL
      color: Colors.black,
      size: 'M',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'My Bag',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
            ),
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount: '),
                Text('${calculateTotalAmount().toStringAsFixed(2)}\$')
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrange),
                ),
                onPressed: () {
                  if (calculateTotalQuantity() == 5) {
                    showCongratulatorySnackbar();
                  }
                },
                child: const Text('CHECK OUT',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
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
          title: const Center(
              child: Text(
                'Congratulations!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              )),
          content: const SizedBox(
            height: 80,
            width: 80,
            child: Column(
              children: [
                Text(
                  'You have added',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  '5',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  'Items to your bag!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OKAY',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showCongratulatorySnackbar() {
    const snackBar = SnackBar(
      content: Text('Congratulations! Your order has been placed.'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CartItem {
  final String name;
  final double unitPrice;
  final String imageUrl;
  final Color color;
  final String size;
  int quantity;

  CartItem({
    required this.name,
    required this.unitPrice,
    required this.imageUrl,
    required this.color,
    required this.size,
    this.quantity = 0,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        const Text('Color: Black'),
                        const SizedBox(width: 16),
                        Text('Size: ${item.size}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onRemove,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 34,
                                width: 34,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.remove),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('${item.quantity}'),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: onAdd,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 34,
                                width: 34,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text('${item.unitPrice.toStringAsFixed(2)}\$'),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

