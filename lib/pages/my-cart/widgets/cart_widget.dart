import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_core/mh_core.dart';
import 'package:mh_core/utils/global.dart';
import 'package:perfecto/constants/assets_constants.dart';
import 'package:perfecto/constants/color_constants.dart';
import 'package:perfecto/controller/home_api_controller.dart';
import 'package:perfecto/controller/user_controller.dart';
import 'package:perfecto/models/cart_model.dart';
import 'package:perfecto/models/coupon_model.dart';
import 'package:perfecto/models/user_model.dart';
import 'package:perfecto/pages/my-cart/cart_page.dart';
import 'package:perfecto/pages/product-details/product_details_page.dart';
import 'package:perfecto/shared/custom_sized_box.dart';
import 'package:perfecto/theme/theme_data.dart';
import 'package:super_banners/super_banners.dart';

import '../../product-details/product_details_controller.dart';
import '../cart_controller.dart';

class CartWidget extends StatelessWidget {
  final bool iswish;
  final WishListModel? wishListModel;
  final CartModel? cartModel;
  const CartWidget({
    super.key,
    this.iswish = false,
    this.wishListModel,
    this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xffCECECE), width: 0.2)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xffCECECE), width: 0.2), borderRadius: BorderRadius.circular(4)),
                      child: CustomNetworkImage(
                        networkImagePath:
                            wishListModel?.product?.image ?? cartModel?.product?.image ?? cartModel?.comboProduct?.image ?? cartModel?.buyGetInfo?.productForBuy?.image ?? '',
                        errorImagePath: AssetsConstant.megaDeals2,
                        borderRadius: 4,
                        height: 80,
                        width: 80,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    CustomSizedBox.space12W,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            iswish
                                ? wishListModel?.product?.name ?? '-'
                                : cartModel?.product?.name ?? cartModel?.comboProduct?.name ?? cartModel?.buyGetInfo?.productForBuy?.name ?? '-',
                            style: AppTheme.textStyleMediumBlack14,
                          ),
                          if (iswish || (!iswish && cartModel?.product != null)) CustomSizedBox.space8H,
                          Row(
                            children: [
                              if (iswish || (!iswish && cartModel?.product != null))
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(text: 'Brand:', style: AppTheme.textStyleNormalFadeBlack12),
                                  TextSpan(
                                      text: ' ${iswish ? wishListModel?.product?.brand?.name ?? '-' : cartModel?.product?.brand?.name ?? '-'}',
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12))
                                ])),
                              if (!iswish && cartModel?.size != null && !iswish && cartModel?.product != null)
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  height: 12,
                                  width: 1,
                                  color: const Color(0xffCECECE),
                                ),
                              if (!iswish && cartModel?.size != null && cartModel!.size!.name!.isNotEmpty)
                                Text('Size: ${cartModel?.size?.name ?? '-'}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                              // if (cartModel?.buyGetInfo != null && cartModel?.sizeId != null && cartModel!.sizeId!.isNotEmpty)
                              //   Text('Size: ${cartModel?.size?.name ?? '-'}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12))
                            ],
                          ),
                          if (!iswish && cartModel!.shade != null && cartModel!.shade!.name!.isNotEmpty) CustomSizedBox.space4H,
                          if (!iswish && cartModel!.shade != null && cartModel!.shade!.name!.isNotEmpty)
                            Row(
                              children: [
                                CustomNetworkImage(
                                  networkImagePath: cartModel!.shade!.image ?? '',
                                  errorImagePath: AssetsConstant.lipstickShade,
                                  height: 16,
                                  borderRadius: 2,
                                  width: 16,
                                ),
                                CustomSizedBox.space4W,
                                Text(
                                  cartModel!.shade!.name ?? 'Nude Shade Color',
                                  style: AppTheme.textStyleMediumBlack12,
                                )
                              ],
                            ),
                          if (!iswish && cartModel?.comboProduct != null) ...[
                            CustomSizedBox.space8H,
                            ...List.generate(
                              cartModel?.comboInfo?.length ?? 0,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      networkImagePath: cartModel?.comboInfo?[index].product?.image ?? '',
                                      errorImagePath: AssetsConstant.megaDeals2,
                                      height: 24,
                                      borderRadius: 2,
                                      width: 24,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartModel?.comboInfo?[index].product?.name ?? '',
                                            style: AppTheme.textStyleMediumBlack12,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          CustomSizedBox.space4H,
                                          Row(
                                            children: [
                                              // if (cartModel!.comboInfo![index].shadeId!.isNotEmpty) ...[
                                              //   CustomNetworkImage(
                                              //     networkImagePath: cartModel?.comboInfo?[index].shade?.image ?? '',
                                              //     errorImagePath: AssetsConstant.lipstickShade,
                                              //     height: 12,
                                              //     borderRadius: 2,
                                              //     width: 12,
                                              //   ),
                                              //   CustomSizedBox.space4W,
                                              // ],
                                              Expanded(
                                                child: Text(
                                                  cartModel!.comboInfo![index].sizeId!.isNotEmpty
                                                      ? "Size: ${cartModel?.comboInfo?[index].size?.name ?? '-'}"
                                                      : "Shade: ${cartModel?.comboInfo?[index].shade?.name ?? '-'}",
                                                  style: AppTheme.textStyleMediumBlack12,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          if (!iswish && cartModel?.buyGetInfo != null) ...[
                            CustomSizedBox.space8H,
                            Row(
                              children: [
                                CustomNetworkImage(
                                  networkImagePath: cartModel?.buyGetInfo?.productForGet?.image ?? '',
                                  errorImagePath: AssetsConstant.megaDeals2,
                                  height: 24,
                                  borderRadius: 2,
                                  width: 24,
                                ),
                                CustomSizedBox.space8W,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cartModel?.buyGetInfo?.productForGet?.name ?? '', style: AppTheme.textStyleMediumBlack12),
                                      if (cartModel?.buyGetInfo?.sizeForGet != null) ...[
                                        // CustomSizedBox.space4H,
                                        Text(
                                            'Size: ${cartModel?.buyGetInfo?.sizeForGet?.name ?? ''} [Get QTY- ${(cartModel!.buyGetInfo!.getQuantity!.toInt() * (cartModel!.quantity!.toDouble() / cartModel!.buyGetInfo!.buyQuantity!.toInt()).floor()).toStringAsFixed(0)}]',
                                            style: AppTheme.textStyleMediumBlack12),
                                      ],
                                      if (cartModel?.buyGetInfo?.shadeForGet != null) ...[
                                        // CustomSizedBox.space4H,
                                        Text(
                                            'Shade: ${cartModel?.buyGetInfo?.shadeForGet?.name ?? ''} [Get QTY- ${(cartModel!.buyGetInfo!.getQuantity!.toInt() * (cartModel!.quantity!.toDouble() / cartModel!.buyGetInfo!.buyQuantity!.toInt()).floor()).toStringAsFixed(0)}]',
                                            style: AppTheme.textStyleMediumBlack12),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          CustomSizedBox.space8H,
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (iswish) {
                          UserController.to.addToWish(wishListModel?.productId ?? '');
                        } else {
                          UserController.to.removeFromCart(cartModel?.id ?? '');
                        }
                      },
                      child: Image.asset(
                        AssetsConstant.deleteIcon,
                        height: 16,
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Color(0xffECECEC),
                  thickness: 1,
                ),
                CustomSizedBox.space8H,
                iswish
                    ? Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                '৳ ${wishListModel?.product?.variationType == 'shade' ? (wishListModel?.product?.productShades?[0].discountedPrice ?? '550') : (wishListModel?.product?.productSizes?[0].discountedPrice ?? '550')}',
                                style: AppTheme.textStyleSemiBoldBlack16,
                              ),
                              CustomSizedBox.space4W,
                              Text(
                                '৳${wishListModel?.product?.variationType == 'shade' ? (wishListModel?.product?.productShades?[0].shadePrice ?? '550') : (wishListModel?.product?.productSizes?[0].sizePrice ?? '55'
                                    '0')}',
                                style: const TextStyle(color: Colors.black45, fontSize: 14, decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CustomButton(
                            label: 'Move to Cart',
                            width: 150,
                            marginVertical: 0,
                            marginHorizontal: 0,
                            onPressed: () async {
                              await HomeApiController.to.productDetailsCall(wishListModel!.productId!);
                            },
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.kPrimaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (int.parse(cartModel!.quantity!) > (/*cartModel?.buyGetInfo != null ? (int.parse(cartModel!.buyGetInfo!.buyQuantity!)) : */ 1)) {
                                      final dynamic body = {
                                        // 'product_id': cartModel!.productId!,
                                        'quantity': (int.parse(cartModel!.quantity!) - (/*cartModel?.buyGetInfo != null ? (int.parse(cartModel!.buyGetInfo!.buyQuantity!)) :*/ 1))
                                            .toString(),
                                      };
                                      globalLogger.d(body,  'body');
                                      UserController.to.updateCart(body, cartModel?.id ?? '');
                                    } else {
                                      // UserController.to.removeFromCart(cartModel?.id ?? '');
                                      showSnackBar(msg: 'One Quantity is minimum');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.remove,
                                      color: int.parse(cartModel!.quantity!) == (/*cartModel?.buyGetInfo != null ? (int.parse(cartModel!.buyGetInfo!.buyQuantity!)) :*/ 1)
                                          ? AppColors.kAccentColor
                                          : AppColors.kPrimaryColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: .5,
                                  color: AppColors.kPrimaryColor,
                                  // margin: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                Container(
                                  width: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      cartModel?.quantity.toString() ?? '1',
                                      style: AppTheme.textStyleMediumBlack16,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: .5,
                                  color: AppColors.kPrimaryColor,
                                  // margin: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final dynamic body = {
                                      // 'product_id': cartModel!.productId!,
                                      'quantity': (int.parse(cartModel!.quantity!) + (/*cartModel?.buyGetInfo != null ? (int.parse(cartModel!.buyGetInfo!.buyQuantity!)) : */ 1))
                                          .toString(),
                                    };
                                    globalLogger.d(body,  'body');
                                    UserController.to.updateCart(body, cartModel?.id ?? '');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.kPrimaryColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                '৳ ${cartModel?.discountedPrice ?? '550'}',
                                style: AppTheme.textStyleSemiBoldBlack16,
                              ),
                              if (cartModel?.product != null || cartModel?.buyGetInfo != null) ...[
                                CustomSizedBox.space4W,
                                Text(
                                  '৳ ${cartModel?.price ?? '550'}',
                                  style: const TextStyle(color: Colors.black45, fontSize: 14, decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ],
                          ),
                        ],
                      )
              ],
            ),
          ),
          if (cartModel?.comboProduct != null)
            const CornerBanner(
              bannerPosition: CornerBannerPosition.topLeft,
              bannerColor: Colors.blue,
              elevation: 2,
              shadowColor: Colors.black,
              child: Text(
                "COMBO",
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (cartModel?.buyGetInfo != null)
            CornerBanner(
              bannerPosition: CornerBannerPosition.topLeft,
              bannerColor: AppColors.kOfferButtonColor,
              elevation: 2,
              shadowColor: Colors.black,
              child: Text(
                'Buy ${cartModel?.buyGetInfo?.buyQuantity ?? '1'} Get ${cartModel?.buyGetInfo?.getQuantity ?? '1'}',
                // cartModel?.buyGetInfo?.offer?.name ?? "Buy Get",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class CouponsWidget extends StatelessWidget {
  final String? img;
  final String? title;
  final String? subtitle;
  final bool isRewardPoint;
  const CouponsWidget({
    super.key,
    this.img,
    this.title,
    this.isRewardPoint = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(.24), blurRadius: 2)]),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset(
            img ?? AssetsConstant.cuppon,
            height: 32,
          ),
          CustomSizedBox.space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title ?? 'Coupons',
                      style: AppTheme.textStyleMediumBlack12,
                    ),
                    if (isRewardPoint) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset(
                          AssetsConstant.infoIcon,
                          height: 12,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          HomeApiController.to.rewardPointApply.value != '0' ? ' Applied' : '',
                          style: TextStyle(color: HomeApiController.to.rewardPointApply.value != '0' ? Colors.green : Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        );
                      }),
                    ],
                    if (!isRewardPoint)
                      Obx(() {
                        return Text(
                          HomeApiController.to.couponCode.value.isNotEmpty ? ' Applied' : '',
                          style: TextStyle(color: HomeApiController.to.couponCode.value.isNotEmpty ? Colors.green : Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                        );
                      }),
                  ],
                ),
                CustomSizedBox.space4H,
                Text(
                  subtitle ?? 'Apply now and save extra!',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.kDarkPrimaryColor),
                )
              ],
            ),
          ),
          //cancel icon
          Obx(
            () => ((isRewardPoint && HomeApiController.to.rewardPointApply.value != '0') || (!isRewardPoint && HomeApiController.to.couponCode.value.isNotEmpty))
                ? InkWell(
                    onTap: () {
                      if (isRewardPoint) {
                        HomeApiController.to.rewardPointApply.value = '0';
                      } else {
                        HomeApiController.to.couponCode.value = '';
                        HomeApiController.to.couponInfo.value = CouponModel();
                      }
                    },
                    child: const Material(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 16,
                            ),
                            Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
