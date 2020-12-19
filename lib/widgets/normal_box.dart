import 'package:flutter/material.dart';

class NormalBox extends StatelessWidget {
  final String image;
  final String title;
  final String salePrice;
  final String normalPrice;
  final Function onTap;

  const NormalBox(
      {Key key, @required this.image, @required this.title, @required this.salePrice, this.normalPrice, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      '\$$salePrice',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 12.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$$normalPrice',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
