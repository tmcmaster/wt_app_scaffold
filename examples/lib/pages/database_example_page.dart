import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_app_scaffold_examples/actions/database_action.dart';
import 'package:wt_app_scaffold_examples/models/definitions/product_definition.dart';
import 'package:wt_app_scaffold_examples/models/product.dart';
import 'package:wt_app_scaffold_examples/widgets/product_list_tile.dart';
import 'package:wt_firebase_listview/wt_firebase_listview.dart';
import 'package:wt_firepod/wt_firepod.dart';

class DatabaseExamplePage extends ConsumerWidget {
  const DatabaseExamplePage({super.key});

  static final productDefinition = ProductDefinition(orderBy: 'id');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAction = ref.read(DatabaseAction.provider);
    final database = ref.read(FirebaseProviders.database);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              databaseAction.component(label: 'Read from Database'),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                child: databaseAction.indicator(type: IndicatorType.linear),
              ),
              const SizedBox(height: 50),
              FirepodModelView(
                query: database.ref('v1/product/003'),
                snapshotToModel: Product.from.snapshot,
                itemBuilder: (product) => SizedBox(
                  width: 200,
                  child: ProductListTile(product: product),
                ),
              ),
              const SizedBox(height: 50),
              FirepodDoubleView(
                query: database.ref('v1/product/002/price'),
                itemBuilder: (value) => Text('\$${value.toStringAsFixed(2)}'),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: FirepodListView(
                  table: (database) => database.ref('v1/product'),
                  query: (table) => table.orderByChild('id'),
                  snapshotToModel: Product.from.snapshot,
                  itemBuilder: (product, _) => ProductListTile(product: product),
                  mapToItem: Product.from.json,
                  itemToMap: Product.to.firebaseMap,
                  formItemDefinitions: productDefinition.formItemDefinitions,
                  selection: productDefinition.selection,
                  canReorder: false,
                  canEdit: false,
                  canSelect: false,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: databaseAction.component(
          floating: true,
          noLabel: true,), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
