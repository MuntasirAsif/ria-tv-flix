import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/static/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
          child: Column(
            children: [
              20.verticalSpace,
              _buildHeader(context),
              24.verticalSpace,
              _buildQuickAccess(context),
              24.verticalSpace,
              _buildMenuSection(context),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.color.primary.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.person, size: 30, color: context.color.primary),
        ),
        14.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Md Jahangir Alam',
                style: context.textStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              2.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.phone_android_outlined,
                    size: 13,
                    color: context.color.text.secondary.withValues(alpha: 0.6),
                  ),
                  6.horizontalSpace,
                  Text(
                    '01770636845',
                    style: context.textStyle.bodySmall.copyWith(
                      color: context.color.text.secondary.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(
          Icons.chevron_right,
          color: context.color.text.secondary.withValues(alpha: 0.4),
        ),
      ],
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    return Row(
      children: [
        _quickAccessCard(
          context,
          icon: Icons.person_outline,
          label: 'My Profile',
        ),
        12.horizontalSpace,
        _quickAccessCard(
          context,
          icon: Icons.person,
          label: 'My Subscription',
          isPremium: true,
        ),
        12.horizontalSpace,
        _quickAccessCard(
          context,
          icon: Icons.devices_outlined,
          label: 'Link Devices',
        ),
      ],
    );
  }

  Widget _quickAccessCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isPremium = false,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: isPremium
              ? const Color(0xFFFFD700).withValues(alpha: 0.1)
              : context.color.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: isPremium
              ? Border.all(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPremium
                    ? const Color(0xFFFFD700).withValues(alpha: 0.15)
                    : context.color.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isPremium
                    ? const Color(0xFFFFD700)
                    : context.color.primary,
              ),
            ),
            8.verticalSpace,
            Text(
              label,
              style: context.textStyle.labelSmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _menuItem(context, icon: Icons.checklist_outlined, title: 'Check List'),
        _menuItem(
          context,
          icon: Icons.play_circle_outline,
          title: 'Ria TV Flix',
        ),
        _menuItem(
          context,
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
        ),
        _menuItem(
          context,
          icon: Icons.shield_outlined,
          title: 'Privacy Policy',
        ),
        _menuItem(context, icon: Icons.help_outline, title: 'Help Center'),
        _menuItem(context, icon: Icons.share_outlined, title: 'Share'),
        const Divider(height: 1, thickness: 0.5),
        _menuItem(
          context,
          icon: Icons.logout,
          title: 'Logout',
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDestructive
                      ? Colors.red.withValues(alpha: 0.08)
                      : context.color.primary.withValues(alpha: 0.06),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isDestructive ? Colors.red : context.color.primary,
                ),
              ),
              14.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  style: context.textStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red : null,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: context.color.text.secondary.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
