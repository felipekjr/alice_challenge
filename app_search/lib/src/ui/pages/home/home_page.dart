import 'package:app_search/src/domain/entities/provider_entity.dart';
import 'package:app_search/src/ui/pages/pages.dart';
import 'package:common_design_system/common_design_system.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({ Key? key, required this.presenter }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.presenter.getAll();
    super.initState();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
        child: ValueListenableBuilder<List<ProviderEntity>?>(
          valueListenable: widget.presenter.filteredProvidersNotifier,
          builder: (context, providers, _) {
            return providers == null 
              ? loading() 
              : providersList(providers);
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
            onChanged: (String v) => widget.presenter.filterProviders(v),
          ),
        ),
      ),
    );
  }

  Center loading() => const Center(
    child: CircularProgressIndicator()
  );

  ListView providersList(List<ProviderEntity> providers) => ListView.builder(
    itemCount: providers.length,
    itemBuilder: (context, index) {
      return ListItem(child: Text(providers[index].name));
    }
  );
}