<<<<<<< Updated upstream
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/account_setup/account_setup_business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/data/countries_data.dart';
import 'package:news_app/features/account_setup/data/models/news_source_model.dart';
import 'package:news_app/features/account_setup/data/news_topics_data.dart';

class AcountSetup extends StatelessWidget {
  const AcountSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupCubit, AccountSetupState>(
      builder: (context, state) {
        final s = state as AccountSetupUiState;
        final titles = [
          'Select your Country',
          'Choose your Topics',
          'Choose your News Sources',
          'Fill your Profile',
        ];
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                if (s.stepIndex == 0) {
                  context.go(AppRoutes.kSignUp);
                } else {
                  context.read<AccountSetupCubit>().goBack();
                }
              },
            ),
            title: Text(
              titles[s.stepIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: Fonts.semiBold,
                fontSize: 17.sp,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: s.stepIndex,
                      children: [
                        _CountryStep(state: s),
                        _TopicsStep(state: s),
                        _SourcesStep(state: s),
                        _ProfileStep(state: s),
                      ],
                    ),
                  ),
                  _NextBar(
                    state: s,
                    isLast: s.stepIndex == 3,
                    onNext: () async {
                      final cubit = context.read<AccountSetupCubit>();
                      if (s.stepIndex == 3) {
                        if (cubit.validateProfileStep()) {
                          await cubit.submitAccountSetupToSupabase();
                          final nextState = cubit.state as AccountSetupUiState;
                          if (nextState.submitError == null) {
                            if (context.mounted) {
                              context.go(AppRoutes.kHomePage);
                            }
                          }
                        }
                      } else {
                        await cubit.goNext();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NextBar extends StatelessWidget {
  const _NextBar({
    required this.state,
    required this.isLast,
    required this.onNext,
  });

  final AccountSetupUiState state;
  final bool isLast;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountSetupCubit>();
    final busyOnSources =
        state.stepIndex == 2 && state.sourcesLoading;
    final busySubmitting = (state.isSubmitting ?? false) && isLast;
    final enabled =
        (isLast ? true : cubit.canAdvanceFromCurrentStep()) &&
            !busyOnSources &&
            !busySubmitting;
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: FilledButton(
        onPressed: enabled ? onNext : null,
        style: FilledButton.styleFrom(
          disabledBackgroundColor: AppColors.navBarBlue.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.8),
          backgroundColor: AppColors.navBarBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: Text(
          isLast ? 'Done' : 'Next',
          style: TextStyle(
            fontWeight: Fonts.semiBold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class _CountryStep extends StatefulWidget {
  const _CountryStep({required this.state});

  final AccountSetupUiState state;

  @override
  State<_CountryStep> createState() => _CountryStepState();
}

class _CountryStepState extends State<_CountryStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.state.countrySearch);
  }

  @override
  void didUpdateWidget(covariant _CountryStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.countrySearch != _controller.text &&
        widget.state.countrySearch !=
            oldWidget.state.countrySearch) {
      _controller.text = widget.state.countrySearch;
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.state.countrySearch.trim().toLowerCase();
    final items = kAccountSetupCountries
        .where(
          (c) => q.isEmpty || c.name.toLowerCase().contains(q),
        )
        .toList();
    final cubit = context.read<AccountSetupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          onChanged: cubit.setCountrySearch,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: const Color(0xffF5F5F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(height: 8.h),
            itemBuilder: (context, i) {
              final c = items[i];
              final sel =
                  widget.state.selectedCountryCode == c.code;
              final flag = flagEmojiForCountryCode(c.code);
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () => cubit.selectCountry(code: c.code, name: c.name),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.navBarBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: sel
                            ? AppColors.navBarBlue
                            : const Color(0xffE8E8ED),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(flag, style: TextStyle(fontSize: 22.sp)),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            c.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: Fonts.regular,
                              color: sel ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TopicsStep extends StatefulWidget {
  const _TopicsStep({required this.state});

  final AccountSetupUiState state;

  @override
  State<_TopicsStep> createState() => _TopicsStepState();
}

class _TopicsStepState extends State<_TopicsStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.state.topicSearch);
  }

  @override
  void didUpdateWidget(covariant _TopicsStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.topicSearch != _controller.text &&
        widget.state.topicSearch != oldWidget.state.topicSearch) {
      _controller.text = widget.state.topicSearch;
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.state.topicSearch.trim().toLowerCase();
    final topics = kNewsTopicOptions
        .where(
          (t) => q.isEmpty || t.label.toLowerCase().contains(q),
        )
        .toList();
    final cubit = context.read<AccountSetupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          onChanged: cubit.setTopicSearch,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: const Color(0xffF5F5F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: topics.map((t) {
                final sel = widget.state.selectedCategories
                    .contains(t.apiCategory);
                return GestureDetector(
                  onTap: () => cubit.toggleTopicCategory(t.apiCategory),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          sel ? AppColors.navBarBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: AppColors.navBarBlue, width: 1.5),
                    ),
                    child: Text(
                      t.label,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: Fonts.medium,
                        color: sel ? Colors.white : AppColors.navBarBlue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SourcesStep extends StatefulWidget {
  const _SourcesStep({required this.state});

  final AccountSetupUiState state;

  @override
  State<_SourcesStep> createState() => _SourcesStepState();
}

class _SourcesStepState extends State<_SourcesStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.state.sourceSearch);
  }

  @override
  void didUpdateWidget(covariant _SourcesStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.sourceSearch != _controller.text &&
        widget.state.sourceSearch != oldWidget.state.sourceSearch) {
      _controller.text = widget.state.sourceSearch;
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountSetupCubit>();
    final q = widget.state.sourceSearch.trim().toLowerCase();
    List<NewsSourceModel> list = widget.state.sources;
    if (q.isNotEmpty) {
      list = list
          .where((e) => e.name.toLowerCase().contains(q))
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          onChanged: cubit.setSourceSearch,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: const Color(0xffF5F5F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          ),
        ),
        SizedBox(height: 12.h),
        if (widget.state.sourcesError != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              widget.state.sourcesError!,
              style: TextStyle(color: Colors.red.shade700, fontSize: 13.sp),
            ),
          ),
        Expanded(
          child: widget.state.sourcesLoading
              ? const Center(child: CircularProgressIndicator())
              : list.isEmpty
                  ? Center(
                      child: Text(
                        widget.state.sourcesError != null
                            ? 'Could not load sources'
                            : 'No sources for this country',
                        style: TextStyle(color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        final src = list[i];
                        final following = widget.state.followedSourceIds
                            .contains(src.id);
                        return _SourceCard(
                          source: src,
                          following: following,
                          onToggle: () => cubit.toggleFollowSource(src.id),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

class _SourceLogo extends StatefulWidget {
  const _SourceLogo({
    required this.sourceUrl,
    required this.letter,
    required this.size,
  });

  final String sourceUrl;
  final String letter;
  final double size;

  static Widget letterFallback(String letter, double size) {
    return Center(
      child: Text(
        letter,
        style: TextStyle(
          color: AppColors.navBarBlue,
          fontWeight: Fonts.bold,
          fontSize: size * 0.38,
        ),
      ),
    );
  }

  @override
  State<_SourceLogo> createState() => _SourceLogoState();
}

class _SourceLogoState extends State<_SourceLogo> {
  static const _headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0 Safari/537.36',
  };

  int _i = 0;

  String? _host(String raw) {
    try {
      var u = Uri.parse(raw.trim());
      if (u.host.isEmpty) u = Uri.parse('https://$raw');
      var h = u.host.toLowerCase();
      if (h.startsWith('www.')) h = h.substring(4);
      return h.isEmpty ? null : h;
    } catch (_) {
      return null;
    }
  }

  List<String> _urls(String host) => [
        'https://icon.horse/icon/$host',
        'https://www.google.com/s2/favicons?domain=$host&sz=128',
      ];

  @override
  Widget build(BuildContext context) {
    final host = _host(widget.sourceUrl);
    if (host == null) {
      return _SourceLogo.letterFallback(widget.letter, widget.size);
    }
    final urls = _urls(host);
    if (_i >= urls.length) {
      return _SourceLogo.letterFallback(widget.letter, widget.size);
    }
    return ClipOval(
      child: Image.network(
        urls[_i],
        width: widget.size,
        height: widget.size,
        fit: BoxFit.cover,
        headers: _headers,
        gaplessPlayback: true,
        errorBuilder: (_, _, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _i++);
          });
          final last = _i >= urls.length - 1;
          return last
              ? _SourceLogo.letterFallback(widget.letter, widget.size)
              : SizedBox(width: widget.size, height: widget.size);
        },
        loadingBuilder: (_, child, p) =>
            p == null ? child : SizedBox(width: widget.size, height: widget.size),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.source,
    required this.following,
    required this.onToggle,
  });

  final NewsSourceModel source;
  final bool following;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final letter = source.name.isNotEmpty
        ? source.name[0].toUpperCase()
        : '?';
    final sourceUrl = (source.url ?? '').trim();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffE8E8ED)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor:
                AppColors.navBarBlue.withValues(alpha: 0.12),
            child: sourceUrl.isEmpty
                ? Text(
                    letter,
                    style: TextStyle(
                      color: AppColors.navBarBlue,
                      fontWeight: Fonts.bold,
                      fontSize: 20.sp,
                    ),
                  )
                : _SourceLogo(
                    sourceUrl: sourceUrl,
                    letter: letter,
                    size: 52.r,
                  ),
          ),
          Text(
            source.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: Fonts.medium,
              color: Colors.black87,
              height: 1.1,
            ),
          ),
          SizedBox(
            height: 30.h,
            child: OutlinedButton(
              onPressed: onToggle,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(double.infinity, 28.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor:
                    following ? Colors.white : AppColors.navBarBlue,
                backgroundColor:
                    following ? AppColors.navBarBlue : Colors.white,
                side: const BorderSide(color: AppColors.navBarBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                following ? 'Following' : 'Follow',
                style: TextStyle(fontSize: 10.sp, fontWeight: Fonts.semiBold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStep extends StatelessWidget {
  const _ProfileStep({required this.state});

  final AccountSetupUiState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountSetupCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 56.r,
                backgroundColor: const Color(0xffE8E8ED),
                child: Icon(Icons.person, size: 56.sp, color: Colors.grey),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Material(
                  color: AppColors.navBarBlue,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 18.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 28.h),
          _LabeledField(
            label: 'Username',
            hint: 'Username',
            value: state.username,
            onChanged: cubit.setUsername,
            requiredMark: false,
            keyboard: TextInputType.text,
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Full Name',
            hint: 'Full name',
            value: state.fullName,
            onChanged: cubit.setFullName,
            requiredMark: false,
            keyboard: TextInputType.name,
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Email Address',
            hint: 'Email',
            value: state.email,
            onChanged: cubit.setEmail,
            requiredMark: true,
            keyboard: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Phone Number',
            hint: 'Phone',
            value: state.phone,
            onChanged: cubit.setPhone,
            requiredMark: true,
            keyboard: TextInputType.phone,
          ),
          if (state.profileError != null) ...[
            SizedBox(height: 12.h),
            Text(
              state.profileError!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (state.submitError != null) ...[
            SizedBox(height: 12.h),
            Text(
              state.submitError!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _LabeledField extends StatefulWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    required this.requiredMark,
    required this.keyboard,
  });

  final String label;
  final String hint;
  final String value;
  final ValueChanged<String> onChanged;
  final bool requiredMark;
  final TextInputType keyboard;

  @override
  State<_LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<_LabeledField> {
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _LabeledField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _c.text && widget.value != oldWidget.value) {
      _c.text = widget.value;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: Fonts.semiBold,
                fontSize: 14.sp,
              ),
            ),
            if (widget.requiredMark)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: Fonts.bold,
                  fontSize: 14.sp,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _c,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboard,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xffD0D0D8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xffD0D0D8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:
                  const BorderSide(color: AppColors.navBarBlue, width: 1.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }
}
>>>>>>> Stashed changes
