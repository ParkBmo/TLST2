import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utility/text_styles.dart';

class ProductCard extends StatelessWidget{
  const ProductCard({Key? key,
    //required this.변수명 -> ProductCard 위젯을 호출 시 사용하기 위한 파라미터. 해당 파라미터값 넣어서 호출해야함
    required this.image,
    required this.title,
    required this.brand,
    required this.onTap,
    required this.price,}) : super(key: key);

  final String image, title, brand;
  final int price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('###,###,###,###');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image(image: AssetImage("assets/images/uploadImg/${image}"), width: 160, height: 160,),
            ),
            SizedBox(height: 8,),
            Text("$title" , style: xMediumBlackTextStyle()),
            SizedBox(height: 5,),
            Text("$brand" , style: productTextStyle()),
            SizedBox(height: 5,),
            Text(numberFormat.format(price)+"원" , style: xMediumBlackTextStyle()),
          ],
        ),
      ),
    );
  }
}