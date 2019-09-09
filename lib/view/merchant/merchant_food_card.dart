import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/cart_model.dart';
import 'package:flutter_queue/bean/food_entity.dart';
import 'package:flutter_queue/bean/food_model.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/utils/view/customdialog.dart';
import 'package:flutter_queue/view/merchant/update_food.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MerchantFoodCard extends StatefulWidget {
  final FoodRow food;

  MerchantFoodCard(this.food);

  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<MerchantFoodCard>
    with SingleTickerProviderStateMixin {
  FoodRow get food => widget.food;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: roundedRectangle12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildImage(),
            buildTitle(),
            buildRating(),
            buildPriceInfo(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      child: /*Image.network(
        food.img!=null?food.img:"",
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height / 6,
        loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
          if (progress == null) return child;
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null),
            ),
          );
        },
      )*/
      CachedNetworkImage(
        imageUrl: food.img!=null?food.img:"",
        placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height / 6,

      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        food.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
    );
  }

  Widget buildRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar(
            initialRating: 4,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 14,
            unratedColor: Colors.black,
            itemPadding: EdgeInsets.only(right: 4.0),
            ignoreGestures: true,
            itemBuilder: (context, index) => Icon(Icons.star, color: mainColor),
            onRatingUpdate: (rating) {},
          ),
          Text('(${food.price})'),
        ],
      ),
    );
  }

  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '\￥ ${food.price}',
            style: titleStyle,
          ),
          Card(
            margin: EdgeInsets.only(right: 0),
            shape: roundedRectangle4,
            color: mainColor,
            child: InkWell(
              onTap: addItemToCard,
              splashColor: Colors.red,
              customBorder: roundedRectangle4,
              child: Icon(Icons.delete_forever),
            ),
          )
        ],
      ),
    );
  }

  addItemToCard() {
    final snackBar = SnackBar(
      content: Text('是否删除${food.name}？'),
      duration: Duration(milliseconds: 2000),
      action: SnackBarAction(
        label: "删除",
        onPressed: () {
          deleteFood(food.id);
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  ///删除菜品
  void deleteFood(String id) {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["id"] = id;
    MyNetUtil.instance.getData("foodClient/deleteFood", (value) async {
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        ToastUtils.showToast("删除成功");
      }
    }, params: map, headers: header);
  }
}
