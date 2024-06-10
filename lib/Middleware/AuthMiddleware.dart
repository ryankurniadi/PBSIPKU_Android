import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Routes/PageNames.dart';
import '../Controllers/AuthController.dart';

class AuthMiddleware extends GetMiddleware{
  @override
  int? get priority =>2;

  final authC = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route){
    if(authC.isLogin.value == false){
      return RouteSettings(name: PageNames.Login);
    }
  }

  @override
  GetPage? onPageCalled(GetPage? page){

    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings){

    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuilderStart(GetPageBuilder? page){
    
    return super.onPageBuildStart(page);
  }

  @override
  Widget onPageBuilt(Widget page){
    return super.onPageBuilt(page);
  }

  @override
  void onPageDispose(){

    super.onPageDispose();
  }
}