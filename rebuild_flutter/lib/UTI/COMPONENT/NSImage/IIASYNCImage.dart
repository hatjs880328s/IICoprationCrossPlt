// import 'package:flutter/material.dart';

// /// 异步获取图片的 Image Widget
// class IIASYNCImage extends StatefulWidget {
  
//   /// 第一个参数时 图片id ,第二个是类型，不传时正常cell ,1是linkimg
//   IIASYNCImage(this.url, [this.imgType]);

//   final String url;

//   /// 图片类型 默认为正常cell img   1: linkcellimg
//   final int imgType;

//   @override
//   State<StatefulWidget> createState() {
//     return _IIASYNCImage();
//   }
// }

// class _IIASYNCImage extends State<IIASYNCImage> {

//   NetworkImage realImg;

//   @override
//   void initState() {
//     super.initState();
//     this.getData();
//   }

//   Future getData() async {
//     NetworkImage img;
//     if (null == widget.imgType) {
//       img = await MicroBlogBLL().getNetImage(widget.url);
//     } else if (widget.imgType == 1) {
//       img =await MicroBlogBLL().getLinkNetImage(widget.url);
//     }
//     this.realImg = img;
//     setState(() {
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (realImg == null ) {
//       return Image.asset('images/aboutus.png');
//     } else {
//       return Image(image: this.realImg, fit: BoxFit.cover);
//     }
//   }

// }