import 'package:retailapps/data.dart';
import 'package:retailapps/models/ShoppingBasket.dart';
import 'package:retailapps/models/wishlist.dart';
import 'package:retailapps/widgets/CategoryCard.dart';
import 'package:retailapps/widgets/CustomAppBar.dart';
import 'package:retailapps/widgets/HotProductCard.dart';
import 'package:retailapps/widgets/ProductListItem.dart';
import 'package:retailapps/request/CategoryRequest.dart';
import 'package:retailapps/request/AllProductRequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyApp extends StatefulWidget {

  static ShoppingBasket shoppingBasket = ShoppingBasket();
  static WishList wishList = WishList();

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SharedPreferences sharedPreferences;
  String access_token;

  Future<CategoryRequest> makeRequestCategory() async {

    sharedPreferences = await SharedPreferences.getInstance();
    access_token = sharedPreferences.getString("access_token");

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+access_token
    };

    final response =
    await http.get("https://api.moltin.com/v2/categories", headers: requestHeaders);

    if (response.statusCode == 200) {
      return CategoryRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post.');
    }
  }

  Future<AllProductRequest> makeRequestAllProduct() async {

    sharedPreferences = await SharedPreferences.getInstance();
    access_token = sharedPreferences.getString("access_token");

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+access_token
    };

    final response =
    await http.get("https://api.moltin.com/v2/products", headers: requestHeaders);

    if (response.statusCode == 200) {
      return AllProductRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,

        //APP BAR
        appBar: CustomAppBar((s) {
        }, scaffoldKey),

        //BODY
        body:

        //LISTVIEW CATEGORU SAMPE HOT ITEMS
        ListView(physics: ClampingScrollPhysics(),
          children: <Widget>[

            //TEXT CATEGORY
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Kategori",
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Color(0xff444444)),
              ),
            ),

            //CATEGORY CARD
            new Container(
              child: new FutureBuilder<CategoryRequest>(
                future: makeRequestCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        height: 120.0,
                        child: NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                          },
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.category == null ? 0 : snapshot.data.category.length,
                            itemBuilder: (BuildContext context, int i) =>
                                CategoryCard(snapshot.data.category[i].name, snapshot.data.category[i].description, i),
                          ),
                        ));
                  } else if (snapshot.hasError) {
                    return new Text("${snapshot.error}");
                  }
                  return new Center(
                    child: new Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new SizedBox(
                          child: CircularProgressIndicator(),
                          height: 20.0,
                          width: 20.0,
                        )
                    ),
                  );
                  // By default, show a loading spinner
                },
              ),
            ),

            //TEXT HOT ITEM
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Semua Produk",
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Color(0xff444444)),
              ),
            ),

            //GRID HOT ITEMS

            new Container(
              child: new FutureBuilder<AllProductRequest>(
                future: makeRequestAllProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.798,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        children: new List<Widget>.generate(snapshot.data.allProduct.length, (int i) {
                          return HotProductCard(snapshot.data.allProduct[i].id, snapshot.data.allProduct[i].name, snapshot.data.allProduct[i].relationships.main_image.data.id, snapshot.data.allProduct[i].meta.disPrice.without_tax.formatted);
                        }).toList(),
                        shrinkWrap: true,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return new Text("${snapshot.error}");
                  }
                  return new Center(
                    child: new Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new SizedBox(
                          child: CircularProgressIndicator(),
                          height: 20.0,
                          width: 20.0,
                        )
                    ),
                  );
                  // By default, show a loading spinner
                },
              ),
            )
          ],
        ));
  }
}
