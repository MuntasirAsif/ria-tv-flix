import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/app_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    if (_formKey.currentState!.validate()) {
      context.go(RouteConst.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone Number',
            style: context.textStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.verticalSpace,
          AppTextField(
            controller: _phoneController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(10),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.phone,
            hintText: 'Enter your phone number',
            prefixIcon: Container(
              padding: EdgeInsets.all(const Dimensions().padding.p4.r),
              margin: EdgeInsets.all(const Dimensions().padding.p8.r),
              decoration: BoxDecoration(
                color: context.color.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.phone_outlined, color: context.color.primary),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: FilledButton(
              onPressed: _onSendOtp,
              child: const Text('Send OTP'),
            ),
          ),
        ],
      ),
    );
  }
}
