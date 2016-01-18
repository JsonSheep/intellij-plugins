package org.angularjs.html;

import com.intellij.lexer.HtmlLexer;
import com.intellij.lexer.Lexer;
import com.intellij.psi.xml.XmlTokenType;

/**
 * @author Dennis.Ushakov
 */
public class Angular2HTMLLexer extends HtmlLexer {
  public Angular2HTMLLexer() {
    TokenHandler value = new TokenHandler() {
      @Override
      public void handleElement(Lexer lexer) {
        final String text = lexer.getTokenText();
        if (text.startsWith("(") || text.startsWith("[")) {
          if (!isHtmlTagState(lexer.getState())) {
            seenAttribute = true;
            seenScript = true;
          }
        }
      }
    };
    registerHandler(XmlTokenType.XML_NAME, value);
  }
}
