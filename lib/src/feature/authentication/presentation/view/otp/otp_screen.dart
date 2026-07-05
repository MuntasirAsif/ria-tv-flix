import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/theme.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final pinFocusNode = FocusNode();

    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: context.textStyle.headingLarge.copyWith(
        color: context.color.primary,
      ),
      decoration: BoxDecoration(
        color: context.color.textFieldFillColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.color.textFieldBorderColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
          child: Column(
            children: [
              40.verticalSpace,
              Center(child: Assets.images.appLogoCom.image(width: 200.w)),
              10.verticalSpace,
              Text(
                'Verify Code',
                style: context.textStyle.headingLarge.copyWith(
                  color: context.color.primary,
                ),
              ),
              8.verticalSpace,
              Text(
                'Enter the 4-digit code sent to your phone',
                textAlign: TextAlign.center,
                style: context.textStyle.bodyMedium,
              ),
              40.verticalSpace,
              Pinput(
                controller: pinController,
                focusNode: pinFocusNode,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: context.color.primary),
                ),
                submittedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: context.color.success),
                ),
                onCompleted: (_) => context.go(RouteConst.homeScreen),
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              ),
              30.verticalSpace,
              SizedBox(
                height: 48.h,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go(RouteConst.homeScreen),
                  child: const Text('Verify'),
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: context.textStyle.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Resend',
                      style: context.textStyle.bodyMedium.copyWith(
                        color: context.color.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: context.color.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
