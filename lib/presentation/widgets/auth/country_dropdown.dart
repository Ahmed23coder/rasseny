import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/utils/responsive_util.dart';
import '../../../core/utils/app_animations.dart';

// Re-exporting the Country type if needed, but we'll use the package's one in our state.
// Note: We are removing the custom Country class to use the package version.

class CountryDropdown extends StatelessWidget {
  final Country? selectedCountry;
  final ValueChanged<Country> onSelected;

  const CountryDropdown({
    super.key,
    this.selectedCountry,
    required this.onSelected,
  });

  void _showPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: onSelected,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        backgroundColor: AppColors.card,
        inputDecoration: InputDecoration(
          hintText: 'Search country...',
          prefixIcon: Icon(Icons.search, color: AppColors.silverPlaceholder),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.silverBorder),
          ),
          filled: true,
          fillColor: AppColors.background.withValues(alpha: 0.5),
        ),
        searchTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Inter',
        ),
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Inter',
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PressScaleAnimation(
      onTap: () => _showPicker(context),
      child: Container(
        height: context.scaleHeight(56),
        padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.silverBorder, width: 1.185),
        ),
        child: Row(
          children: [
            Text(
              selectedCountry != null
                  ? "${selectedCountry!.flagEmoji}  ${selectedCountry!.name}"
                  : "Select Country",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: context.scaleFontSize(14),
                color: selectedCountry != null 
                    ? AppColors.foreground 
                    : AppColors.silverPlaceholder,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.expand_more,
              color: AppColors.silverPlaceholder,
              size: context.scaleWidth(20),
            ),
          ],
        ),
      ),
    );
  }
}
