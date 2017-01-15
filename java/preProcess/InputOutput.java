package preProcess;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
	}
