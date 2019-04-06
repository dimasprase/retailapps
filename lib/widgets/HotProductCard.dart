import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:retailapps/models/Product.dart';
import 'package:retailapps/pages/home.dart';
import 'package:retailapps/pages/product_page.dart';

class HotProductCard extends StatefulWidget {
  final String name;
  final String id;
  final String imageUrl;
  final String price;

  HotProductCard(this.id, this.name, this.imageUrl, this.price);

  @override
  HotProductCardState createState() {
    return new HotProductCardState();
  }
}

class HotProductCardState extends State<HotProductCard> {
  @override
  Widget build(BuildContext context) {

    print("Image "+widget.imageUrl);
    return GestureDetector(
      //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProductPage(widget.name))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          overflow: Overflow.clip,
          children: <Widget>[
            Hero(
              tag: "product_${widget.id}",
              child: CachedNetworkImage(
                imageUrl: "https://s3-eu-west-1.amazonaws.com/bkt-svc-files-cmty-api-moltin-com/7a076605-8383-4578-8616-c7a308d88eea/"+widget.imageUrl+".jpg",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              color: Color(0x47000000),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.price,
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
