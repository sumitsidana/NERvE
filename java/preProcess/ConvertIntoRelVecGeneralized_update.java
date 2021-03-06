package preProcess;
import java.io.*;
import java.util.*;

public class ConvertIntoRelVecGeneralized_update {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		long startTime = System.currentTimeMillis();
		String groundTruth = args[0];
		String predicted = args[1];
		BufferedReader gtBr = new BufferedReader(new FileReader(groundTruth));
		BufferedReader prBr = new BufferedReader(new FileReader(predicted));
		Set<String>trueOffers = new HashSet<String>();

		int index = 0;

		PrintWriter printWriter = new PrintWriter (args[2]);
		boolean flag_gt = true;
		boolean flag_pr = true;
		String gtLine = null;
		String prLine = null;
		while (true) {
			if(flag_gt == true && flag_pr == true){
				gtLine = gtBr.readLine();
				prLine = prBr.readLine();
			}
			else if(flag_gt == true && flag_pr == false){
				gtLine = gtBr.readLine();
			}
			else if(flag_gt == false && flag_pr == true){
				prLine = prBr.readLine();
			}

			flag_gt=true;
			flag_pr=true;

			if (gtLine == null || prLine == null)
				break;

			//handle the case of no ground truth transactions in test
			index = gtLine.indexOf(" ");
			if(index == -1){
				continue;
			}

			String [] arrgt = gtLine.split(" ");
			String prOffers = prLine.substring(prLine.indexOf(" ")+1);
			String predictedUser = prLine.substring(0, prLine.indexOf(" "));
			String [] arrpr = prOffers.split(" ");

			if(!(predictedUser.equals(arrgt[0]))){
				System.out.println("Something is wrong: userIds do not match");
				int minimumId = Math.min(Integer.parseInt(predictedUser), Integer.parseInt(arrgt[0]));
				if(minimumId == Integer.parseInt(predictedUser)){
					flag_gt=false;
					continue;
				}
				else{
					flag_pr=false;
					continue;
				}


				//System.exit(1);
			}
			for(int i = 1 ; i < arrgt.length ; i++)
				trueOffers.add(arrgt[i]);


			int uDefParam = Integer.parseInt(args[3]);
			int predictedLength = arrpr.length;

			boolean flag = true;
			int j = 0;

			for(j = 0 ; j < uDefParam ; j++){
				if(j >= predictedLength){
					flag = false;
					break;
				}
				String predictedOffer = arrpr[j];
				if(trueOffers.contains(predictedOffer))
				{
					if(j == uDefParam - 1)
						printWriter.println("1");
					else
						printWriter.print("1 ");
				}
				else
				{
					if(j == uDefParam - 1)
						printWriter.println("0");
					else
						printWriter.print("0 ");
				}
			}
			if(flag == false){
				for(int k = j ; k < uDefParam-1 ; k++){
					printWriter.print("0 ");
				}
				printWriter.println("0");
			}

			trueOffers.clear();
			//			printWriter.println();
		}
		printWriter.close();

		long stopTime = System.currentTimeMillis();
		long elapsedTime = stopTime - startTime;
		//System.out.println(elapsedTime);
	}
}
