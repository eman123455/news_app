import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';

class CommentsSheet extends StatefulWidget {
  const CommentsSheet({super.key});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController controller = TextEditingController();
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  ScrollController? _listScrollController;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    if (bottomInset > 0) {
      final screenHeight = MediaQuery.of(context).size.height;

      // ✅ كبّر الشيت عشان يتسع للكيبورد
      final neededSize = (screenHeight * 0.5 + bottomInset) / screenHeight;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_sheetController.isAttached) {
          _sheetController.animateTo(
            neededSize.clamp(0.5, 0.95),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }

        // ✅ اسكرول لآخر كومنت
        if (_listScrollController?.hasClients == true) {
          _listScrollController!.animateTo(
            _listScrollController!.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }
  @override
  void dispose() {
    _listScrollController?.dispose();
    controller.dispose();
    _sheetController.dispose(); // ✅
    super.dispose();
  }

  List<Map<String, dynamic>> comments = [
    {
      "name": "Wilson Franci",
      "comment": "Lorem Ipsum is simply dummy text.",
      "isExpanded": false,
      "replies": [
        {
          "name": "Madelyn Saris",
          "comment": "Reply text here...",
          "isExpanded": false,
          "replies": [
            {
              "name": "Marley Botosh",
              "comment": "Another comment...",
              "isExpanded": false,
              "replies": [],
            },
            {
              "name": "Marley Botosh",
              "comment": "Another comment...",
              "isExpanded": false,
              "replies": [],
            },
          ],
        },
        {
          "name": "Marley Botosh",
          "comment": "Another comment...",
          "isExpanded": false,
          "replies": [],
        },
      ],
    },
    {
      "name": "Marley Botosh",
      "comment": "Another comment...",
      "isExpanded": false,
      "replies": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      shouldCloseOnMinExtent: false,
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      minChildSize: 0.5,
      controller: _sheetController, // ✅ أضف السطر ده
      builder: (context, scrollController) {
        _listScrollController = scrollController; // ✅ أضف السطر ده
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              Text(
                "Comments",
                style: TextStyle(fontSize: 18.sp, fontWeight: Fonts.bold),
              ),

              const Divider(),

              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: comments.length,
                  separatorBuilder: (context, index) =>
                      Divider(indent: 12.w, endIndent: 12.w),
                  itemBuilder: (context, index) {
                    final item = comments[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/png/test_bbc.png',
                                ),
                                radius: 20.r,
                              ),
                              SizedBox(width: 8.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"],
                                      style: const TextStyle(
                                        fontWeight: Fonts.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(item["comment"]),

                                    SizedBox(height: 8.h),

                                    /// Reply button فقط
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            // Icon(
                                            //   Icons.access_time_rounded,
                                            //   size: 14.sp,
                                            //   // color: Colors.grey,
                                            // ),
                                            // SizedBox(width: 4.w),
                                            Text(
                                              '2 hours ago',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(width: 8.w),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Icon(Icons.reply, size: 16.r),
                                              SizedBox(width: 4.w),
                                              Text("reply"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          /// زرار expand / collapse
                          if (item["replies"].isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(left: 50.w),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item["isExpanded"] = !item["isExpanded"];
                                  });
                                },
                                child: Text(
                                  item["isExpanded"]
                                      ? "Hide replies"
                                      : "See replies (${item["replies"].length})",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),

                          /// Replies (تظهر بس لما expanded)
                          if (item["isExpanded"])
                            Padding(
                              padding: EdgeInsets.only(left: 50.w, top: 8.h),
                              child: Column(
                                children: item["replies"].map<Widget>((reply) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                            'assets/images/png/test_bbc.png',
                                          ),
                                          radius: 20.r,
                                        ),
                                        SizedBox(width: 8.w),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reply["name"],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(reply["comment"]),
                                              SizedBox(height: 4.h),

                                              /// Reply button فقط
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      // Icon(
                                                      //   Icons.access_time_rounded,
                                                      //   size: 14.sp,
                                                      //   // color: Colors.grey,
                                                      // ),
                                                      // SizedBox(width: 4.w),
                                                      Text(
                                                        '2 hours ago',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// Input Field
              Padding(
                // padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                // padding: MediaQuery.of(context).viewInsets,
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
                  top: 16.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Type your comment",
                            // alignLabelWithHint: true,
                            filled: true,
                            // fillColor: Colors.grey[100],
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              // borderSide: BorderSide.none,
                              borderSide: BorderSide(
                                color: Colors.grey[300]!,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          print('------');
                          print(MediaQuery.of(context).viewInsets.bottom);
                          if (controller.text.isEmpty) return;

                          setState(() {
                            comments.add({
                              "name": "You",
                              "comment": controller.text,
                              "isExpanded": false,
                              "likes": 0,
                              "replies": [],
                            });
                          });

                          controller.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
