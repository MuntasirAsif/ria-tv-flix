import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';
import '../../../../../widgets/app_text_field.dart';
import '../../../../../widgets/custom_loading_indicator.dart';
import '../../view_model/login_view_model.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email or phone number',
            style: context.textStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.verticalSpace,
          AppTextField(
            controller: emailController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            hintText: 'Enter your email or phone number',
            prefixIcon: Container(
              padding: EdgeInsets.all(const Dimensions().padding.p4.r),
              margin: EdgeInsets.all(const Dimensions().padding.p8.r),
              decoration: BoxDecoration(
                color: context.color.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.email_outlined, color: context.color.primary),
            ),
          ),
          16.verticalSpace,
          Text(
            'Password',
            style: context.textStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.verticalSpace,
          AppTextField(
                prefixIcon: Container(
                  padding: EdgeInsets.all(const Dimensions().padding.p4.r),
                  margin: EdgeInsets.all(const Dimensions().padding.p8.r),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    color: context.color.primary,
                  ),
                ),
                controller: passwordController,
                hintText: 'Enter your password',
                enableToggleObscure: true,
                obscureIcon: const Icon(Icons.visibility_off),
                obscureIconOff: const Icon(Icons.visibility),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
          5.verticalSpace,
          Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return Checkbox(
                    value: ref.watch(loginRememberMeProvider),
                    onChanged: (value) {
                      ref.read(loginRememberMeProvider.notifier).state =
                          value ?? false;
                    },
                  );
                },
              ),
              Text('Remember me', style: context.textStyle.bodyMedium),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(RouteConst.forgotPassword),
                child: Text(
                  'Forgot password?',
                  style: context.textStyle.bodyMedium.copyWith(
                    color: context.color.primary,
                  ),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(loginViewModelProvider);
              return SizedBox(
                height: 48.h,
                child: FilledButton(
                  onPressed: () {
                    context.go(RouteConst.homeScreen);
                  },
                  child: state.when(
                    data: (data) {
                      return const Text('Sign In');
                    },
                    loading: () {
                      return const CustomLoadingIndicator();
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return const Text('Sign In');
                    },
                  ),
                ),
              );
            },
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
