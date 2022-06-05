import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/presentation/helpers/home_state.dart';
import 'package:app_search/src/presentation/helpers/ui_state.dart';
import 'package:app_search/src/ui/pages/pages.dart';
import 'package:common_design_system/common_design_system.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VisibleProviderEntity extends Equatable {
  final String name;
  final bool isVisible;
  final int index;

  const VisibleProviderEntity({
    required this.name,
    required this.isVisible,
    required this.index
  });

  VisibleProviderEntity copy({
    bool? isVisible
  }) => VisibleProviderEntity(
    isVisible: isVisible ?? this.isVisible,
    name: name,
    index: index
  );

  @override
  List<Object?> get props => [name, isVisible, index];
}
class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({ Key? key, required this.presenter }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final animatedListKey = GlobalKey<AnimatedListState>();
  List<VisibleProviderEntity> providers = [];

  @override
  void initState() {
    super.initState();
    widget.presenter.getAll();
    widget.presenter.stateNotifier.addListener(() {
      final currState = widget.presenter.stateNotifier.value;

      if(currState is ProvidersLoadedState) {
       providers.addAll(currState.list);
      }
      if (currState is ProvidersFilteredState) {
        handleSearch(currState.list);
      }
    });
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  void handleSearch(List<VisibleProviderEntity> filteredProviders) {
    for (VisibleProviderEntity provider in filteredProviders) {
      final hasElement = providers.any((e) => e.index == provider.index);
      if (provider.isVisible && !hasElement) {
        insertItem(provider);
      } else if (!provider.isVisible && hasElement) {
        removeItem(provider.index);
      }
    }
  }

  void insertItem(VisibleProviderEntity provider) {
    var index = providers.lastIndexWhere((element) => element.index <= provider.index);
    providers.insert(index + 1, provider);
    animatedListKey.currentState?.insertItem(
      index + 1, 
      duration: const Duration(milliseconds: 500)
    );
  }

  void removeItem(int idx) {
    final index = providers.indexWhere((e) => e.index == idx);
    final removed = providers.removeAt(index);
    animatedListKey.currentState?.removeItem(
      index, 
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: ListItem(child: Text(removed.name))
        );
      },
      duration: const Duration(milliseconds: 200)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
        child: ValueListenableBuilder<List<VisibleProviderEntity>?>(
          valueListenable: widget.presenter.filteredProvidersNotifier,
          builder: (context, providers, _) {
            return providers == null
              ? loading() 
              : providersList();
          }
        ),
      ),
    );
  }

  PreferredSize appbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0), // here the desired height
      child: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.all(8.0),
          child: CustomInput(
            hintText: 'Pesquisar',
            onChanged: (String v) => widget.presenter.filterProviders(v),
          ),
        ),
      ),
    );
  }

  Center loading() => const Center(
    child: CircularProgressIndicator(color: Colors.pink,)
  );

  AnimatedList providersList() => AnimatedList(
    key: animatedListKey,
    initialItemCount: providers.length,
    
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListItem(child: Text(providers[index].name))
      );
    }
  );
}