import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                'https://mindbodygreen-res.cloudinary.com/images/w_767,q_auto:eco,f_auto,fl_lossy/usr/RetocQT/sarah-fielding.jpg',
                height: 50.0,
                width: 50.0,
              ),
            ),
            title: Text('Emma Liam'),
            subtitle: Text('Sounds good catch uoi later...'),
            trailing: Text(
              'Just now',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
            onTap: () => Get.toNamed('/chat/conversation/$index'),
          );
        });
  }
}
