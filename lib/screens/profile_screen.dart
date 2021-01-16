import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/item_box.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              ),
              onPressed: () => Get.offNamed('/app'),
            ),
            title: Text('Profile'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://marsemfim.com.br/wp-content/uploads/2019/04/oceano.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              _.userData?.name ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                              '${_.userData?.billingCity ?? ''} - ${_.userData?.billingCountry ?? ''}'),
                          SizedBox(height: 20),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ItemBox(
                                width: double.infinity,
                                height: 280,
                                title: 'Carro um dois três',
                                salePrice: '22000',
                                normalPrice: '22000',
                                image:
                                    'https://procuraonline-dev.pt/storage/6/conversions/listing-c-6-big_thumb.jpg',
                                onTap: () => Get.offNamed(
                                  '/product/2',
                                  arguments: {'canPushBack': true},
                                ),
                              ),
                              ItemBox(
                                width: double.infinity,
                                height: 280,
                                title: 'Carro um dois três',
                                salePrice: '22000',
                                normalPrice: '22000',
                                image:
                                    'https://procuraonline-dev.pt/storage/6/conversions/listing-c-6-big_thumb.jpg',
                                onTap: () => Get.toNamed('/product/1'),
                              ),
                              ItemBox(
                                width: double.infinity,
                                height: 280,
                                title: 'Carro um dois três',
                                salePrice: '22000',
                                normalPrice: '22000',
                                image:
                                    'https://procuraonline-dev.pt/storage/6/conversions/listing-c-6-big_thumb.jpg',
                                onTap: () => Get.toNamed('/product/1'),
                              ),
                              ItemBox(
                                width: double.infinity,
                                height: 280,
                                title: 'Carro um dois três',
                                salePrice: '22000',
                                normalPrice: '22000',
                                image:
                                    'https://procuraonline-dev.pt/storage/6/conversions/listing-c-6-big_thumb.jpg',
                                onTap: () => Get.toNamed('/product/1'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 100,
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 4)),
                        child: ClipOval(
                          child: Image.network('https://i.pravatar.cc/200'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
