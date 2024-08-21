import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yangjataekil/controller/filtered_list_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/filtered_list_item_widget.dart';

class CustomSearchWidget extends SearchDelegate {
  final FilteredListController controller = Get.put(FilteredListController());

  CustomSearchWidget()
      : super(
            searchFieldLabel: '검색어를 입력하세요',
            searchFieldStyle: const TextStyle(fontSize: 17));

  /// 검색창 우측 검색 버튼
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          controller.updateSearchText(query);
          controller.clickSearchBtn();
          showResults(context);
        },
      ),
    ];
  }

  /// 검색창 좌측 화살표 버튼
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }

  /// 검색 결과 리스트
  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // 로딩 상태일 때
        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),
        );
      }

      if (controller.filteredList.isEmpty) {
        // 검색 결과가 없을 때
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              '검색 결과가 없습니다.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }

      return _buildResultList();
    });
  }

  /// 검색 결과 리스트
  @override
  Widget buildSuggestions(BuildContext context) {
    if (controller.filteredList.isEmpty) {
      // 검색 결과가 없을 때
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            '검색 결과가 없습니다.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return _buildResultList();
  }

  /// 검색 결과 리스트
  Widget _buildResultList() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          controller: controller.scrollController.value,
          itemCount: controller.filteredList.length,
          separatorBuilder: (_, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (_, index) {
            return FilteredListItemWidget(
                filteredListController: controller,
                index: index,
                isFiltered: true,
                isMyGame: false);
          },
        ),
      ),
    );
  }
}
