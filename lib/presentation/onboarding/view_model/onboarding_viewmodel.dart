import 'dart:async';

import 'package:place_holder/domain/models.dart';
import 'package:place_holder/presentation/base/baseviewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderDate();
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);

  @override
  int goNext() {
    ++_currentIndex;
    if (_currentIndex == _list.length) _currentIndex = 0;

    return _currentIndex;
  }

  @override
  int goPrevious() {
    --_currentIndex;
    if (_currentIndex == -1) _currentIndex = _list.length - 1;

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  List<SliderObject> _getSliderDate() => [
        SliderObject(AppStrings.onBoardingSubTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingSubTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingSubTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingSubTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        _currentIndex,
        _list.length,
        _list[_currentIndex],
      ),
    );
  }
}

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
