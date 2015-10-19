package lexicalAnalyzer;

import java.io.File;

public class JFlex {

	public static void main(String[] args) {
		String path = "../Compiler-MiniJava/src/lexicalAnalyzer/lex.jflex";
		File file = new File(path);
		jflex.Main.generate(file);
	}

}
