import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/theme.dart';
import 'signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Assets.images.appLogoCom.image(width: 200.w)),
              Text(
                'Create Account',
                style: context.textStyle.headingLarge.copyWith(
                  color: context.color.primary,
                ),
              ),
              8.verticalSpace,
              Text(
                'Sign up to get started',
                style: context.textStyle.bodyMedium,
              ),
              24.verticalSpace,
              const SignUpForm(),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: context.textStyle.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () => context.go(RouteConst.login),
                    child: Text(
                      'Sign In',
                      style: context.textStyle.bodyMedium.copyWith(
                        color: context.color.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: context.color.primary,
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
