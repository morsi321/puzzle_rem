import 'package:flutter/material.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_injection.dart';
import '../../../data/model/ranked_user.dart';
import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/fonts_manager.dart';

class RankContent extends StatelessWidget {
  const RankContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sL<AuthCubit>().getRankedUsers(),
      builder: (context, snapShots) {
        if (sL<AuthCubit>().getCachedRankedUsers() != null) {
          return _getBody(sL<AuthCubit>().getCachedRankedUsers()!);
        }
        if (!snapShots.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return _getBody(snapShots.data!);
      },
    );
  }

  ListView _getBody(List<RankedUser> rankedUsers) {
    return ListView.builder(
      itemCount: rankedUsers.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        late String postNumber;
        if (index + 1 == 1) {
          postNumber = 'st';
        } else if (index + 1 == 2) {
          postNumber = 'nd';
        } else if (index + 1 == 3) {
          postNumber = 'rd';
        } else {
          postNumber = 'th';
        }

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 179, 209, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: //getRankTile(),

              Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 179, 209, 234),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
              title: Text(
                rankedUsers[index].fullName,
                style: getRegularTextStyle(fontSize: FontSize.s18),
              ),
              dense: true,
              subtitle: Text(
                'id: ${rankedUsers[index].id.toString()}',
                style: getRegularTextStyle(fontSize: FontSize.s12),
              ),
              trailing:
                  //  Container(
                  //   color: Colors.red,
                  //   width: 20.w,
                  //   height: 20.h,
                  // ),
                  SizedBox(
                width: 30.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: 19.w,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          rankedUsers[index].coins.toString(),
                          style: getRegularTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                      child: Image.asset(
                        AssetsManager.goldenCoin,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              leading: Text(
                '${index + 1}$postNumber',
                style: getRegularTextStyle(fontSize: FontSize.s14),
              ),
            ),
          ),
        );
      },
    );
  }
}
