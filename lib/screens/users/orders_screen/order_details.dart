import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/styles.dart';
import 'package:drawer/screens/users/orders_screen/components/orders_status.dart';
import 'package:drawer/screens/users/user_widget/order_placed_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders Details',
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ordersStatus(
                  color: redColor,
                  icons: Icons.done,
                  title: "Placed",
                  showDone: data['order_placed']),
              ordersStatus(
                  color: Colors.blue,
                  icons: Icons.thumb_up,
                  title: "Confirmend",
                  showDone: data['order_confirmed']),
              ordersStatus(
                  color: Colors.yellow,
                  icons: Icons.car_crash,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']),
              ordersStatus(
                  color: Colors.purple,
                  icons: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    orderPlaceDetails(
                        title1: 'Order Code',
                        d1: data['order_code'],
                        title2: 'Shipping Methood',
                        d2: data['shipping_method']),
                    orderPlaceDetails(
                        title1: 'Order Date',
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data['order_date'].toDate())),
                        title2: 'Payment Methood',
                        d2: data['payment_method']),
                    orderPlaceDetails(
                        title1: 'Payment Status',
                        d1: 'Unpaid',
                        title2: 'Delivery Status',
                        d2: 'Order Placed'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shipping Address',
                                style: TextStyle(fontFamily: semibold),
                              ),
                              Text(
                                '${data['order_name']}',
                                style: const TextStyle(),
                              ),
                              Text(
                                '${data['order_by_email']}',
                                style: const TextStyle(),
                              ),
                              Text(
                                '${data['order_by_address']}',
                                style: const TextStyle(),
                              ),
                              Text(
                                '${data['order_by_city']}',
                                style: const TextStyle(),
                              ),
                              Text(
                                '${data['order_by_phone']}',
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(fontFamily: semibold),
                                ),
                                Text(
                                  '${data['total_amount']}',
                                  style: const TextStyle(
                                      color: redColor, fontFamily: bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Ordered Product',
                  style: TextStyle(
                      fontFamily: semibold, fontSize: 16, color: darkFontGrey),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data['order'] != null ? data['order'].length : 0,
                  itemBuilder: (context, index) {
                    final orderItem = data['order'][index];
                    return orderPlaceDetails(
                      title1: orderItem['title'] ?? 'N/A',
                      d1: "${orderItem['qty'] ?? 0}x",
                      title2: 'Price',
                      d2: orderItem['tprice'] ?? 'N/A',
                    );
                  },
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
