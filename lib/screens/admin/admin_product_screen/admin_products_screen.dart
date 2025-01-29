import 'package:drawer/consts/colors.dart';
import 'package:drawer/consts/images.dart';
import 'package:drawer/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.deepPurple[900],
        child: const Icon(Icons.add,color: whiteColor,),
        ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Products',
          style: TextStyle(fontFamily: bold, fontSize: 16, color: darkFontGrey),
        ),
        actions: [
          Text(intl.DateFormat('EEE, MMM d,' 'yy ').format(DateTime.now()))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: List.generate(30, (index)=> ListTile(
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
        ),
      ),
    );
  }
}
