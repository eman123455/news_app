import 'package:news_app/core/functions/validation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_text_field.dart';
import 'package:news_app/core/components/label.dart';
import 'package:news_app/core/functions/upload_image.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/news/news_business_logic/news_cubit/news_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/category_chips.dart';
import 'package:news_app/features/news/presentation/widgets/cover_photo_widget.dart';
import 'package:news_app/features/news/presentation/widgets/news_content.dart';
import 'package:news_app/features/news/presentation/widgets/publish_button.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';

class EditNewsView extends StatefulWidget {
  const EditNewsView({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<EditNewsView> createState() => _EditNewsViewState();
}

class _EditNewsViewState extends State<EditNewsView> {
  late TextEditingController _titleController;
  late TextEditingController _countryController;
  late TextEditingController _contentController;
  final _key = GlobalKey<FormState>();
  File? selectedImage;
  String? imageUrl;
  String? selectedCategoryId;
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.postModel.title);
    _countryController = TextEditingController(text: widget.postModel.country);
    _contentController = TextEditingController(text: widget.postModel.content);
    selectedCategoryId = widget.postModel.categoryId.toString();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit News', style: AppTextStyle.text16Regular),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.grey4E),
      ),
      body: BlocListener<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is PostNewsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMsg),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is PostNewsSuccess) {
            context.pop(true);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        final image = await pickImageFromDevice();
                        if (image == null) return;

                        final imageLink = await uploadImageToStorage(image);

                        setState(() {
                          selectedImage = image;
                          imageUrl = imageLink;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CoverPhotoWidget(
                            imageUrl: imageUrl ?? widget.postModel.imageUrl,
                            selectedImage: selectedImage,
                          ),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: () async {
                                final image = await pickImageFromDevice();
                                if (image == null) return;

                                final imageLink = await uploadImageToStorage(
                                  image,
                                );

                                setState(() {
                                  selectedImage = image;
                                  imageUrl = imageLink;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Label(title: 'Title'),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'enter title',
                      obscureText: false,
                      controller: _titleController,
                      validator: Validation.newsTitleValidator,
                    ),
                    SizedBox(height: 20.h),
                    Label(title: 'Country'),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'enter country',
                      obscureText: false,
                      controller: _countryController,
                      validator: Validation.newsCountryValidator,
                    ),
                    SizedBox(height: 20.h),
                    Label(title: 'Category'),
                    SizedBox(height: 8.h),
                    CategoryChips(
                      selectedCategoryId: selectedCategoryId,
                      onCategorySelected: (id) {
                        setState(() {
                          selectedCategoryId = id;
                        });
                      },
                    ),
                    Builder(
                      builder: (context) {
                        final error = Validation.newsCategoryValidator(selectedCategoryId);
                        return error != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Text(error, style: TextStyle(color: Colors.red, fontSize: 12)),
                              )
                            : SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 20.h),
                    Label(title: 'Content'),
                    SizedBox(height: 8.h),
                    NewsContentInput(controller: _contentController),
                    Builder(
                      builder: (context) {
                        final error = Validation.newsContentValidator(_contentController.text);
                        return error != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Text(error, style: TextStyle(color: Colors.red, fontSize: 12)),
                              )
                            : SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 32.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PublishButton(
                        onPressed: () {
                          final isValid = _key.currentState?.validate() ?? false;
                          final categoryError = Validation.newsCategoryValidator(selectedCategoryId);
                          final contentError = Validation.newsContentValidator(_contentController.text);
                          setState(() {}); 
                          if (!isValid || categoryError != null || contentError != null) return;
                          BlocProvider.of<NewsCubit>(context).updatePost(
                            postId: widget.postModel.id!,
                            title: _titleController.text,
                            content: _contentController.text,
                            imageUrl: imageUrl ?? widget.postModel.imageUrl!,
                            categoryId:
                                int.tryParse(selectedCategoryId??'1') ??
                                widget.postModel.id!,
                            country: _countryController.text,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
