import 'package:flutter/material.dart';
import 'package:retailapps/data.dart';
import 'package:retailapps/models/Category.dart';
import 'package:retailapps/pages/category_page.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final int index;
  final Color color = Color(0xff444444);
  CategoryCard(this.name, this.description, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CategoryPage(name))),
      child: Container(
        margin: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: index == 0 ? 16.0 : 8.0,
            right: index == Data.categories.length - 1 ? 16.0 : 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Color(0x1a000000), spreadRadius: 2.0, blurRadius: 9.0)
            ]),
        width: 120.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                  description,
                  height: 24,
                  width: 24
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: color,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
