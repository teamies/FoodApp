import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/constants/constants.dart';
import 'package:foodapp/core/_config.dart';

import '../components/mydrawer.dart';
import '../components/mytext.dart';
import '../database/models/cart.dart';
import '../database/services/databaseManage.dart';
import 'package:foodapp/components/notification.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  List<orderCard> listMyCard = [];
  StreamSubscription<List<orderCard>>? streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = databaseManage().getOrderCard().listen((event) {
      setState(() {
        listMyCard = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar( title: titleBar('Take Order'),backgroundColor: AppColor.primaryColor,) ,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                    stream: databaseManage().getOrderCard(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            if (item.status == false) {
                              return productMyCart(item, index);
                            }
                            return Container();
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget titleBar(String title) {
    return Center(
      child: MyText.baseText(
          text: title,
          size: 20,
          color: colorWhite,
          fontWeight: FontWeight.bold),
    );
  }

  Widget productMyCart(final item, int index) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          image: NetworkImage(item.image))),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09, top: 4),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.baseText(
                              text: item.foodname,
                              color: textColor,
                              size: 14,
                              fontWeight: FontWeight.w600),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: MyText.baseText(
                                  text: 'VND ${item.price}',
                                  size: 15,
                                  color: textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible:
                                    item.mainMaterial != null ? true : false,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MyText.baseText(
                                      text: item.mainMaterial.toString(),
                                      size: 8,
                                      color: textColor,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Visibility(
                                visible: item.size != null ? true : false,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MyText.baseText(
                                      text: item.size.toString(),
                                      size: 8,
                                      color: textColor,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: MyText.baseText(
                                text: 'Số lượng: ${item.quantity}',
                                size: 15,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        bool check = true;
                        Map<String, dynamic> data = {
                          'Foodname': item.foodname,
                          'img': item.image,
                          'mainMaterial': item.mainMaterial,
                          'price': item.price,
                          'quantity': item.quantity,
                          'size': item.size,
                          'status': check,
                          'table': item.table
                        };
                        databaseManage()
                            .updateOrderCard(item.idOrderCard, data);
                        print(
                            '---------------------------------------------------');
                        print(index);
                        listMyCard.removeAt(index);

                        notification.onDelete(context);
                      });
                    },
                    child: Icon(Icons.check)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19, bottom: 19),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
            ),
          )
        ],
      ),
    );
  }
}
