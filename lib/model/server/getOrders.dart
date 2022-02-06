import 'package:fooddelivery/model/dprint.dart';
import 'package:fooddelivery/config/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils.dart';

getOrders(String uid, Function(List<OrdersData>, String) callback, Function(String) callbackError) async {

  try {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': "application/json",
      'Authorization' : "Bearer $uid",
    };

    String body = '{}';

    dprint('body: $body');
    var url = "${serverPath}getOrders";
    var response = await http.post(Uri.parse(url), headers: requestHeaders, body: body).timeout(const Duration(seconds: 30));

    dprint("getOrders");
    dprint('Response status: ${response.statusCode}');
    dprint('Response body: ${response.body}');

    if (response.statusCode == 401)
      return callbackError("401");
    if (response.statusCode == 200) {
      var jsonResult = json.decode(response.body);
      if (jsonResult["error"] == "0") {
        Response ret = Response.fromJson(jsonResult);
        callback(ret.orders, ret.currency);
      }else
        callbackError("error=${jsonResult["error"]}");
    }else
      callbackError("statusCode=${response.statusCode}");
  } catch (ex) {
    callbackError(ex.toString());
  }
}


class Response {
  String error;
  String currency;
  List<OrdersData> orders;
  Response({required this.error, required this.orders, required this.currency});
  factory Response.fromJson(Map<String, dynamic> json){
    List<OrdersData> _order = [];
    if (json['data'] != null){
      var items = json['data'];
      var t = items.map((f)=> OrdersData.fromJson(f)).toList();
      _order = t.cast<OrdersData>().toList();
    }
    return Response(
      error: json['error'].toString(),
      currency: json['currency'].toString(),
      orders: _order,
    );
  }
}

class OrdersData {
  String orderid;
  String date;
  String status;
  String statusName;
  double total;
  String restaurant;
  String name;
  double fee;
  String image;
  String curbsidePickup;
  String arrived;
  double tax;
  String percent;
  String perkm;
  List<OrderTimes> ordertimes;
  List<OrderDetails> ordersdetails;
  double destLat;
  double destLng;
  double shopLat;
  double shopLng;
  String driver;
  //
  OrdersData({required this.orderid, required this.date, required this.status, required this.total,
    required this.restaurant, required this.name, required this.image, required this.statusName,
    required this.ordertimes, required this.curbsidePickup, required this.arrived,
    required this.ordersdetails, required this.tax, required this.fee, required this.percent, required this.perkm,
    required this.destLat, required this.destLng, required this.shopLat, required this.shopLng, required this.driver});
  factory OrdersData.fromJson(Map<String, dynamic> json) {
    List<OrderTimes> _ordertimes = [];
    if (json['ordertimes'] != null){
      var items = json['ordertimes'];
      var t = items.map((f)=> OrderTimes.fromJson(f)).toList();
      _ordertimes = t.cast<OrderTimes>().toList();
    }
    List<OrderDetails> _ordersdetails = [];
    if (json['ordersdetails'] != null){
      var t = json['ordersdetails'].map((f)=> OrderDetails.fromJson(f)).toList();
      _ordersdetails = t.cast<OrderDetails>().toList();
    }

    return OrdersData(
      orderid : json['orderid'].toString(),
      date: json['date'].toString(),
      fee: toDouble(json['fee'].toString()),
      status: json['status'].toString(),
      statusName: json['statusName'].toString(),
      total: toDouble(json['total'].toString()),
      restaurant: json['restaurant'].toString(),
      name: json['name'].toString(),
      image: json['image'].toString(),
      ordertimes: _ordertimes,
      curbsidePickup: (json['curbsidePickup'] != null) ? json['curbsidePickup'].toString() : "false",
      arrived: (json['arrived'] != null) ? json['arrived'].toString() : "false",
      ordersdetails: _ordersdetails,
      tax: toDouble(json['tax'].toString()),
      percent: json['percent'].toString(),
      perkm: json['perkm'].toString(),
      destLat: toDouble(json['destLat'].toString()),
      destLng: toDouble(json['destLng'].toString()),
      shopLat: toDouble(json['shopLat'].toString()),
      shopLng: toDouble(json['shopLng'].toString()),
      driver: json['driver'].toString(),
    );
  }
}

class OrderDetails {
  String food;
  String image;
  int count;
  double foodprice;
  String extras;
  int extrascount;
  double extrasprice;
  OrderDetails({required this.food, required this.image, required this.count,
    required this.foodprice, required this.extras, required this.extrascount, required this.extrasprice});
  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      food : json['food'].toString(),
      image : json['image'].toString(),
      count : toInt(json['count'].toString()),
      foodprice : toDouble(json['foodprice'].toString()),
      extras : json['extras'].toString(),
      extrascount : toInt(json['extrascount'].toString()),
      extrasprice : toDouble(json['extrasprice'].toString()),
    );
  }
}

class OrderTimes {
  String createdAt;
  int status;
  String driver;
  String comment;
  OrderTimes({required this.createdAt, required this.status, required this.driver, required this.comment});
  factory OrderTimes.fromJson(Map<String, dynamic> json) {
    return OrderTimes(
      createdAt : json['created_at'].toString(),
      status: toInt(json['status'].toString()),
      driver: json['driver'].toString(),
      comment: json['comment'].toString(),
    );
  }
}

