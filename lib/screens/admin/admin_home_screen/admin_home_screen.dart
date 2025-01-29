import 'package:drawer/consts/consts.dart';
import 'package:drawer/screens/admin/admin_widget/dashboard_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontFamily: bold, fontSize: 16, color: darkFontGrey),
        ),
        actions: [
          Text(intl.DateFormat('EEE, MMM d,' 'yy ').format(DateTime.now()))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: 'Products', count: '90', icon: icProducts),
                dashboardButton(context,
                    title: 'Orders', count: '27', icon: icOrders),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: 'Total Sales', count: '78888', icon: icWholeSale),
                dashboardButton(context,
                    title: 'Wishlist', count: '76', icon: icAdd)
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text('Popular Products',style: TextStyle(
                  fontFamily: bold,
                  fontSize: 20.0,
                  color: darkFontGrey
                ),),
          const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: List.generate(3, (index)=> ListTile(
                leading: Image.asset(imgS1,width: 100,height: 100,fit: BoxFit.cover,),
                title: const Text('Product title',style: TextStyle(
                  color: fontGrey,
                  fontFamily: bold
                ),),
                subtitle: const Text('\$50',style: TextStyle(
                  fontFamily: semibold,
                  color: darkFontGrey
                ),),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
