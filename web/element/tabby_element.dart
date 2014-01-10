import 'package:polymer/polymer.dart';
import 'dart:html' as dom;


@CustomTag('tabby-element')


class TabbyElement extends PolymerElement {


  final String currentTabClassName = 'tabby-current-tab',
               tabsClassName       = '.tabby-tab';


  dom.Element firstTab,
              currentTab;


  List tabContainers = toObservable([]),
       tabs          = toObservable([]);


  TabbyElement.created() : super.created() {
    this.tabContainers.changes.listen( (records) {
       this.tabs = this.shadowRoot.querySelectorAll('li');
       focusTab(this.tabs.first);
    });

    this.tabContainers.addAll(this.querySelectorAll('div'));

    hideAllContainers();
  }


  focusTab(tabEl) {
    this.currentTab = tabEl;
    highlightCurrentTab();
    showCurrentTabContainer();
  }


  hideAllContainers() {
    this.tabContainers
      .forEach( (el) =>
        el.style.display = 'none'
      );
  }


  onTabClick(e) {
    focusTab(e.currentTarget);
  }


  // This is a silly way to do this, we shouldn't
  // have to select them each time.  The tabs
  // should be an instance variable, but it doesn't
  // want to see the "li" elements, so I can't select them.
  unhighlightAllTabs() {
    this.shadowRoot
      .querySelectorAll(this.tabsClassName)
      .forEach( (el) =>
        el.classes.remove(this.currentTabClassName)
      );
  }


  highlightCurrentTab() {
    unhighlightAllTabs();
    this.currentTab.classes.add(this.currentTabClassName);
    print(this.currentTab.classes);
    print(this.currentTab.children.first.attributes['href']);
  }


  showCurrentTabContainer() {
    hideAllContainers();

    var tabId = this.currentTab
      .children
      .first
      .attributes['href'];

    this.querySelector(tabId)
      .style
      .display = 'block';
  }
}
