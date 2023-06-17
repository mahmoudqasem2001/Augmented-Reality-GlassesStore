import 'package:flutter/material.dart';
import '../../../models/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Text('Total Price: \$${order.totalPrice}'),
        subtitle: Text(
          order.orderStatus,
          style: TextStyle(color: Colors.red),
        ),
        children: order.orderItems
            .map((prod) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prod.item.brand!.name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${prod.quantity}x \$${prod.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
            ))
            .toList(),
      ),
    );
  }
}
