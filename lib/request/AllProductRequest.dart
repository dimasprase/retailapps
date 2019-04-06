class AllProductRequest{
  List<AllProduct> allProduct;

  AllProductRequest({this.allProduct});

  factory AllProductRequest.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['data'] as List;
    List<AllProduct> allProduct = list.map((i) => AllProduct.fromJson(i)).toList();

    return AllProductRequest(
      allProduct: allProduct,

    );
  }
}

class AllProduct{
  final String type;
  final String id;
  final String name;
  final String slug;
  final String sku;
  final bool manage_stock;
  final String description;
  List<Price> price;
  final String status;
  final String commodity_type;
  Meta meta;
  Relationships relationships;

  AllProduct({
    this.type,
    this.id,
    this.name,
    this.slug,
    this.sku,
    this.manage_stock,
    this.description,
    this.price,
    this.status,
    this.commodity_type,
    this.meta,
    this.relationships
  }) ;

  factory AllProduct.fromJson(Map<String, dynamic> json){

    var list = json['price'] as List;
    List<Price> price = list.map((i) => Price.fromJson(i)).toList();

    return new AllProduct(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      sku: json['sku'],
      description: json['description'],
      price: price,
      status: json['status'],
      commodity_type: json['commodity_type'],
      meta: Meta.fromJson(json['meta']),
      relationships: Relationships.fromJson(json['relationships']),
    );
  }
}

class Price{
  final int amount;
  final String currency;
  final bool includes_tax;

  Price({
    this.amount,
    this.currency,
    this.includes_tax,
  }) ;

  factory Price.fromJson(Map<String, dynamic> json){

    return new Price(
      amount: json['amount'],
      currency: json['currency'],
      includes_tax: json['includes_tax'],
    );
  }
}

class Meta{
  DisplayPrice disPrice;
  Stock stock;

  Meta({
    this.disPrice,
    this.stock
  }) ;

  factory Meta.fromJson(Map<String, dynamic> json){

    return new Meta(
      disPrice: DisplayPrice.fromJson(json['display_price']),
      stock: Stock.fromJson(json['stock']),
    );
  }
}

class DisplayPrice{
  WithoutTax without_tax;

  DisplayPrice({
    this.without_tax,
  }) ;

  factory DisplayPrice.fromJson(Map<String, dynamic> json){

    return new DisplayPrice(
      without_tax: WithoutTax.fromJson(json['without_tax']),
    );
  }
}

class WithoutTax{
  final int amount;
  final String currency;
  final String formatted;

  WithoutTax({
    this.amount,
    this.currency,
    this.formatted,
  }) ;

  factory WithoutTax.fromJson(Map<String, dynamic> json){

    return new WithoutTax(
      amount: json['amount'],
      currency: json['currency'],
      formatted: json['formatted'],
    );
  }
}

class Stock{
  final int level;
  final String availability;

  Stock({
    this.level,
    this.availability
  }) ;

  factory Stock.fromJson(Map<String, dynamic> json){

    return new Stock(
      level: json['level'],
      availability: json['availability']
    );
  }
}

class Relationships{
  MainImages main_image;

  Relationships({
    this.main_image
  }) ;

  factory Relationships.fromJson(Map<String, dynamic> json){

    return new Relationships(
        main_image: MainImages.fromJson(json['main_image'])
    );
  }
}

class MainImages{
  Data data;

  MainImages({
    this.data
  }) ;

  factory MainImages.fromJson(Map<String, dynamic> json){

    return new MainImages(
        data: Data.fromJson(json['data'])
    );
  }
}

class Data{
  final String id;

  Data({
    this.id
  }) ;

  factory Data.fromJson(Map<String, dynamic> json){

    return new Data(
        id: json['id']
    );
  }
}