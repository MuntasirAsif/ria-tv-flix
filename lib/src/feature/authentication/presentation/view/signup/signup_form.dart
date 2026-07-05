import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/app_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    if (_formKey.currentState!.validate()) {
      context.push(RouteConst.otpScreen, extra: {
        'phone': _phoneController.text,
        'name': _nameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: context.textStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.verticalSpace,
          AppTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            prefixIcon: _buildPrefixIcon(Icons.person_outlined, context),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
            ]),
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,
          Text(
            'Phone Number',
            style: context.textStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.verticalSpace,
          AppTextField(
            controller: _phoneController,
            hintText: 'Enter your phone number',
            keyboardType: TextInputType.phone,
            prefixIcon: _buildPrefixIcon(Icons.phone_outlined, context),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(10),
              FormBuilderValidators.numeric(),
            ]),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onSendOtp(),
          ),
          30.verticalSpace,
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

  Widget _buildPrefixIcon(IconData icon, BuildContext context) {
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
}
