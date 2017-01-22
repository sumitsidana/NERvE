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
				line = line.replace(",1,", ",2,");
				line = line.replace(",0,", ",1,");
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
					//					if(i==array.length - 2||i==array.length-4){
					//						continue;
					//					}
					printWriter.print(array[i]+"\t");
				}
				if(useridclicks.equals("null")){
					printWriter.println("0");
				}
				else{
					printWriter.println("1");
				}

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


}