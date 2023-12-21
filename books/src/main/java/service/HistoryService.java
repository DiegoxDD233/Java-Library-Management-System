package service;

import java.sql.SQLException;

import books.web.utils.PageTool;
import dao.HistoryDao;
import entity.HistoryDB;

public class HistoryService {

	private HistoryDao historyDao = new HistoryDao();
	
	public PageTool<HistoryDB> listByPage(String currentPage, String pageSize, Integer uid, Integer status){
		return historyDao.listByPage(currentPage, pageSize, uid, status);
	}
	
	public Integer updHistory(HistoryDB historyDB) throws SQLException {
		return historyDao.updHistory(historyDB);
	}
	
}
