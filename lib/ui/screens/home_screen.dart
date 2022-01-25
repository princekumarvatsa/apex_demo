import 'package:apex_demo/constants/font_size.dart';
import 'package:apex_demo/provider/authentication_provider.dart';
import 'package:apex_demo/provider/tournaments_provider.dart';
import 'package:apex_demo/provider/user_provider.dart';
import 'package:apex_demo/services/app_localization.dart';
import 'package:apex_demo/ui/common_widgets/infinite_listview.dart';
import 'package:apex_demo/ui/common_widgets/language_popup.dart';
import 'package:apex_demo/ui/common_widgets/popup_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final tournamentsProvider = Provider.of<TournamentsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    //If tournamentProvider is dependent on userProvider then make sure to
    //call loadTournaments after getUser
    userProvider.getUser();
    tournamentsProvider.loadTournaments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Scaffold(
        backgroundColor: const Color(0xFFF4F5FF),
        appBar: AppBar(
          title: const Text(
            "Flyingwolf",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.segment,
              color: Colors.grey[800],
            ),
            onPressed: null,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.language,
                color: Colors.grey[800],
              ),
              onPressed: () => PopupDialog.show(context, LanguagePopup.show(context)),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthenticationProvider>().logoutUser(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        body: ListView(
          controller: scrollController,
          children: [
            _userSection(context),
            _recommendedSection(context, scrollController),
          ],
        ),
      ),
    );
  }

  Widget _userSection(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return user.httpError.hasError
            ? _errorBuilder(context, user.httpError.error)
            : Column(
                children: [
                  _userDetailsSection(context, user),
                  _tournamentSummarySection(context, user),
                ],
              );
      },
    );
  }

  Widget _userDetailsSection(BuildContext context, UserProvider user) {
    return user.isLoading
        ? _loadingUserDetails()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
            child: Row(
              children: [
                SizedBox(
                  height: 0.25.sw,
                  width: 0.25.sw,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/profile.png',
                      image: user.userData!.userInfo!.imageUrl.toString(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " ${user.userData!.userInfo!.username.toString()}",
                          style: TextStyle(
                            fontSize: FontSize.header,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  user.userData!.userInfo!.eloRating.toString(),
                                  style: TextStyle(
                                    fontSize: FontSize.header,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 8.h),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Elo rating",
                                    style: TextStyle(
                                      fontSize: FontSize.medium,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _tournamentSummarySection(BuildContext context, UserProvider user) {
    return user.isLoading
        ? _loadingTournamentSummary()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tournamentColoredContainers(
                  number: user.userData!.tournamentInfo!.tournamentsPlayed.toString(),
                  label: "Tournaments played",
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  colors: const [Color(0xFFE58002), Color(0xFFECA502)],
                ),
                const SizedBox(width: 1),
                _tournamentColoredContainers(
                  number: user.userData!.tournamentInfo!.tournamentsWon.toString(),
                  label: "Tournaments won",
                  borderRadius: BorderRadius.zero,
                  colors: const [Color(0xFF6A36A6), Color(0xFF9B50BA)],
                ),
                const SizedBox(width: 1),
                _tournamentColoredContainers(
                  number: "${user.userData!.tournamentInfo!.winningPercentage.toString()}%",
                  label: "Winning percentage",
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                  colors: const [Color(0xFFEC5845), Color(0xFFEF7E4E)],
                ),
              ],
            ),
          );
  }

  Widget _loadingUserDetails() {
    return Shimmer.fromColors(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
        child: Row(
          children: [
            Container(
              height: 0.25.sw,
              width: 0.25.sw,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15.h),
                height: 0.20.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.6),
    );
  }

  Widget _loadingTournamentSummary() {
    return Shimmer.fromColors(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 25.h),
        height: 85.h,
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
      ),
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.6),
    );
  }

  Widget _tournamentColoredContainers({
    required String number,
    required String label,
    required List<Color> colors,
    required BorderRadius borderRadius,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 0.h),
        height: 85.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 20.h,
              child: Text(
                number,
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 40.h,
              child: AutoSizeText(
                label,
                maxLines: 2,
                style: TextStyle(
                  fontSize: FontSize.medium,
                  color: Colors.white,
                ),
                wrapWords: false,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendedSection(BuildContext context, ScrollController scrollController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(25.h, 25.h, 25.h, 20.h),
          child: Text(
            AppLocalization.of(context)!.translate("recommended_label"),
            style: TextStyle(
              fontSize: FontSize.header,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        _infiniteGameCards(context, scrollController),
      ],
    );
  }

  Widget _infiniteGameCards(BuildContext context, ScrollController scrollController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<TournamentsProvider>(
          builder: (context, tournament, child) {
            return tournament.isLoading
                ? _loader(context)
                : tournament.httpError.hasError == true
                    ? _errorBuilder(context, tournament.httpError.error)
                    : tournament.tournaments.isEmpty
                        ? _emptyTournament(context)
                        : InfiniteListview(tournament: tournament, scrollController: scrollController);
          },
        ),
      ],
    );
  }

  Widget _errorBuilder(BuildContext context, String error) {
    return Container(
      height: 0.2.sh,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: Center(
        child: Text(
          error,
          style: TextStyle(
            fontSize: FontSize.medium,
            color: Theme.of(context).errorColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _loader(BuildContext context) {
    return Container(
      height: 0.2.sh,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _emptyTournament(BuildContext context) {
    return Container(
      height: 0.2.sh,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: Center(
        child: Text(
          "No tournament found!",
          style: TextStyle(
            fontSize: FontSize.medium,
            color: Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
