import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';

class MaritalStatusDropButton extends StatelessWidget {
  const MaritalStatusDropButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final read = context.read<AuthCubit>();
              return DropdownButton<int>(
                  items: _getDropdownMenuItems(),
                  onChanged: read.setmaritalStatusValue,
                  value: read.maritalStatusValue,
                  alignment: Alignment.center,
                  isExpanded: true,
                  style: getRegularTextStyle(fontSize: FontSize.s18));
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> _getDropdownMenuItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int i = 0; i < 3; i++) {
      items.add(
        DropdownMenuItem(
          value: i,
          alignment: Alignment.center,
          child: Text(StringsManager.maritalStatus[i]),
        ),
      );
    }
    return items;
  }
}
