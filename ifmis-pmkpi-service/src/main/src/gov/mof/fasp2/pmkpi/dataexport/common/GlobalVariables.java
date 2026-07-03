package gov.mof.fasp2.pmkpi.dataexport.common;

public class GlobalVariables {
	
	public static String translate(int key){
		
		switch(key){
		case 1:
			return "、";
		case 2:
			return ";";
		case 3:
			return ",";
		case 4:
			return "@";
		
		}
		return null;
	}

}
