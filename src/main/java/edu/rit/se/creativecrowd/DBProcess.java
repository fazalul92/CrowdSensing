package edu.rit.se.creativecrowd;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;
import java.util.Date;

public class DBProcess {

	private final Properties mProps = new Properties();

	private Connection mConn = null;

	public DBProcess() throws IOException, SQLException, ClassNotFoundException {
		if (mConn == null) {
			try (InputStream inStream = DBProcess.class.getResourceAsStream("/application.properties")) {
				mProps.load(inStream);
				Class.forName(mProps.getProperty("jdbc.driverClassName"));

				mConn = DriverManager.getConnection(mProps.getProperty("jdbc.url") + "?user="
						+ mProps.getProperty("jdbc.username") + "&password=" + mProps.getProperty("jdbc.password"));
			}
		}
	}

	public void disConnect() throws SQLException {
		if (mConn != null) {
			mConn.close();
			mConn = null; // close() does not set to null
		}
	}

	private String currentDateTIme() {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(dt);
	}

	public String timeDifference(Date startDate, Date endDate) {
		long different = endDate.getTime() - startDate.getTime();
		long secondsInMilli = 1000;
		long minutesInMilli = secondsInMilli * 60;
		long hoursInMilli = minutesInMilli * 60;
		long daysInMilli = hoursInMilli * 24;
		long elapsedDays = different / daysInMilli;
		different = different % daysInMilli;
		long elapsedHours = different / hoursInMilli;
		different = different % hoursInMilli;
		long elapsedMinutes = different / minutesInMilli;
		/*
		 * different = different % minutesInMilli; long elapsedSeconds =
		 * different / secondsInMilli;
		 *
		 *
		 * if(elapsedDays>0) ret = elapsedDays+" days, "+elapsedHours+" hours, "
		 * +elapsedMinutes+" minutes, "+elapsedSeconds+" seconds"; else ret =
		 * elapsedHours+" hours, "+elapsedMinutes+" minutes, "
		 * +elapsedSeconds+" seconds";
		 */
		String ret = "";
		if (elapsedDays > 0)
			ret = elapsedDays + " days, " + elapsedHours + " hours, " + elapsedMinutes + " minutes";
		else
			ret = elapsedHours + " hours, " + elapsedMinutes + " minutes";
		return ret;
	}

	public String timeSinceLogin(String uid) throws SQLException {
		String ret = "";
		try {
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select created_at from users where id=" + uid);
			rs.next();
			Timestamp timestamp = rs.getTimestamp("created_at");
			java.util.Date startDate = new java.util.Date(timestamp.getTime());
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date endDate = dateFormat.parse(currentDateTIme());
			ret = timeDifference(startDate, endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public int registerUser(String mturk) throws ClassNotFoundException, IOException, SQLException {
		int count = 0;
		int completion = 0;
		String dtime = currentDateTIme();
		/*
		 * NameGen gen = new NameGen(); String name = gen.getName();
		 */
		String name = "Participant";
		try {
			PreparedStatement statement = mConn
					.prepareStatement("INSERT INTO `users`(`mturk_id`, `created_at`, `completion_state`) VALUES ('"
							+ mturk + "','" + dtime + "','" + completion + "')");
			count = statement.executeUpdate();
			statement.close();
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where mturk_id='" + mturk + "'");
			if (rs.next()) {
				count = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int loginUser(String mturk) throws ClassNotFoundException, IOException, SQLException {
		try {
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where mturk_id='" + mturk + "'");
			if (rs.next()) {
				return rs.getInt("id");
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int addLog(int uid, String message) {
		int ret = 0;
		String dtime = currentDateTIme();
		try {
			PreparedStatement statement = mConn
					.prepareStatement("INSERT INTO `logs`(`uid`, `message`, `created_at`) VALUES ('" + uid + "','"
							+ message + "','" + dtime + "')");
			ret = statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public ResultSet getUser(String uid) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from users where id='" + uid + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

//	public int setGroup(String uid, String gid) throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		try {
//			Statement st = mConn.createStatement();
//			String sql = "UPDATE users SET gid = " + gid + " WHERE id=" + uid;
//			count = st.executeUpdate(sql);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}

//	public boolean checkAttention(String uid) throws SQLException {
//		int TrueCount = 0;
//		try {
//			Statement st = mConn.createStatement();
//			ResultSet rs = st
//					.executeQuery("select generic_name, choice_no from generic_responses where user_id = " + uid);
//			while (rs.next()) {
//				/*
//				 * if (rs.getString("generic_name").equals("mbtigeneric1") ||
//				 * rs.getString("generic_name").equals("mbtigeneric3"))
//				 * TrueCount += (rs.getInt("choice_no") == 2) ? 1 : 0; else if
//				 * (rs.getString("generic_name").equals("mbtigeneric2") ||
//				 * rs.getString("generic_name").equals("mbtigeneric4"))
//				 * TrueCount += (rs.getInt("choice_no") == 1) ? 1 : 0;
//				 *
//				 * if (rs.getString("generic_name").equals("creativegeneric1")
//				 * && rs.getInt("choice_no") < 3) TrueCount += 1; else if
//				 * (rs.getString("generic_name").equals("creativegeneric2") &&
//				 * rs.getInt("choice_no") > 3) TrueCount += 1; else if
//				 * (rs.getString("generic_name").equals("creativegeneric3") &&
//				 * rs.getInt("choice_no") > 3) TrueCount += 1;
//				 */
//				if (rs.getString("generic_name").equals("discgeneric1")
//						|| rs.getString("generic_name").equals("discgeneric3"))
//					TrueCount += (rs.getInt("choice_no") == 2) ? 1 : 0;
//				else if (rs.getString("generic_name").equals("discgeneric2")
//						|| rs.getString("generic_name").equals("discgeneric4"))
//					TrueCount += (rs.getInt("choice_no") == 1) ? 1 : 0;
//				else if (rs.getString("generic_name").equals("personageneric1") && rs.getInt("choice_no") < 3)
//					TrueCount += 1;
//				else if (rs.getString("generic_name").equals("personageneric2") && rs.getInt("choice_no") > 3)
//					TrueCount += 1;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (TrueCount > 4)
//			return true;
//		else
//			return false;
//	}

	/*
	 * public int assignTeamOld(String uid) throws IOException, SQLException,
	 * ClassNotFoundException { int count = 0; int groupSize = 4; ResultSet rs =
	 * null; try { Statement st = mConn.createStatement(); Statement st1 =
	 * mConn.createStatement(); if (checkAttention(uid)) { rs =
	 * st.executeQuery("select * from usergroups where status=2 order by gid");
	 * rs.next(); int gid = rs.getInt("gid"); int i = 1; for (i = 1;
	 * rs.getString("uid" + i) != null && i < (groupSize + 1); i++) ; String
	 * name = "Participant " + i; String uidn = "uid" + i; if (i < groupSize) {
	 * count = st1.executeUpdate("UPDATE usergroups SET " + uidn + " = " + uid +
	 * " WHERE gid=" + gid); } else { count = st1.executeUpdate(
	 * "UPDATE usergroups SET " + uidn + " = " + uid + ", status = 3 WHERE gid="
	 * + gid); st1.executeUpdate("UPDATE usergroups SET status = 2 WHERE gid=" +
	 * (gid + 1)); } st1.executeUpdate("UPDATE users SET gid = " + gid +
	 * ", group_type = " + rs.getInt("type") + ", name='" + name + "' WHERE id="
	 * + uid); } else { st1.
	 * executeUpdate("UPDATE users SET gid = -1, group_type = 1, name='Participant' WHERE id="
	 * + uid); } } catch (SQLException e) { e.printStackTrace(); } return count;
	 * }
	 */	 

//	public int assignTeam(String uid) throws IOException, SQLException, ClassNotFoundException {
//		int count = 0;
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery("SELECT personality from users where id="+uid);
//			rs.next();
//			String userPersonality = rs.getString("personality");
//			Statement st1 = mConn.createStatement();
//			if (checkAttention(uid)) {
//				rs = st.executeQuery("select * from usergroups where status<3 order by status desc, filled desc");
//				boolean rowFound = false;
//				while(rs.next() && !rowFound){
//					int i;
//					for(i=1;i<5 && !rowFound;i++){
//						if(rs.getString("uid"+i)!=null || !(rs.getString("upersona"+i).contains(userPersonality) || rs.getString("upersona"+i).contains("A"))) {
//							continue;
//						}
//						else {
//							rowFound = true;
//							int nullCount = 0;
//							for(int j=1;j<5;j++){
//								if(rs.getString("uid"+j)==null)
//									nullCount++;
//							}
//							nullCount--;
//							int filled = 4 - nullCount;
//							int status = (nullCount==0) ? 3 : 2;
//							count = st1.executeUpdate("UPDATE usergroups SET uid" + i + " = " + uid + ", status = "+status+", filled = "+filled+" WHERE gid=" + rs.getInt("gid"));
//							count += st1.executeUpdate("UPDATE users SET gid = "+rs.getInt("gid")+", group_type = "+rs.getInt("type")+", name = 'Participant "+i+"' WHERE id = "+uid);
//						}
//					}
//				}
//				if(!rowFound)
//					System.out.print("Cannot be assigned");
//			} else {
//				st1.executeUpdate("UPDATE users SET gid = -1, group_type = 1, name='Participant' WHERE id=" + uid);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}

	public String[] updateState(String uid, String state) throws ClassNotFoundException, IOException, SQLException {
		String NewState = "";
		String[] ReturnVal = new String[2];
		try {
			ResultSet rs = null;
			ResultSet rs1 = null;
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select next_seq from statuses where seq_no='" + state + "'");
			rs.next();
			NewState = rs.getString("next_seq");
			ReturnVal[0] = NewState;
			rs1 = st.executeQuery("select filename from statuses where seq_no='" + NewState + "'");
			rs1.next();
			ReturnVal[1] = rs1.getString("filename");
			st = mConn.createStatement();
			String sql = "UPDATE users SET state = '" + NewState + "' WHERE id='" + uid + "'";
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ReturnVal;
	}

//	public int testCaseCount(int uid) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery("SELECT COUNT(*) as nos FROM testcases where uid=" + uid);
//			rs.next();
//			return rs.getInt("nos");
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return 0;
//	}

	public int preSurveyCount(int uid) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		int count = 0;
		try {
			String[] tables = { "presurvey_responses", "personality_responses", "discpersonality_responses" };
			Statement st = mConn.createStatement();
			for (int i = 0; i < tables.length; i++) {
				rs = st.executeQuery("SELECT COUNT(*) as nos FROM " + tables[i] + " where user_id=" + uid);
				rs.next();
				if (rs.getInt("nos") > 0)
					count += 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
//
//	public int postSurveyCount(int uid) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		int count = 0;
//		try {
//			String[] tables = { "postsurvey_responses" };
//			Statement st = mConn.createStatement();
//			for (int i = 0; i < tables.length; i++) {
//				rs = st.executeQuery("SELECT COUNT(*) as nos FROM " + tables[i] + " where user_id=" + uid);
//				rs.next();
//				if (rs.getInt("nos") > 0)
//					count += 1;
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}

	public int timeOutCheck(int uid) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("SELECT * FROM users WHERE users.id = " + uid
					+ " and users.created_at > DATE_SUB(NOW(), INTERVAL 3 HOUR)");
//			int tcount = testCaseCount(uid);
			/* Modify tcount to base */
			if (!rs.isBeforeFirst()) {
				Statement st3 = mConn.createStatement();
				st3.executeUpdate("UPDATE users SET completion = 1 WHERE id='" + uid + "'");
				return 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public void updateCompletionState(String uid) throws ClassNotFoundException, IOException, SQLException {
		try {
			Statement st3 = mConn.createStatement();
			st3.executeUpdate("UPDATE users SET completion = 2 WHERE id='" + uid + "'");
			boolean uniq = true;
			Statement st = mConn.createStatement();
			ResultSet rs;
			String salt = "";
			while (uniq) {
				salt = getSaltString();
				rs = st.executeQuery("select id from users where completion_code = '" + salt + "'");
				if (!rs.isBeforeFirst())
					uniq = false;
			}
			st3.executeUpdate("UPDATE users SET completion_code = '" + salt + "' WHERE id='" + uid + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected String getSaltString() {
		String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		StringBuilder salt = new StringBuilder();
		Random rnd = new Random();
		while (salt.length() < 10) {
			int index = (int) (rnd.nextFloat() * SALTCHARS.length());
			salt.append(SALTCHARS.charAt(index));
		}
		String saltStr = salt.toString();
		return saltStr;
	}

	public String getCompletionCode(String uid) throws ClassNotFoundException, IOException, SQLException {
		String ret = "";
		try {
			Statement st = mConn.createStatement();
			ResultSet rs = st.executeQuery("select completion_code from users where id = " + uid);
			rs.next();
			ret = rs.getString("completion_code");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public ResultSet getQuestions(String TableName) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from " + TableName);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public int responseData(String table, String uid, String parameterName, String parameterValue)
			throws ClassNotFoundException, IOException, SQLException {
		int count = 0;
		String dtime = currentDateTIme();
		try {
			PreparedStatement statement = mConn.prepareStatement(
					"INSERT INTO `" + table + "`(`question_id`, `user_id`, `description`, `created_at`) VALUES ('"
							+ parameterName + "','" + uid + "', ?, '" + dtime + "')");
			statement.setString(1, parameterValue);
			count += statement.executeUpdate();
			statement.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	}

//	public int discResponseData(String uid, String gid, String iid, String val)
//			throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `discpersonality_responses`(`user_id`, `group_no`, `item_no`, `response`, `created_at`) VALUES ('"
//							+ uid + "','" + gid + "','" + iid + "','" + val + "','" + dtime + "')");
//			count += statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//
//	}
//
//	public int mbtiResponseData(String uid, String gid, String iid)
//			throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `mbtipersonality_responses`(`user_id`, `group_no`, `choice_no`, `created_at`) VALUES ('"
//							+ uid + "','" + gid + "','" + iid + "','" + dtime + "')");
//			count += statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}
//
//	public int genericResponseData(String uid, String gid, String iid)
//			throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `generic_responses`(`user_id`, `generic_name`, `choice_no`, `created_at`) VALUES ('"
//							+ uid + "','" + gid + "','" + iid + "','" + dtime + "')");
//			count += statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}
//
//	public int processPersonalities(String uid) throws ClassNotFoundException, IOException, SQLException {
//		int ret = 0;
//		int IO = 0, IC = 0, IE = 0, IA = 0, IN = 0;
//		int E = 0, I = 0, S = 0, N = 0, T = 0, F = 0, J = 0, P = 0;
//		int rem = 0, val = 0;
//		try {
//			Statement st = mConn.createStatement();
//			ResultSet rs;
//			rs = st.executeQuery("select * from personality_responses where user_id = " + uid);
//			while (rs.next()) {
//				rem = rs.getInt("question_id") % 10;
//				val = rs.getInt("description");
//				switch (rem) {
//				case 1:
//					IO += val;
//					break;
//				case 2:
//					IC += val;
//					break;
//				case 3:
//					IE += val;
//					break;
//				case 4:
//					IA += val;
//					break;
//				case 5:
//					IN += val;
//					break;
//				case 6:
//					IO += 6 - val;
//					break;
//				case 7:
//					IC += 6 - val;
//					break;
//				case 8:
//					IE += 6 - val;
//					break;
//				case 9:
//					IA += 6 - val;
//					break;
//				case 0:
//					IN += 6 - val;
//					break;
//				}
//			}
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `personality_data`(`uid`, `ipip_E`, `ipip_A`, `ipip_C`, `ipip_N`, `ipip_O`) VALUES ('"
//							+ uid + "','" + IE + "','" + IA + "','" + IC + "','" + IN + "','" + IO + "')");
//			ret = statement.executeUpdate();
//			/*
//			 * MBTI DATA rs = st.
//			 * executeQuery("select * from mbtipersonality_responses where user_id = "
//			 * + uid); while (rs.next()) { rem = rs.getInt("group_no") % 7; val
//			 * = rs.getInt("choice_no"); switch (rem) { case 1: ret = (val == 1)
//			 * ? ++E : ++I; break; case 2: case 3: ret = (val == 1) ? ++S : ++N;
//			 * break; case 4: case 5: ret = (val == 1) ? ++T : ++F; break; case
//			 * 6: case 0: ret = (val == 1) ? ++J : ++P; break; } } String sql =
//			 * "UPDATE personality_data SET mbti_E = '" + E + "', mbti_I = '" +
//			 * I + "', mbti_S = '" + S + "', mbti_N = '" + N + "', mbti_T = '" +
//			 * T + "', mbti_F = '" + F + "', mbti_J = '" + J + "', mbti_P = '" +
//			 * P + "' WHERE uid=" + uid; ret = st.executeUpdate(sql); CREATIVITY
//			 * DATA int creativityIndex = 0; int[] positiveAttributeStr = { 0,
//			 * 2, 4, 5, 7, 9, 11, 13, 16, 18, 19, 20, 22, 24, 25, 26, 28, 29 };
//			 * boolean[] positiveAttribute = new boolean[30]; for (int
//			 * positiveIndex : positiveAttributeStr) {
//			 * positiveAttribute[positiveIndex] = true; } rs =
//			 * st.executeQuery("select * from creativity_responses where user_id
//			 * = " + uid); while (rs.next()) { creativityIndex +=
//			 * positiveAttribute[rs.getInt("question_id") - 1] ?
//			 * rs.getInt("description") : (6 - rs.getInt("description")); }
//			 * String sql = "UPDATE personality_data SET creativity = " +
//			 * creativityIndex + " WHERE uid=" + uid; ret =
//			 * st.executeUpdate(sql);
//			 */
//			ret += processDiscPersonality(uid);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return ret;
//	}
//
//	public int processDiscPersonality(String uid) {
//		String[][] discData = { { "I", "C", "S", "D" }, { "D", "I", "S", "C" }, { "S", "C", "D", "I" },
//				{ "C", "D", "I", "S" }, { "C", "I", "S", "D" }, { "S", "I", "C", "D" }, { "D", "C", "S", "I" },
//				{ "I", "S", "C", "D" }, { "S", "C", "D", "I" }, { "C", "S", "I", "D" }, { "D", "I", "S", "C" },
//				{ "I", "S", "C", "D" }, { "S", "C", "D", "I" }, { "C", "D", "I", "S" }, { "D", "I", "S", "C" },
//				{ "C", "D", "S", "I" }, { "I", "S", "D", "C" }, { "S", "D", "C", "I" }, { "D", "I", "S", "C" },
//				{ "C", "S", "D", "I" }, { "I", "S", "C", "D" }, { "S", "C", "D", "I" }, { "C", "D", "I", "S" },
//				{ "S", "D", "C", "I" }, { "D", "I", "S", "C" }, { "I", "S", "C", "D" }, { "I", "S", "C", "D" },
//				{ "C", "D", "I", "S" } };
//		int[] raws = { 0, 0, 0, 0 };
//		float[] norms = { 28, 28, 28, 28 };
//		int returnValue = 0, totalDisc = 0;
//		try {
//			Statement st = mConn.createStatement();
//			ResultSet rs = st.executeQuery(
//					"SELECT group_no, item_no, response FROM `discpersonality_responses` WHERE user_id = " + uid);
//			while (rs.next()) {
//				switch (discData[rs.getInt("group_no") - 1][rs.getInt("item_no") - 1]) {
//				case "D":
//					returnValue += (rs.getString("response").equals("yes")) ? ++raws[0] : --raws[0];
//					break;
//				case "I":
//					returnValue += (rs.getString("response").equals("yes")) ? ++raws[1] : --raws[1];
//					break;
//				case "S":
//					returnValue += (rs.getString("response").equals("yes")) ? ++raws[2] : --raws[2];
//					break;
//				case "C":
//					returnValue += (rs.getString("response").equals("yes")) ? ++raws[3] : --raws[3];
//					break;
//				default:
//					System.out.println("Wrong value for Disc");
//					break;
//				}
//			}
//			totalDisc = raws[0] + raws[1] + raws[2] + raws[3] + (28 * 4);
//			int i = 0;
//			int maxValIndex = 0;
//			for (i = 0; i < 4; i++) {
//				norms[i] += raws[i];
//				norms[i] /= totalDisc;
//				if (norms[i] > norms[maxValIndex])
//					maxValIndex = i;
//			}
//			String maxDisc = (maxValIndex < 2) ? ((maxValIndex == 0) ? "D" : "I") : ((maxValIndex == 2) ? "S" : "C");
//			PreparedStatement statement = mConn.prepareStatement(
//					"UPDATE personality_data SET rawD = ?, rawI = ?, rawS = ?, rawC = ?, normD = ?, normI = ?, normS = ?, normC = ? where uid = "
//							+ uid);
//			i = 1;
//			while (i < 5) {
//				statement.setInt(i, raws[i - 1]);
//				i++;
//			}
//			while (i < 9) {
//				statement.setFloat(i, norms[i - 5]);
//				i++;
//			}
//			returnValue = statement.executeUpdate();
//			statement = mConn.prepareStatement("UPDATE users SET personality = ? where id = " + uid);
//			statement.setString(1, maxDisc);
//			statement.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return returnValue;
//	}
//
//	public int addUseCase(String descr) throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `requirements`(`description`, `created_at`) VALUES (?,'" + dtime + "')");
//			statement.setString(1, descr);
//			;
//			count = statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//
//	}
//
//	public ResultSet getRequirements() throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery("select * from requirements");
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//
//	public ResultSet getRequirement(String id) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery("select * from requirements where id=" + id);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//
//	public int addTestCase(String rid, String uid, String gid, String cont, String stim, String behv)
//			throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `testcases` (`rid`, `uid`, `gid`, `context`, `stimuli`, `behavior`, `created_at`) VALUES ("
//							+ rid + "," + uid + "," + gid + ",?,?,?,'" + dtime + "')");
//			statement.setString(1, cont);
//			statement.setString(2, stim);
//			statement.setString(3, behv);
//			count = statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//
//	}
//
//	public ResultSet getTestCases(String rid, String gid, String uid, String gtype)
//			throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			if (Integer.parseInt(gtype) > 1) {
//				rs = st.executeQuery(
//						"select testcase.*, user.name from testcases testcase, users user where testcase.uid=user.id AND testcase.rid="
//								+ rid + " AND testcase.gid=" + gid + " AND testcase.published='1'");
//			} else {
//				rs = st.executeQuery(
//						"select testcase.*, user.name from testcases testcase, users user where testcase.uid=user.id AND testcase.rid="
//								+ rid + " AND testcase.uid=" + uid + " AND testcase.published='1'");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//
//	public String getCommentCount(String tid) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery(
//					"SELECT COUNT(*) as nos FROM comments where pid='" + tid + "' AND parent_type='testcase'");
//			rs.next();
//			return rs.getString("nos");
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return "0";
//	}
//
//	public ResultSet viewTestCase(String id, String gid) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery(
//					"select testcase.*, user.name from testcases testcase, users user where testcase.uid=user.id AND testcase.id="
//							+ id + " AND testcase.gid=" + gid);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//
//	public int editTestCase(String tid, String uid, String cont, String stim, String behv) {
//		int ret = 0;
//		try {
//			// Insert into `testcase_history` (`pid`, `context`, `stimuli`,
//			// `behavior`, `created_at`) SELECT id, context, stimuli, behavior,
//			// created_at from `testcases` where id='2'
//			PreparedStatement statement = mConn.prepareStatement(
//					"Insert into `testcase_history` (`pid`, `context`, `stimuli`, `behavior`, `created_at`)  SELECT id, context, stimuli, behavior, created_at from `testcases` where id="
//							+ tid);
//			statement.executeUpdate();
//			statement.close();
//
//			PreparedStatement st = mConn
//					.prepareStatement("UPDATE testcases SET context = ?, stimuli = ?, behavior = ? WHERE id=" + tid);
//			st.setString(1, cont);
//			st.setString(2, stim);
//			st.setString(3, behv);
//			ret = st.executeUpdate();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return ret;
//	}
//
//	public ResultSet getComments(String type, String tid, String gid)
//			throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery(
//					"select comment.*, user.name from comments comment, users user where comment.uid=user.id AND comment.pid="
//							+ tid + " AND comment.parent_type='" + type + "' AND comment.gid=" + gid);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//
//	public String getReplyCount(String cid) throws ClassNotFoundException, IOException, SQLException {
//		try {
//			ResultSet rs = null;
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery(
//					"SELECT COUNT(*) as nos FROM comments where pid='" + cid + "' AND parent_type='comment'");
//			rs.next();
//			return rs.getString("nos");
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return "0";
//	}
//
//	public int addComment(String parent, String pid, String uid, String gid, String descr)
//			throws IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `comments` (`parent_type`, `pid`, `uid`, `gid`, `description`, `created_at`) VALUES ('"
//							+ parent + "'," + pid + "," + uid + "," + gid + ",?,'" + dtime + "')");
//			statement.setString(1, descr);
//			count = statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}

	public void addNotification(String parentType, String parentId, String groupId, String submitter) {
		String dtime = currentDateTIme();
		String content = "";
		String link = "";
		try {
			if (parentType.equals("testcase")) {
				content = submitter + " added a new testcase";
				link = "viewTestCases.jsp?id=" + parentId;
			} else if (parentType == "comment") {
				content = submitter + " commented on a testcase";
				link = "viewComments.jsp?id=" + parentId;
			} else if (parentType == "discussion") {
				content = submitter + " posted in discussion";
				link = "discussions.jsp";
			}
			PreparedStatement statement = mConn
					.prepareStatement("INSERT INTO `notifications`(`gid`, `link`, `content`, `created_at`) VALUES ("
							+ groupId + ", '" + link + "', '" + content + "', '" + dtime + "')");
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ResultSet getNotifications(int groupId) {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery(
					"select link, content, created_at from notifications where gid = " + groupId + " order by id desc");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet getMenu(String SeqNo) {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from statuses where seq_no = '" + SeqNo + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

//	public void executeMbtiQuery() {
//		try {
//			Statement st = mConn.createStatement();
//			int num = 0;
//			for (int i = 1; i < 211; i++) {
//				String sql = "UPDATE mbtipersona SET choice_no=" + num + " WHERE id=" + i;
//				st.executeUpdate(sql);
//				num++;
//				if (num == 3)
//					num = 0;
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}

}
