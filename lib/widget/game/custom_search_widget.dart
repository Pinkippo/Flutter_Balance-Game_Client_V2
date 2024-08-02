import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yangjataekil/widget/game/list_item_widget.dart';

import '../../controller/list_controller.dart';

class CustomSearchWidget extends SearchDelegate {
  final ListController controller;

  CustomSearchWidget(this.controller)
      : super(
            searchFieldLabel: '검색어를 입력하세요',
            searchFieldStyle: const TextStyle(fontSize: 17));

  /// 검색창 우측 X 버튼
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
        // close(context, null);
        Get.back();
      },
    );
  }

  /// 검색 결과 리스트
  @override
  Widget buildResults(BuildContext context) {
    controller.updateSearchText(query);
    return _buildResultList();
  }

  /// 검색 결과 리스트
  @override
  Widget buildSuggestions(BuildContext context) {
    controller.updateSearchText(query);
    return _buildResultList();
  }

  /// 검색 결과 리스트
  Widget _buildResultList() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          itemCount: controller.filteredGames.length,
          separatorBuilder: (_, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (_, index) {
            // final board = controller.filteredGames[index];
            return ListItemWidget(
                controller: controller, index: index, isFiltered: true);
          },
        ),
      ),
    );
  }
}
