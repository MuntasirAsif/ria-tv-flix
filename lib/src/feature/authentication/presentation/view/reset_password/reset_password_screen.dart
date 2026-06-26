import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.go(RouteConst.login);
    }
  }

  Widget _buildPrefixIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(const Dimensions().padding.p4.r),
      margin: EdgeInsets.all(const Dimensions().padding.p8.r),
      decoration: BoxDecoration(
        color: context.color.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: context.color.primary),
    );
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
                Center(child: Assets.images.appLogoCom.image(width: 200.w)),
                10.verticalSpace,
                Text(
                  'Reset Password',
                  style: context.textStyle.headingLarge.copyWith(
                    color: context.color.primary,
                  ),
                ),
                8.verticalSpace,
                Text(
                  'Enter a new password to regain access to your account.',
                  textAlign: TextAlign.center,
                  style: context.textStyle.bodyMedium,
                ),
                30.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Password',
                    style: context.textStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  controller: _passwordController,
                  hintText: 'Enter your new password',
                  obscureText: true,
                  enableToggleObscure: true,
                  prefixIcon: _buildPrefixIcon(Icons.lock_outlined),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ]),
                  textInputAction: TextInputAction.next,
                ),
                16.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Password',
                    style: context.textStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your new password',
                  obscureText: true,
                  enableToggleObscure: true,
                  prefixIcon: _buildPrefixIcon(Icons.lock_outlined),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    (value) {
                      if (value != _passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
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
                    child: const Text('Submit'),
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
