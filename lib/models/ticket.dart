// TODO Implement this library.
class Ticket {
  ShippingAddress? shippingAddress;
  TicketTotal? ticketTotal;
  String? sId;
  UserID? userID;
  String? ticketStatus;
  List<Items>? items;
  double? totalPrice;
  String? paymentMethod;
  CouponCode? couponCode;
  String? trackingUrl;
  String? ticketDate;
  int? iV;

  Ticket(
      {this.shippingAddress,
      this.ticketTotal,
      this.sId,
      this.userID,
      this.ticketStatus,
      this.items,
      this.totalPrice,
      this.paymentMethod,
      this.couponCode,
      this.trackingUrl,
      this.ticketDate,
      this.iV});

  Ticket.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    ticketTotal = json['ticketTotal'] != null
        ? new TicketTotal.fromJson(json['ticketTotal'])
        : null;
    sId = json['_id'];
    userID =
        json['userID'] != null ? new UserID.fromJson(json['userID']) : null;
    ticketStatus = json['ticketStatus'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalPrice = json['totalPrice']?.toDouble();
    ;
    paymentMethod = json['paymentMethod'];
    couponCode = json['couponCode'] != null
        ? new CouponCode.fromJson(json['couponCode'])
        : null;
    trackingUrl = json['trackingUrl'];
    ticketDate = json['ticketDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.ticketTotal != null) {
      data['ticketTotal'] = this.ticketTotal!.toJson();
    }
    data['_id'] = this.sId;
    if (this.userID != null) {
      data['userID'] = this.userID!.toJson();
    }
    data['ticketStatus'] = this.ticketStatus;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = this.totalPrice;
    data['paymentMethod'] = this.paymentMethod;
    if (this.couponCode != null) {
      data['couponCode'] = this.couponCode!.toJson();
    }
    data['trackingUrl'] = this.trackingUrl;
    data['ticketDate'] = this.ticketDate;
    data['__v'] = this.iV;
    return data;
  }
}

class ShippingAddress {
  String? phone;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  ShippingAddress(
      {this.phone,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}

class TicketTotal {
  double? subtotal;
  double? discount;
  double? total;

  TicketTotal({this.subtotal, this.discount, this.total});

  TicketTotal.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal']?.toDouble();
    discount = json['discount']?.toDouble();
    total = json['total']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    return data;
  }
}

class UserID {
  String? sId;
  String? name;

  UserID({this.sId, this.name});

  UserID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Items {
  String? eventID;
  String? eventName;
  int? quantity;
  double? price;
  String? variant;
  String? sId;

  Items(
      {this.eventID,
      this.eventName,
      this.quantity,
      this.price,
      this.variant,
      this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    eventName = json['eventName'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();
    variant = json['variant'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventID;
    data['eventName'] = this.eventName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['variant'] = this.variant;
    data['_id'] = this.sId;
    return data;
  }
}

class CouponCode {
  String? sId;
  String? couponCode;
  String? discountType;
  int? discountAmount;

  CouponCode(
      {this.sId, this.couponCode, this.discountType, this.discountAmount});

  CouponCode.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['discountType'] = this.discountType;
    data['discountAmount'] = this.discountAmount;
    return data;
  }
}
