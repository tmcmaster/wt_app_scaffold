import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffold_store.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page_button_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page_controls.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page_indicators.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel_type.dart';

class ItemControlPanel extends ConsumerStatefulWidget {
  final PageInfo pageInfo;
  final Widget? indicators;
  final Widget? actions;
  final Widget? summary;
  final Widget? controls;
  final List<ItemControlPanel> Function()? buildChildren;
  final bool enableRoute;
  final bool initiallyExpanded;
  final ItemControlPanelType type;
  final bool childExpanded;
  final ItemControlPanelType childType;

  const ItemControlPanel({
    required this.pageInfo,
    this.indicators,
    this.actions,
    this.summary,
    this.controls,
    this.buildChildren,
    this.enableRoute = true,
    this.initiallyExpanded = false,
    this.type = ItemControlPanelType.expandableAll,
    this.childExpanded = false,
    this.childType = ItemControlPanelType.childrenOnly,
  });

  @override
  ConsumerState<ItemControlPanel> createState() => _ItemControlPanelState();

  factory ItemControlPanel.from({
    required ItemInfo itemInfo,
    required ActionDefinitionProviders actionsProviders,
    required SettingsProvidersMap settingsProviders,
    Widget Function()? summaryBuilder,
    List<ItemControlPanel> Function()? buildChildren,
    bool initiallyExpanded = false,
    bool enableRoute = false,
    ItemControlPanelType type = ItemControlPanelType.expandableChildren,
    bool? childExpanded = true,
    ItemControlPanelType? childType = ItemControlPanelType.childrenOnly,
  }) {
    return ItemControlPanel(
      pageInfo: PageInfo.from(itemInfo),
      enableRoute: enableRoute,
      initiallyExpanded: initiallyExpanded,
      type: type,
      indicators: actionsProviders.isEmpty
          ? null
          : AppScaffoldPageIndicators(
              actionsProviders: actionsProviders,
            ),
      summary: summaryBuilder?.call(),
      actions: actionsProviders.isEmpty
          ? null
          : AppScaffoldPageButtonBar(
              actionsProviders: actionsProviders,
            ),
      controls: settingsProviders.isEmpty
          ? null
          : AppScaffoldPageControls(
              settingsProviders: settingsProviders,
            ),
      buildChildren: buildChildren,
      childExpanded: childExpanded ?? initiallyExpanded,
      childType: childType ?? type,
    );
  }

  factory ItemControlPanel.fromAppDefinition(
    AppDefinition appDefinition, {
    bool initiallyExpanded = true,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: PageInfo(
        name: appDefinition.appDetails.name,
        title: appDefinition.appDetails.title,
        icon: Icons.face,
      ),
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: appDefinition.actionProviders,
      settingsProviders: appDefinition.settingsProviders,
      buildChildren: () => [
        ...appDefinition.getModules().map((module) => ItemControlPanel.fromModule(module)),
        ...appDefinition.getFeatures().map((feature) => ItemControlPanel.fromFeature(feature)),
        ...appDefinition.getPages().map((page) => ItemControlPanel.fromPage(page)),
      ],
    );
  }

  factory ItemControlPanel.fromModule(
    ModuleDefinition moduleDefinition, {
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: moduleDefinition.moduleInfo,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: moduleDefinition.actionProviders,
      settingsProviders: moduleDefinition.settingsProviders,
      buildChildren: () => moduleDefinition.features.map((feature) => ItemControlPanel.fromFeature(feature)).toList(),
    );
  }

  factory ItemControlPanel.fromFeature(
    FeatureDefinition featureDefinition, {
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: featureDefinition.featureInfo,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: featureDefinition.actionProviders,
      settingsProviders: featureDefinition.settingsProviders,
      buildChildren: () => featureDefinition.pages.map((page) => ItemControlPanel.fromPage(page)).toList(),
    );
  }

  factory ItemControlPanel.fromPage(
    PageDefinition pageDefinition, {
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: pageDefinition.info,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: pageDefinition.actionsProviders,
      settingsProviders: pageDefinition.settingsProviders,
    );
  }
}

class _ItemControlPanelState extends ConsumerState<ItemControlPanel> with SingleTickerProviderStateMixin {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // -- Header Section

          if (widget.type == ItemControlPanelType.childrenOnly)
            ...widget.buildChildren == null ? [] : widget.buildChildren!()
          else if (widget.type == ItemControlPanelType.contentOnly)
            Column(
              children: [
                _ActionBar(widget: widget),
                widget.summary ?? Container(),
              ],
            )
          else if (widget.type == ItemControlPanelType.all)
            Column(
              children: [
                _ActionBar(widget: widget),
                widget.summary ?? Container(),
                ...widget.buildChildren == null ? [] : widget.buildChildren!()
              ],
            )
          else
            Column(
              children: [
                // -- Title Bar

                InkWell(
                  onTap: _toggleExpanded,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(widget.pageInfo.icon),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  widget.pageInfo.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.indicators != null)
                          Expanded(
                            child: widget.indicators!,
                          ),
                        SizedBox(
                          width: 50,
                          child: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                        ),
                      ],
                    ),
                  ),
                ),

                // -- Expandable Panel

                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // -- Summary Section
                        if (widget.type == ItemControlPanelType.expandableContent ||
                            widget.type == ItemControlPanelType.expandableAll)
                          _ActionBar(widget: widget),
                        if (widget.type == ItemControlPanelType.expandableContent ||
                            widget.type == ItemControlPanelType.expandableAll)
                          widget.summary ?? Container(),
                        if (widget.type == ItemControlPanelType.expandableChildren ||
                            widget.type == ItemControlPanelType.expandableAll)
                          ...widget.buildChildren == null ? [] : widget.buildChildren!(),
                      ],
                    ),
                  ),
                  crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _ActionBar extends ConsumerWidget {
  const _ActionBar({
    required this.widget,
  });

  final ItemControlPanel widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.actions != null)
            Expanded(
              child: widget.actions!,
            )
          else
            const Spacer(),
          Wrap(
            children: [
              if (widget.controls != null)
                IconButton(
                  onPressed: () {
                    debugPrint('Toggle Controls');
                    _showDialog(context);
                  },
                  icon: const Icon(FontAwesomeIcons.gear),
                  tooltip: 'Settings',
                ),
              if (widget.enableRoute)
                IconButton(
                  onPressed: () {
                    debugPrint('Navigate to route: ${widget.pageInfo.route}');
                    ref.read(AppScaffoldStore.router).go(widget.pageInfo.route);
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Dialog Title'),
        content: SizedBox(
          width: 400,
          height: 400,
          child: widget.controls ?? Container(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
