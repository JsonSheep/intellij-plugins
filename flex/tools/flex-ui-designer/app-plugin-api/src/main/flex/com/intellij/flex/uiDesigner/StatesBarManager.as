package com.intellij.flex.uiDesigner {
import cocoa.AbstractCollectionViewDataSource;
import cocoa.ListViewDataSource;
import cocoa.SegmentedControl;

import flash.errors.IllegalOperationError;

import org.flyti.plexus.Injectable;

public class StatesBarManager extends AbstractCollectionViewDataSource implements Injectable, ListViewDataSource {
  private const source:Vector.<String> = new Vector.<String>();
  
  public function get states():Array {
    return _document.uiComponent.states;
  }
  
  public function set stateName(value:String):void {
    _document.uiComponent.currentState = value;
  }
  
  private var _document:Document;
  public function set document(value:Document):void {
    if (value == _document) {
      return;  
    }
    
    _document = value;
    if (_presentation == null) {
      return;
    }
    
    if (_document == null) {
      _presentation.hidden = true;
      return;
    }
    
    var documentStates:Array = states;
    _presentation.hidden = documentStates.length < 2;
    if (!_presentation.hidden) {
      update(documentStates);
      var currentState:Object = _document.uiComponent.currentState;
      _presentation.selectedIndex = (currentState == null || currentState == "") ? 0 : source.indexOf(currentState);
    }
  }

  private var _presentation:SegmentedControl;
  public function set presentation(value:SegmentedControl):void {
    if (_presentation != null) {
      _presentation.selectionChanged.remove(selectionChanged);
    }

    _presentation = value;

    if (_presentation != null) {
      _presentation.dataSource = this;
      _presentation.selectionChanged.add(selectionChanged);
    }
  }
  
  private function update(rawStates:Array):void {
    const wasEmpty:Boolean = empty;
    _itemCount = rawStates.length;
    source.length = _itemCount;
    for (var i:int = 0; i < _itemCount; i++) {
      source[i] = rawStates[i].name;
    }

    if (!wasEmpty && _reset != null) {
      _reset.dispatch();
    }
  }

  private function selectionChanged(oldIndex:int, newIndex:int):void {
    _document.uiComponent.currentState = getStringValue(newIndex);
  }

  public function getObjectValue(itemIndex:int):Object {
    throw new IllegalOperationError();
  }

  public function getStringValue(itemIndex:int):String {
    return source[itemIndex];
  }
}
}
