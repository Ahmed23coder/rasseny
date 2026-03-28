import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/repositories/home_repository.dart';
import '../../logic/home_bloc.dart';
import '../../logic/home_event.dart';
import '../../logic/home_state.dart';
import '../widgets/home_article_skeleton.dart';
import '../widgets/home_hero_card.dart';
import '../widgets/home_standard_card.dart';
import '../widgets/home_editorial_card.dart';
import '../widgets/home_ai_hub_banner.dart';
import '../widgets/home_section_header.dart';
import '../../data/models/article_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(sl<HomeRepository>())..add(FetchHomeNews()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightNavy,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(RefreshHomeNews());
          },
          color: AppColors.precisionHighlight,
          backgroundColor: AppColors.inputFillDark,
          child: CustomScrollView(
            slivers: [
              // Command Center Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        child: Center(
                          child: SvgPicture.asset(
                            AppStrings.logoPath,
                            width: 42,
                            height: 42,
                            colorFilter: const ColorFilter.mode(
                              AppColors.silverWhite,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Precision Search Bar
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _buildSearchBar(),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              const SliverToBoxAdapter(child: HomeAiHubBanner()),
              const SliverToBoxAdapter(child: HomeSectionHeader()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // News Feed
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const HomeArticleSkeleton(),
                          childCount: 5,
                        ),
                      ),
                    );
                  } else if (state is HomeLoaded) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => FadeInUp(
                            duration: const Duration(milliseconds: 400),
                            delay: Duration(milliseconds: 100 * index.clamp(0, 5)),
                            child: _buildArticleCard(state.articles[index], index),
                          ),
                          childCount: state.articles.length,
                        ),
                      ),
                    );
                  } else if (state is HomeError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: AppColors.silverWhite,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => context.read<HomeBloc>().add(FetchHomeNews()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.precisionHighlight,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('RETRY CONNECTION'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: _buildBottomNav(),
      ),
    );
  }

  Widget _buildArticleCard(Article article, int index) {
    if (index == 0) return HomeHeroCard(article: article);
    if (index == 3) return HomeEditorialCard(article: article);
    return HomeStandardCard(article: article);
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C1E),
        borderRadius: BorderRadius.circular(9999), 
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppColors.silverWhite),
        cursorColor: AppColors.precisionHighlight,
        decoration: InputDecoration(
          hintText: 'Search for global truth...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF43474D),
            fontSize: 18,
            fontWeight: FontWeight.w100, // Thin
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20, right: 12),
            child: Icon(Icons.search, color: Color(0xFF43474D), size: 18),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<HomeBloc>().add(SearchHomeNews(value));
          } else {
            context.read<HomeBloc>().add(FetchHomeNews());
          }
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.midnightNavy.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.silver.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, 'HOME', 0),
            _navItem(Icons.search, 'SEARCH', 1),
            _navItem(Icons.auto_awesome, 'SUMMARIZE', 2),
            _navItem(Icons.shield_outlined, 'VAULT', 3),
            _navItem(Icons.anchor, 'PROFILE', 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFFC3C6CE) : const Color(0xFF43474D);
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
              shadows: isSelected 
                  ? [Shadow(color: color.withValues(alpha: 0.5), blurRadius: 8)] 
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
