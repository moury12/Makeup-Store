import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mh_core/mh_core.dart';
import 'package:mh_core/utils/global.dart';
import 'package:perfecto/controller/auth_controller.dart';
import 'package:perfecto/controller/home_api_controller.dart';
import 'package:perfecto/controller/user_controller.dart';
import 'package:perfecto/pages/auth/login_page.dart';
import 'package:perfecto/pages/my-cart/cart_page.dart';
import 'package:perfecto/pages/product-details/product_details_page.dart';
import 'package:perfecto/pages/product-details/product_shade_page.dart';
import 'package:perfecto/shared/custom_sized_box.dart';
import 'package:perfecto/theme/theme_data.dart';

import '../../../constants/assets_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../models/product_model.dart';
import '../../product-details/product_details_controller.dart';

class SingleCategoryProductWidget extends StatelessWidget {
  // final bool isBestSeller;
  // final String name;
  // final String rating;
  // final String img;
  // final String price;
  // final String? buttonText;
  // final String previousPrice;
  // final bool isStacked;
  // final bool isBuy1Get1;
  // final bool isDiscount;
  // final bool isFavourite;
  // final bool isFeatured;
  // final bool isOutofStock;
  // final bool isOnSale;
  // final bool isShadeSwatch;
  final ProductModel? product;

  const SingleCategoryProductWidget({
    super.key,
    // this.isBestSeller = true,
    // required this.name,
    // required this.rating,
    // required this.img,
    // required this.price,
    // this.buttonText,
    // required this.previousPrice,
    // this.isStacked = false,
    // this.isBuy1Get1 = true,
    // this.isDiscount = true,
    // this.isFavourite = false,
    // this.isOutofStock = false,
    // this.isOnSale = false,
    // this.isFeatured = false,
    // this.isShadeSwatch = true,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await HomeApiController.to.productDetailsCall(product!.id!);
      },
      child: Stack(
        children: [
          Container(
            // width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kDarkPrimaryColor.withOpacity(.10),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                CustomNetworkImage(
                  networkImagePath: product?.image ?? '',
                  height: 168,
                  width: 200,
                  errorImagePath: AssetsConstant.megaDeals1,
                  fit: BoxFit.fill,
                  borderRadius: 10,
                ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child:
                //
                //
                //
                //   Image.network(
                //     product?.image ?? '',
                //     errorBuilder: (context, error, stackTrace) {
                //       return Image.asset(img, fit: BoxFit.fill, height: 168, width: 200);
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF2D9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: AppColors.kOfferButtonColor,
                            size: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: AppTheme.textStyleBoldBlack14,
                              children: [
                                TextSpan(
                                  text: double.parse(product?.reviewsAvgStar ?? '4.4').toStringAsFixed(2),
                                  style: AppTheme.textStyleBoldBlack10,
                                ),
                                const TextSpan(
                                  text: ' | ',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.black54),
                                ),
                                TextSpan(
                                  text: "(${(int.tryParse(product?.reviewsCount ?? '0') ?? 0) > 999 ? '${((int.tryParse(product?.reviewsCount ?? '0') ?? 0) / 1000).toStringAsFixed(1)}k' : product?.reviewsCount ?? '0'})",
                                  style: TextStyle(color: Colors.black.withOpacity(.8), fontSize: 8, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((product?.allShadesCount ?? '0') != '0')
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            CustomNetworkImage(networkImagePath: product?.productShades?[0].shade?.image ?? '', height: 13, width: 13, errorImagePath: AssetsConstant.lipstickShade, borderRadius: 2, fit: BoxFit.fill),
                            // Image.asset(
                            //   AssetsConstant.lipstickShade,
                            //   height: 13,
                            // ),
                            CustomSizedBox.space4W,
                            Text(
                              '${int.parse(product?.allShadesCount ?? '0') > 30 ? '+${product?.allShadesCount ?? '0'}' : product?.allShadesCount ?? '0'} shades',
                              style: const TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product?.name ?? '-',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'InriaSans',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if ((product?.allSizesCount ?? '0') != '0')
                        Text(
                          product?.productSizes?[0].size?.name ?? '30ml',
                          style: AppTheme.textStyleNormalBlack12,
                        ),
                      // Text(
                      //   Get.currentRoute,
                      //   style: AppTheme.textStyleNormalBlack12,
                      // ),
                      CustomSizedBox.space4H,
                      product!.offers!.offerDetails!.where((element) => element.productDetails!.offer!.offerTypeId == '3').isNotEmpty
                          ? Wrap(
                              children: product!.offers!.offerDetails!
                                  .where((element) => element.productDetails!.offer!.offerTypeId == '3')
                                  .toList()
                                  .take(2)
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                        child: Container(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6), decoration: BoxDecoration(color: AppColors.kOfferButtonColor, borderRadius: BorderRadius.circular(2)), child: Text(e.productDetails!.offer!.name!, style: AppTheme.textStyleBoldWhite10)),
                                      ))
                                  .toList(),
                            )
                          : const SizedBox.shrink(),
                      product!.isFreeDelivery == '1'
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: Container(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6), decoration: BoxDecoration(color: AppColors.kFreeDeliveryButtonColor, borderRadius: BorderRadius.circular(2)), child: const Text('Free Delivery', style: AppTheme.textStyleBoldWhite10)),
                            )
                          : const SizedBox.shrink(),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: AppTheme.textStyleBoldBlack14,
                          children: [
                            TextSpan(
                              text: '৳ ${product?.variationType == 'shade' ? (product?.productShades?[0].discountedPrice ?? '550') : (product?.productSizes?[0].discountedPrice ?? '550')}  ',
                              style: AppTheme.textStyleBoldBlack14,
                              children: (double.parse(product?.variationType == 'shade' ? (product?.productShades?[0].discountPercent ?? '0') : (product?.productSizes?[0].discountPercent ?? '0')) > 0)
                                  ? [
                                      TextSpan(
                                        text: '৳${product?.variationType == 'shade' ? (product?.productShades?[0].shadePrice ?? '550') : (product?.productSizes?[0].sizePrice ?? '55'
                                            '0')}',
                                        style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black54, fontSize: 10, fontWeight: FontWeight.normal),
                                      ),
                                      const TextSpan(
                                        text: ' | ',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Colors.black45),
                                      ),
                                      TextSpan(
                                        text: '(-${double.parse(product?.variationType == 'shade' ? (product?.productShades?[0].discountPercent ?? '0') : (product?.productSizes?[0].discountPercent ?? '0'))}% Off)',
                                        style: const TextStyle(color: Color(0xff02792A), fontSize: 10, fontWeight: FontWeight.w700),
                                      )
                                    ]
                                  : [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   width: double.infinity,
                //   height: 1,
                //   color: Colors.black.withOpacity(.1),
                // ),
                Row(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          if (AuthController.to.isLoggedIn.value) {
                            await UserController.to.addToWish(product!.id!);
                          } else {
                            Get.toNamed(LoginScreen.routeName);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.kPrimaryColor, width: .5), borderRadius: BorderRadius.circular(4)),
                          height: 38,
                          child: AuthController.to.isLoggedIn.value && UserController.to.wishList.any((element) => element.productId == product?.id)
                              ? Image.asset(
                                  AssetsConstant.favIconFill,
                                  height: 16,
                                )
                              : Image.asset(
                                  AssetsConstant.favIcon,
                                  height: 16,
                                ),
                        ),
                      );
                    }),
                    Expanded(
                      child: CustomButton(
                        label: (product?.totalStock != '0'
                            ? product?.variationType == 'shade'
                                ? 'SELECT SHADE'
                                : 'SELECT SIZE'
                            : 'OUT OF STOCK'),
                        marginHorizontal: 8,
                        marginVertical: 8,
                        height: 38,
                        elevation: 0,
                        fontSize: product?.totalStock == '0' ? 12 : null,
                        primary: product?.totalStock == '0' ? AppColors.kDarkPrimaryColor : AppColors.kPrimaryColor,
                        width: 140,
                        onPressed: product?.totalStock != '0'
                            ? /*buttonText != null
                                ? () {
                                    var snackBar = const SnackBar(content: Text('Add to Cart successfully'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                : */
                            () async {
                                // await HomeApiController.to.productDetailsCall(product!.id!);

                                Get.put(ProductDetailsController());
                                await ProductDetailsController.to.getProductDetails(product?.id ?? '30');
                                Get.to(ProductShadeScreen(
                                  isSelectSize: product?.variationType == 'shade' ? false : true,
                                ));
                              }
                            : () {},
                        // buttonText == 'ADD TO BAG'
                        //     ? () {
                        //         var snackBar = const SnackBar(content: Text('Add to Cart successfully'));
                        //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //       }
                        //     : isOutofStock
                        //         ? () {}
                        //         : () {
                        //             Get.put(ProductDetailsController());
                        //             Get.to(ProductShadeScreen(
                        //               isSelectSize: isShadeSwatch ? false : true,
                        //             ));
                        //           },
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: double.infinity,
                //   height: 1,
                //   color: Colors.black.withOpacity(.1),
                // )
              ],
            ),
          ),

          ((product?.offers?.count ?? '0') != '0') || (product?.bestSale ?? '0') == '1'
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Row(
                    children: [
                      if ((product?.bestSale ?? '0') == '1')
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xffD4F3FF),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(9), bottomRight: Radius.circular(4)),
                          ),
                          child: const Text(
                            'Bestseller',
                            style: TextStyle(color: Color(0xff0094CF), fontSize: 10),
                          ),
                        ),
                      if ((product?.offers?.count ?? '0') != '0')
                        Container(
                          padding: const EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: (product?.bestSale ?? '0') == '1' ? 1 : 0),
                          decoration: BoxDecoration(
                            color: const Color(0xffECDDFF),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular((product?.bestSale ?? '0') == '1' ? 4 : 10), bottomRight: const Radius.circular(4)),
                          ),
                          child: const Text(
                            'Offer',
                            style: TextStyle(color: Color(0xff8513DF), fontSize: 10),
                          ),
                        ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          // isStacked
          //     ? isBestSeller
          //         ? Container(
          //             padding: const EdgeInsets.all(4),
          //             decoration: const BoxDecoration(
          //               color: Color(0xffD4F3FF),
          //               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(4)),
          //             ),
          //             child: const Text(
          //               'Bestseller',
          //               style: TextStyle(color: Color(0xff0094CF), fontSize: 10),
          //             ),
          //           )
          //         : Row(
          //             children: [
          //               Container(
          //                 padding: const EdgeInsets.all(4),
          //                 decoration: const BoxDecoration(
          //                   color: Color(0xffECDDFF),
          //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(4)),
          //                 ),
          //                 child: const Text(
          //                   'Offer',
          //                   style: TextStyle(color: Color(0xff8513DF), fontSize: 10),
          //                 ),
          //               ),
          //               isFeatured
          //                   ? Container(
          //                       padding: const EdgeInsets.all(4),
          //                       /* margin: EdgeInsets.only(left: 4),*/
          //                       decoration: const BoxDecoration(
          //                         color: Color(0xffDDDCFF),
          //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
          //                       ),
          //                       child: const Text(
          //                         'Featured',
          //                         style: TextStyle(color: Color(0xff1713DF), fontSize: 10),
          //                       ),
          //                     )
          //                   : const SizedBox.shrink()
          //             ],
          //           )
          //     : const SizedBox.shrink()
        ],
      ),
    );
  }
}
