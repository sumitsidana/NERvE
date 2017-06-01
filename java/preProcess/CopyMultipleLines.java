package preProcess;



import java.io.*;
import java.util.*;

public class CopyMultipleLines {

	public static void main(String[] args) throws NumberFormatException, IOException {
		// TODO Auto-generated method stub
		List<String> countryCodes = Arrays.asList("36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64");
		for(int i = 0 ; i < countryCodes.size() ; i++){
			String countryCode = countryCodes.get(i);
			int numLines = InputOutput.countLines(args[1]+"/"+countryCode);
			InputOutput.copyMultipleLines(args[0]+"/"+"mostpopularitems_"+countryCode+".txt", numLines);
		}
	}

}
