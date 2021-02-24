import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/profile_controller.dart';
import 'package:procura_online/widgets/item_box.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(
        //     Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        //   ),
        //   onPressed: () => Get.offAllNamed('/app'),
        // ),
        title: Text('Profile'),
        elevation: 0,
      ),
      body: GetX(
          init: _profileController,
          builder: (_) {
            if (_.isLoading) {
              return LinearProgressIndicator();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _.profile.user.cover.url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                _.profile.user.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text('${_.profile.user.company} - ${_.profile.user.address}'),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _.profile.data.length,
                              itemBuilder: (context, index) {
                                return ItemBox(
                                  width: double.infinity,
                                  height: 280,
                                  title: _.profile.data[index].title,
                                  salePrice: _.profile.data[index].price,
                                  normalPrice: _.profile.data[index].oldPrice,
                                  image: _.profile.data[index].mainPhoto?.bigThumb ??
                                      'https://source.unsplash.com/600x500/?bmw,audi,volvo',
                                  onTap: () => Get.toNamed('/product/${_.profile.data[index].id}'),
                                );
                              },
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
                            child: Image.network(_.profile.user.logo.thumbnail),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
