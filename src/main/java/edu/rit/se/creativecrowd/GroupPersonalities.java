package edu.rit.se.creativecrowd;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class GroupPersonalities {

	private static final Properties mProps = new Properties();

	private static Connection mConn = null;

	public void groupData() throws IOException, ClassNotFoundException, SQLException {
		if (mConn == null) {
			try (InputStream inStream = DBProcess.class.getResourceAsStream("/application.properties")) {
				mProps.load(inStream);
				Class.forName(mProps.getProperty("jdbc.driverClassName"));

				mConn = DriverManager.getConnection(mProps.getProperty("jdbc.url") + "?user="
						+ mProps.getProperty("jdbc.username") + "&password=" + mProps.getProperty("jdbc.password"));
			}
		}
		float[] discVals = new float[4];
		Statement st1 = mConn.createStatement();
		ResultSet rs1 = null;
		Statement st = mConn.createStatement();
		ResultSet rs = st.executeQuery("SELECT gid, uid1, uid2, uid3, uid4 FROM usergroups");
		while(rs.next()){
			int dCount = 0, iCount = 0, sCount = 0, cCount = 0;
			int i;
 			String sqlInput1 = "";
 			String sqlInput2 = "";
 			for(i=1;i<5&&rs.getString("uid"+i)!=null;i++){
				rs1 = st1.executeQuery("SELECT normD, normI, normS, normC FROM personality_data WHERE uid = "+rs.getString("uid"+i));
				if (!rs1.next())
					continue;
				discVals[0] = rs1.getFloat("normD");
				discVals[1] = rs1.getFloat("normI");
				discVals[2] = rs1.getFloat("normS");
				discVals[3] = rs1.getFloat("normC");
				int maxIndex = 0;
				for (int j = 0; j < discVals.length; j++){
				   float newnumber = discVals[j];
				   if ((newnumber > discVals[maxIndex])){
				   maxIndex = j;
				  }
				}
				switch(maxIndex){
					case 0: dCount++;
							break;
					case 1: iCount++;
							break;
					case 2: sCount++;
							break;
					case 3: cCount++;
							break;
				}
			}
 			int TotalCount = 4;
 			while(dCount>0){
 				sqlInput1+="'D', ";
 				sqlInput2+="D.";
 				dCount--;
 				TotalCount--;
 			}
 			while(iCount>0){
 				sqlInput1+="'I', ";
 				sqlInput2+="I.";
 				iCount--;
 				TotalCount--;
 			}
 			while(sCount>0){
 				sqlInput1+="'S', ";
 				sqlInput2+="S.";
 				sCount--;
 				TotalCount--;
 			}
 			while(cCount>0){
 				sqlInput1+="'C', ";
 				sqlInput2+="C.";
 				cCount--;
 				TotalCount--;
 			}
 			while(TotalCount>0){
 				sqlInput1+="null, ";
 				TotalCount--;
 			}
 			if(sqlInput1.length()>2)
 				sqlInput1 = sqlInput1.substring(0, sqlInput1.length() - 2);
 			if(sqlInput2.length()>1)
 				sqlInput2 = sqlInput2.substring(0, sqlInput2.length() - 1);
 			PreparedStatement statement = mConn.prepareStatement(
					"INSERT INTO `groupdata_admin`(`gid`, `user_persona1`, `user_persona2`, `user_persona3`, `user_persona4`, `user_personas`) VALUES (?,"+sqlInput1+",'"+sqlInput2+"')");
			statement.setString(1, rs.getString("gid"));
			statement.executeUpdate();
			statement.close();
		}
		
	}

}
