import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_holder/domain/models.dart';
import 'package:place_holder/presentation/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:place_holder/presentation/resources/assets_manager.dart';
import 'package:place_holder/presentation/resources/color_manger.dart';
import 'package:place_holder/presentation/resources/constants_manager.dart';
import 'package:place_holder/presentation/resources/strings_manager.dart';
import 'package:place_holder/presentation/resources/values_manager.dart';

import '../../resources/routes_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }

  Widget _getContentWidget(SliderViewObject? data) {
    if (data == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSize.s0,
          backgroundColor: ColorManager.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            //  statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          itemCount: data.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(data.sliderObject);
          },
          controller: _pageController,
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.loginRoute,
                    );
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheetWidget(data),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppPadding.p14,
            ),
            child: GestureDetector(
              onTap: () => _pageController.animateToPage(
                _viewModel.goPrevious(),
                duration: const Duration(
                  milliseconds: AppConstants.sliderAnimationTime,
                ),
                curve: Curves.bounceInOut,
              ),
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(
                      index: i, currentIndex: sliderViewObject.currentIndex),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppPadding.p14,
            ),
            child: GestureDetector(
              onTap: () => _pageController.animateToPage(
                _viewModel.goNext(),
                duration: const Duration(
                  milliseconds: AppConstants.sliderAnimationTime,
                ),
                curve: Curves.bounceInOut,
              ),
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle({required int index, required currentIndex}) {
    if (index == currentIndex) {
      return SvgPicture.asset(
        ImageAssets.hollowCircleIc,
      );
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
