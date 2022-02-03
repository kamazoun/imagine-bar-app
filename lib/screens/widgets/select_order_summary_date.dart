import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagine_bar/controllers/order_controller.dart';

class SelectOrderSummaryDate extends StatelessWidget {
  const SelectOrderSummaryDate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Showing summary for: ${orderController.orderSummaryDate.toLocal().toString().substring(0, 10)}'),
            OutlinedButton(
                onPressed: () async {
                  final r = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime.now(),
                  );

                  orderController.setSelectedSummaryDate(r);
                },
                child: Text('Change date'))
          ],
        ),
      ),
    );
  }
}
