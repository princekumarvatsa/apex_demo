import 'package:apex_demo/constants/font_size.dart';
import 'package:apex_demo/provider/tournaments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfiniteListview extends StatefulWidget {
  final TournamentsProvider tournament;
  final ScrollController? scrollController;
  const InfiniteListview({Key? key, required this.tournament, this.scrollController}) : super(key: key);

  @override
  State<InfiniteListview> createState() => _InfiniteListviewState();
}

class _InfiniteListviewState extends State<InfiniteListview> {
  @override
  void initState() {
    widget.scrollController!.addListener(() {
      if (widget.scrollController!.position.pixels == widget.scrollController!.position.maxScrollExtent) {
        if (widget.tournament.hasMoreData && !widget.tournament.isLoading && !widget.tournament.loadingMoreData) {
          widget.tournament.loadMoreTournaments();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _gameCards(
              title: widget.tournament.tournaments[index].name,
              subtitle: widget.tournament.tournaments[index].gameName,
              imageUrl: widget.tournament.tournaments[index].coverUrl,
            );
          },
          itemCount: widget.tournament.tournaments.length,
        ),
        (widget.tournament.hasMoreData && !widget.tournament.isLoading && !widget.tournament.httpError.hasError)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10.0.h),
                margin: EdgeInsets.only(bottom: 20.h),
                child: Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _gameCards({required String? title, required String? subtitle, required String? imageUrl}) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.h, 0.h, 25.h, 25.h),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                            fontSize: FontSize.medium,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: FontSize.small,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
