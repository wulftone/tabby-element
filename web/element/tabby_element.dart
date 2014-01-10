import 'package:polymer/polymer.dart';
import 'dart:html' as dom;


@CustomTag('tabby-element')


class TabbyElement extends PolymerElement {


  final String currentTabClassName = 'tabby-current-tab',
               tabsClassName       = '.tabby-tab';


  dom.Element firstTab,
              currentTab,
              currentTabContainer;


  ObservableList tabContainers = new ObservableList();


  List tabs;


  TabbyElement.created() : super.created() {
    this.tabContainers.changes.listen( (records) {
       this.tabs = this.shadowRoot.querySelectorAll('li');
       focusTab(this.tabs.first);
    });

    this.tabContainers.addAll(this.querySelectorAll('div'));
  }


  focusTab(tabEl) {
    unhighlightTab(this.currentTab);
    this.currentTab = tabEl;
    highlightTab(tabEl);
    setCurrentTabContainer(tabEl);
    showTabContainer(this.currentTabContainer);
  }


  highlightTab(tabEl) {
    tabEl.classes.add(this.currentTabClassName);
  }


  unhighlightTab(tabEl) {
    if (tabEl != null) {
      tabEl.classes.remove(this.currentTabClassName);
    }
  }


  onTabClick(e) {
    focusTab(e.currentTarget);
  }


  setCurrentTabContainer(tabEl) {
    var tabId = tabEl
      .children
      .first
      .attributes['href'];

    this.currentTabContainer = this.querySelector(tabId);
  }


  showTabContainer(tabContainerEl) {
    this.tabContainers.forEach( (el) {
      if (el == tabContainerEl) {
        el.style.display = 'block';
      } else {
        el.style.display = 'none';
      }
    });
  }
}
