package preProcess;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.lang3.StringUtils;

public class InputOutput {

	public static <K, V extends Comparable<? super V>> Map<K, V> 
	sortByValue( Map<K, V> map )
	{
		List<Map.Entry<K, V>> list =
				new LinkedList<>( map.entrySet() );
		Collections.sort( list, new Comparator<Map.Entry<K, V>>()
		{
			@Override
			public int compare( Map.Entry<K, V> o1, Map.Entry<K, V> o2 )
			{
				return ( o2.getValue() ).compareTo( o1.getValue() );
			}
		} );

		Map<K, V> result = new LinkedHashMap<>();
		for (Map.Entry<K, V> entry : list)
		{
			result.put( entry.getKey(), entry.getValue() );
		}
		return result;
	}

	public static void getInteger(String inputFile,String outputFile) throws IOException{
		PrintWriter printWriterTrain = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {
				line = line.replace("mv_", "").replace(".txt", "");
				line = StringUtils.stripStart(line,"0");
				printWriterTrain.println(line);
				// TODO Auto-generated method stub
			}
			printWriterTrain.close();
			br.close();
		}

	}

	public static void date2timeStamp(String inputFile,String outputFile) throws IOException, ParseException{
		PrintWriter printWriterTrain = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				String date_Temp = array[array.length-1];
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date utilDate = dateFormat.parse(date_Temp);	
				Date date = new java.sql.Date(utilDate.getTime());	
				long time = date.getTime();
				//				Timestamp timestamp = new Timestamp(time);
				for(int i = 0 ; i < array.length -1 ; i++)
					printWriterTrain.print(array[i]+",");
				printWriterTrain.println(time);
				// TODO Auto-generated method stub
			}
			printWriterTrain.close();
			br.close();
		}

	}

	public static void ignoreSingleRatingUsers(String inputFile1,String inputFile2,String outputFile,String delimiter) throws IOException{
		Set<String>singleRatingUsers = new HashSet<String>();
		PrintWriter printWriterTrain = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile1)))) {
			String line;
			while ((line = br.readLine()) != null) {
				singleRatingUsers.add(line);
			}
		}
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile2)))) {
			String line;
			while ((line = br.readLine()) != null) {
				String [] array = line.split(delimiter);
				if(singleRatingUsers.contains(array[0])) //expects userId at 1st position
					continue;
				printWriterTrain.println(line);
			}
			printWriterTrain.close();
			br.close();
		}
	}
	public static void replaceRatingType(String inputFile,String outputFile) throws IOException{
		PrintWriter printWriterTrain = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {
				//				line = line.replace(",1,", ",2,");
				line = line.replace(",2,", ",4,");
				printWriterTrain.println(line);
			}
			printWriterTrain.close();
			br.close();
		}
	}

	public static void writeTabSeparatedFile(String inputFile, String outputFile, String header) throws IOException{
		String line;
		PrintWriter printWriter = new PrintWriter(new BufferedWriter(new FileWriter(outputFile, true)));
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			line = br.readLine();
			printWriter.println(header);
			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				String useridclicks = array[0];
				for(int i = 2  ; i  < array.length ; i++){
					if(i>=array.length - 4){
						continue;
					}
					printWriter.print(array[i]+",");
				}
				if(useridclicks.equals("null")){
					printWriter.print("0,");
				}
				else{
					printWriter.print("1,");
				}
				String timeStamp = array[array.length-1];
				java.sql.Timestamp ts = java.sql.Timestamp.valueOf(timeStamp);
				long tsTime = ts.getTime();
				printWriter.println(tsTime);

			}
			// TODO Auto-generated method stub
		}
		printWriter.close();

	}

	public static void removeBrackets(String inputFile, String outputFile) throws IOException{

		PrintWriter printWriterTrain = new PrintWriter (outputFile);
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			while ((line = br.readLine()) != null) {
				line = line.replace("[", "").replace("]", "");
				printWriterTrain.println(line);
				// TODO Auto-generated method stub
			}
			printWriterTrain.close();
			br.close();
		}

	}
	public static void milliseconds2seconds(String inputFile,String outputFile) throws NumberFormatException, IOException{
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			PrintWriter printWriterTrain = new PrintWriter (outputFile);
			line = br.readLine();
			printWriterTrain.println(line);
			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				String milliseconds = array[3];
				double seconds = Double.parseDouble(milliseconds)/1000.0;
				String lineWritten = array[0]+","+array[1]+","+array[2]+","+seconds;
				printWriterTrain.println(lineWritten);
			}
			printWriterTrain.close();
		}
	}

	public static void binarizeData(String inputFile,String outputFile) throws NumberFormatException, IOException{
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			PrintWriter printWriter = new PrintWriter(new BufferedWriter(new FileWriter(outputFile, true)));
			line = br.readLine();
			printWriter.println(line);
			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				int feedback = 0;
				double rating = Double.parseDouble(array[2]);
				if(rating>3)
					feedback = 2;
				else
					feedback = 1;
				String lineWritten = array[0]+","+array[1]+","+feedback+","+array[3];
				printWriter.println(lineWritten);
			}
			printWriter.close();
		}
	}

	public static void writeInputBPRMF(String inputFile, String outputFile) throws IOException{
		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			PrintWriter printWriter = new PrintWriter(new BufferedWriter(new FileWriter(outputFile, true)));
			line = br.readLine();
			Map<Long,Map<Long,Long>> userItemRating = new LinkedHashMap<Long,Map<Long,Long>>();
			//			printWriter.println(line);
			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				int feedback = 0;
				long userId = Long.parseLong(array[0]);
				long itemId = Long.parseLong(array[1]);
				Long rating = Long.parseLong(array[2]);
				if(userItemRating.containsKey(userId)){
					Map<Long,Long>itemRating = userItemRating.get(userId);
					itemRating.put(itemId, rating);
					userItemRating.put(userId,itemRating);
				}
				else{
					Map<Long,Long>itemRating = new LinkedHashMap<Long,Long>();
					itemRating.put(itemId, rating);
					userItemRating.put(userId,itemRating);
				}
			}
			for(Map.Entry<Long, Map<Long,Long>> entry: userItemRating.entrySet()){
				long userId = entry.getKey();
				Map<Long,Long> itemRating = (LinkedHashMap<Long,Long>)entry.getValue();
				Map<Long,Long> revSortedItemRating = sortByValue(itemRating);
				userItemRating.put(userId,revSortedItemRating);
			}
			for(Map.Entry<Long, Map<Long,Long>> entry: userItemRating.entrySet()){
				long userId = entry.getKey();
				printWriter.print(userId+"\t");
				Map<Long,Long> itemRating = (LinkedHashMap<Long,Long>)entry.getValue();
				for(Map.Entry<Long,Long> internalEntry: itemRating.entrySet()){
					long itemId = internalEntry.getKey();
					long rating = internalEntry.getValue();
					printWriter.print(itemId+":"+rating+",");
				}
				printWriter.println();
			}

			printWriter.close();
		}

	}

	public static void stringIndexer(String inputFile,String outputFile) throws IOException{

		try (BufferedReader br = new BufferedReader(new FileReader(new File(inputFile)))) {
			String line;
			PrintWriter printWriterTrain = new PrintWriter (outputFile);
			//			line = br.readLine();
			//			printWriterTrain.println(line);
			Map<String,Long>userIndex = new LinkedHashMap<String,Long>();

			while ((line = br.readLine()) != null) {
				String [] array = line.split(",");
				String user = array[0];
				long index;
				if(userIndex.containsKey(user)){
					index = userIndex.get(user);
				}
				else{
					index = userIndex.size()+1;
					userIndex.put(user, index);
				}
				String lineWritten = index+","+array[1]+","+array[2]+","+array[3];
				printWriterTrain.println(lineWritten);
			}
			printWriterTrain.close();
		}

	}
}
