package books.web.utils;

import java.sql.SQLException;

import dao.HistoryDao;
import entity.HistoryDB;

public class TestDemo {

	public static void main(String[] args) throws SQLException {
		HistoryDao historyDao = new HistoryDao();
		HistoryDB historyDB = new HistoryDB();
		historyDB.setHid(1);
		historyDB.setStatus(2);
		System.out.println(historyDao.updHistory(historyDB,C3p0Tool.getConnection()));
		
	}
	
	
}
