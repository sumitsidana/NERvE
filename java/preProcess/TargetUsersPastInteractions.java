package preProcess;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.*;

public class TargetUsersPastInteractions {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		Map<String,String> userItemList = new LinkedHashMap<String,String> ();
		try (BufferedReader br = new BufferedReader(new FileReader(new File(args[0])))) {
			String line;
			//br.readLine();
			while ((line = br.readLine()) != null) {
				String [] array = line.split("\t");
				userItemList.put(array[0], array[1]);
			}

		}
		try (BufferedReader br = new BufferedReader(new FileReader(new File(args[1])))) {
			String line;
			PrintWriter printWriter = new PrintWriter (args[2]);
//			br.readLine();
			while ((line = br.readLine()) != null) {
				printWriter.print(line+" ");
				if(userItemList.containsKey(line)){
					String itemList = userItemList.get(line);
					String itemListTemp = itemList.replace("{", "").replace("}", "");
					String [] array = itemListTemp.split(",",-1);
					for(int i = array.length -1 ; i>0 ;i--){
						String []itemValue = array[i].split("=");
						printWriter.print(itemValue[0].trim()+" ");
					}
					String []itemValue = array[0].split("=");
					printWriter.println(itemValue[0].trim());
				}
				else{
					printWriter.println();
				}
			}
			printWriter.close();
		}
	}

}
