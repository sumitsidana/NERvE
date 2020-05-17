package InputOutput;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.Map.Entry;

public class InputOutput {
	public static void writePosRatings(String inputFile, String outputFile) throws IOException{

		PrintWriter printWriter = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {				
				String [] array = line.split("\t");
				//				
				if(array[2].equals("4")){
					printWriter.println(line);
				}

				// TODO Auto-generated method stub
			}
			printWriter.close();
			br.close();
		}
	}

	public static void writeTestUsers(String inputFile, String outputFile) throws IOException{

		PrintWriter printWriter = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {				
				String [] array = line.split("\t");				
				printWriter.println(array[0]);


				// TODO Auto-generated method stub
			}
			printWriter.close();
			br.close();
		}
	}
	public static void writeNegRatings(String inputFile1, String inputFile2,  String outputFile) throws IOException{

		PrintWriter printWriter = new PrintWriter(outputFile);
		Map<String, List<String>> userItemMap = new LinkedHashMap<String, List<String>>();
		//test_all_raw.csv
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile1)))) {
			String line;
			while ((line = br.readLine()) != null) {				
				String [] array = line.split("\t");
				String user = array[0];
				String item = array[1];
				//				if(array[2].equals("1")){
				if(userItemMap.containsKey(user)){
					List<String>itemMap = userItemMap.get(user);
					if(!(itemMap.contains(item))){
						itemMap.add(item);
						userItemMap.put(user, itemMap);
					}
				}
				else{
					List<String>itemMap = new LinkedList<String>();
					itemMap.add(item);
					userItemMap.put(user, itemMap);
				}
				//				}

				// TODO Auto-generated method stub
			}
			br.close();
		}

		//test.ratings
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile2)))) {
			String line;
			while ((line = br.readLine()) != null) {				
				String [] array = line.split("\t");

				String user = array[0];
				String item = array[1];
				printWriter.print("("+user+","+item+")"+"\t");
				List<String>itemMap = userItemMap.get(user);
				int size = 0;
				for(String negItem : itemMap){
					if(size < itemMap.size() - 1){
						printWriter.print(negItem+"\t");
						size++;
					}
					else{
						printWriter.print(negItem);
					}
				}
				printWriter.println();
				// TODO Auto-generated method stub
			}
			printWriter.close();
			br.close();
		}
	}
	public static void writeGroundTruthForNCF(String inputFile, String outputFile) throws IOException{
		Map<Long, List<String>>userItemList = new TreeMap<Long,List<String>>();
		PrintWriter gtTest = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(inputFile))) {
			String line;
			br.readLine();
			while ((line = br.readLine()) != null) {
				String [] array = line.split("\t");
				int rating = Integer.parseInt(array[2]);
				long user = Long.parseLong(array[0]);
				String item = array[1];
				List<String>itemList = new ArrayList<String>();
				if(userItemList.containsKey(user)){
					itemList = userItemList.get(user);
					itemList.add(item);
				}
				else{
					itemList = new ArrayList<String>();
					itemList.add(item);
				}
				userItemList.put(user, itemList);
			}
		}
		for(Entry<Long, List<String>> entry: userItemList.entrySet()){
			long user = entry.getKey();
			List<String> items = entry.getValue();
			gtTest.print(user+" ");
			for(String elements: items){
				gtTest.print(elements+" ");
			}
			gtTest.println();
		}
		gtTest.close();
	}

	public static void writeCartesianProductWithFinalRatings(String inputFile1, String inputFile2, String outputFile) throws IOException{
		/*
		 * Run with following params
		java -cp . preProcess.WriteCartesianProductWithFinalRatings 
		/data/sidana/diversity/kldivergence/param_tune/all_offers_setting/ml100k/test_all_raw.csv 
		/data/sidana/diversity/kldivergence/param_tune/all_offers_setting/ml100k/cartesian_product 
		/data/sidana/diversity/kldivergence/param_tune/all_offers_setting/ml100k/test_all_raw_temp.csv
		 * 
		 */
		PrintWriter printWriter = new PrintWriter (outputFile);
		Set<String>positiveUserOffers = new LinkedHashSet<>();
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile1)))) {
			String line;
			while ((line = br.readLine()) != null) {
				String [] array = line.split("\t");
				if(array[2].equals("4")){
					positiveUserOffers.add(array[0]+"\t"+array[1]);
				}
			}

			br.close();
		}
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile2)))) {
			String line;
			while ((line = br.readLine()) != null) {
				String [] array = line.split("\t");
				String userOfferPair = array[0]+"\t"+array[1];
				if(positiveUserOffers.contains(userOfferPair)){
					printWriter.println(userOfferPair+"\t4\t"+array[3]);
				}
				else{
					printWriter.println(userOfferPair+"\t1\t"+array[3]);
				}
			}
			printWriter.close();
			br.close();
		}
	}
}
