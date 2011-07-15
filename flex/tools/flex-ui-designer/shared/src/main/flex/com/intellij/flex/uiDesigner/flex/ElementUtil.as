package com.intellij.flex.uiDesigner.flex {
import flash.display.Stage;
import flash.geom.Point;

public interface ElementUtil {
  function getObjectUnderPoint(stage:Stage, stageX:Number, stageY:Number):Object;

  function fillBreadcrumbs(element:Object, source:Vector.<String>):int;

  function getPosition(element:Object, result:Point):Point;

  function getSize(element:Object, result:Point):void;
}
}
