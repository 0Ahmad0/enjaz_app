import 'package:flutter/cupertino.dart';

import '../../core/utils/assets_manager.dart';
class BaseImage extends StatelessWidget {
  const BaseImage({super.key, this.url, this.height, this.width, this.fit});
  final String? url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url??'',fit:fit,// BoxFit.fitHeight,
      height: height,
      width: width,

      // loadingBuilder:(context,widget, imageChunkEvent)=>widget,
      // frameBuilder:(context,widget,i,a)=>i!=null?widget:Image.asset(AssetsManager.providerIMG,width: width,height: height,fit: fit,),
      // errorBuilder:(context,_,__)=>Image.asset(AssetsManager.providerIMG,width: width,height: height,fit: fit,),
    );
  }
}
