class ProductModel {
  List<Products> products;
  Links links;
  Meta meta;

  ProductModel({this.products, this.links, this.meta});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      products = new List<Products>();
      json['data'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    // links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['data'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Products {
  int id;
  String userId;
  String title;
  String slug;
  String description;
  String make;
  String model;
  String year;
  Null color;
  Null numberOfSeats;
  Null numberOfDoors;
  Null fuelType;
  Null engineDisplacement;
  Null enginePower;
  Null transmission;
  Null registered;
  Null mileage;
  Null condition;
  String price;
  String oldPrice;
  String negotiable;
  String featured;
  String approved;
  String viewsCount;
  String createdAt;
  String updatedAt;
  List<Categories> categories;

  Products(
      {this.id,
      this.userId,
      this.title,
      this.slug,
      this.description,
      this.make,
      this.model,
      this.year,
      this.color,
      this.numberOfSeats,
      this.numberOfDoors,
      this.fuelType,
      this.engineDisplacement,
      this.enginePower,
      this.transmission,
      this.registered,
      this.mileage,
      this.condition,
      this.price,
      this.oldPrice,
      this.negotiable,
      this.featured,
      this.approved,
      this.viewsCount,
      this.createdAt,
      this.updatedAt,
      this.categories});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    color = json['color'];
    numberOfSeats = json['number_of_seats'];
    numberOfDoors = json['number_of_doors'];
    fuelType = json['fuel_type'];
    engineDisplacement = json['engine_displacement'];
    enginePower = json['engine_power'];
    transmission = json['transmission'];
    registered = json['registered'];
    mileage = json['mileage'];
    condition = json['condition'];
    price = json['price'];
    oldPrice = json['old_price'];
    negotiable = json['negotiable'];
    featured = json['featured'];
    approved = json['approved'];
    viewsCount = json['views_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['color'] = this.color;
    data['number_of_seats'] = this.numberOfSeats;
    data['number_of_doors'] = this.numberOfDoors;
    data['fuel_type'] = this.fuelType;
    data['engine_displacement'] = this.engineDisplacement;
    data['engine_power'] = this.enginePower;
    data['transmission'] = this.transmission;
    data['registered'] = this.registered;
    data['mileage'] = this.mileage;
    data['condition'] = this.condition;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['negotiable'] = this.negotiable;
    data['featured'] = this.featured;
    data['approved'] = this.approved;
    data['views_count'] = this.viewsCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Links {
  String first;
  String last;
  Null prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'] != null ? json['first'] : null;
    last = json['last'] != null ? json['last'] : null;
    // prev = json['prev'] != null ? json['prev'] : null;
    next = json['next'] != null ? json['next'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Links> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

// class Links {
//   String url;
//   String label;
//   bool active;
//
//   Links({this.url, this.label, this.active});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
