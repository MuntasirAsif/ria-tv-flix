import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.push(RouteConst.otpScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                40.verticalSpace,
                Center(child: Assets.images.appLogoCom.image(width: 200.w)),
                10.verticalSpace,
                Text(
                  'Forgot Password',
                  style: context.textStyle.headingLarge.copyWith(
                    color: context.color.primary,
                  ),
                ),
                8.verticalSpace,
                Text(
                  'Enter your email address and we\'ll send you a code to reset your password.',
                  textAlign: TextAlign.center,
                  style: context.textStyle.bodyMedium,
                ),
                30.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: context.textStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(const Dimensions().padding.p4.r),
                    margin: EdgeInsets.all(const Dimensions().padding.p8.r),
                    decoration: BoxDecoration(
                      color: context.color.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      color: context.color.primary,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onSubmit(),
                ),
                30.verticalSpace,
                SizedBox(
                  height: 48.h,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _onSubmit,
                    child: const Text('Send Code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
