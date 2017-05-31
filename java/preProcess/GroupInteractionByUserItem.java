package preProcess;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.stream.Stream;

public class GroupInteractionByUserItem {
	public static <K, V extends Comparable<? super V>> Map<K, V> 
	sortByValue( Map<K, V> map )
	{
		List<Map.Entry<K, V>> list =
				new LinkedList<Map.Entry<K, V>>( map.entrySet() );
		Collections.sort( list, new Comparator<Map.Entry<K, V>>()
		{
			public int compare( Map.Entry<K, V> o1, Map.Entry<K, V> o2 )
			{
				return (o1.getValue()).compareTo( o2.getValue() );
			}
		} );

		Map<K, V> result = new LinkedHashMap<K, V>();
		for (Map.Entry<K, V> entry : list)
		{
			result.put( entry.getKey(), entry.getValue() );
		}
		return result;
	}
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		try (BufferedReader br = new BufferedReader(new FileReader(new File(args[0])))) {
			String line;
			PrintWriter printWriter = new PrintWriter (args[1]);
			Map<String,Map<String,Long>>userItemList = new LinkedHashMap<String,Map<String,Long>>();
			while ((line = br.readLine()) != null) {
				String user_item_num = line.replace("[", "").replaceAll("]", "");
				String [] array = user_item_num.split(",");
				if(userItemList.containsKey(array[0])){
					LinkedHashMap<String,Long> itemList = (LinkedHashMap<String, Long>) userItemList.get(array[0]);
					itemList.put(array[1], Long.parseLong(array[2]));
					userItemList.put(array[0], itemList);
				}
				else{
					LinkedHashMap<String,Long> itemList = new LinkedHashMap<String,Long>();
					itemList.put(array[1],Long.parseLong(array[2]));
					userItemList.put(array[0], itemList);
				}
			}
			for (Map.Entry<String,Map<String,Long>> entry : userItemList.entrySet()) {
				String user = entry.getKey();
				Map<String,Long> itemList = entry.getValue();
				Map<String,Long> sortedItemList = sortByValue(itemList);
				userItemList.put(user, sortedItemList);
			}
			for (Map.Entry<String,Map<String,Long>> entry : userItemList.entrySet()) {
				printWriter.println(entry.getKey()+"\t"+entry.getValue());
			}
			printWriter.close();	
		}
	}
}
