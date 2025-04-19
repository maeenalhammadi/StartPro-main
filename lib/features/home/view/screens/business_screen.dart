import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/constants/env.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/features/home/models/business.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BusinessScreen extends StatelessWidget {
  static const String route = '/business';

  final BusinessModel business;

  const BusinessScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  business.imageUrl != null
                      ? Hero(
                        tag: business.imageUrl!,
                        child: CachedNetworkImage(
                          imageUrl: Env.strapiUrl + business.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color: AppColors.kSurfaceColorLight,
                                child: Center(
                                  child: Icon(
                                    Icons.business,
                                    size: 48.w,
                                    color: AppColors.kTextTertiaryColor,
                                  ),
                                ),
                              ),
                        ),
                      )
                      : Container(
                        color: AppColors.kSurfaceColorLight,
                        child: Center(
                          child: Icon(
                            Icons.business,
                            size: 48.w,
                            color: AppColors.kTextTertiaryColor,
                          ),
                        ),
                      ),
            ),
          ),

          // Business Info
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    business.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Type Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      business.typeLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  Text(
                    business.description ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.kTextSecondaryColor,
                      height: 1.5,
                    ),
                  ),

                  // Divider
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Divider(
                      color: AppColors.kTextTertiaryColor.withAlpha(20),
                    ),
                  ),

                  // Markdown Content with enhanced styling
                  MarkdownBody(
                    data: business.content,
                    styleSheet: MarkdownStyleSheet(
                      // Heading Styles
                      h1: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      h2: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      h3: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      h4: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      h5: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      h6: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                        height: 1.4,
                      ),
                      // Paragraph and text styles
                      p: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kTextSecondaryColor,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                      // List styles
                      listBullet: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kPrimaryColor,
                      ),
                      // Code blocks
                      code: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.kTextColor,
                        backgroundColor: AppColors.kSurfaceColorLight,
                        fontFamily: 'monospace',
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: AppColors.kSurfaceColorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Blockquotes
                      blockquote: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kTextTertiaryColor,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                      blockquoteDecoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppColors.kPrimaryColor,
                            width: 4,
                          ),
                        ),
                      ),
                      // Links
                      a: TextStyle(
                        color: AppColors.kPrimaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kPrimaryColor.withAlpha(40),
                      ),
                      // Horizontal Rule
                      horizontalRuleDecoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.kTextTertiaryColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                      ),
                      // Table styles
                      tableHead: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                      ),
                      tableBorder: TableBorder.all(
                        color: AppColors.kTextTertiaryColor.withAlpha(20),
                        width: 1,
                      ),
                      // List indentation
                      listIndent: 24.w,
                      // Blockquote padding
                      blockquotePadding: EdgeInsets.only(
                        left: 16.w,
                        top: 8.h,
                        bottom: 8.h,
                      ),
                      // Code block padding
                      codeblockPadding: EdgeInsets.all(16.w),
                    ),
                    selectable: true, // Makes the content selectable
                    softLineBreak: true, // Adds proper line breaks
                    shrinkWrap: true, // Fits content to available space
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
