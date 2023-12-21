package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import books.web.utils.C3p0Tool;
import books.web.utils.DateUtils;
import books.web.utils.MyException;
import books.web.utils.PageTool;
import dao.BookDao;
import dao.HistoryDao;
import dao.UserDao;
import entity.BookDB;
import entity.HistoryDB;
import entity.UserDB;

public class BookService {

	private BookDao bookDao = new BookDao();
	
	private HistoryDao historyDao = new HistoryDao();
	
	private UserDao userDao = new UserDao();
	
	/**
	 * book separate search
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageTool<BookDB> listByPage(String currentPage, String pageSize,String word, Integer order){
		return bookDao.listByPage(currentPage, pageSize,word,order);
	}
	
	public List<BookDB> list(String bookName){
		return bookDao.list(bookName,null);
	}
	
	public Integer addBook(BookDB bookDB) {
		return bookDao.addBook(bookDB);
	}
	
	public Integer updBook(BookDB bookDB) {
		return bookDao.updBook(bookDB);
	}
	
	public int delBook(String bid) {
		return bookDao.delbook(bid);
	}

	/**
	 * user borrow book
	 * @param userDB
	 * @param bid
	 * @throws SQLException 
	 */
	public void borrowBook(UserDB userDB, String bid)   {
		//get connection
		Connection conn = C3p0Tool.getConnection();
		try {
			//set not auto submit
			conn.setAutoCommit(false);
			// get book info based on bid
			List<BookDB> list = bookDao.list(null, bid);
			BookDB bookDB = list.get(0);
			//update same time
			userDB = userDao.getList(userDB).get(0);
			
			
			//t_history create book borrow history
			HistoryDB historyDB = new HistoryDB();
			historyDB.setUid(userDB.getUid());
			historyDB.setName(userDB.getName());
			historyDB.setAccount(userDB.getAccount());
			historyDB.setBid(bookDB.getBid());
			historyDB.setBookName(bookDB.getBookName());
			Date d = new Date();
			LocalDateTime dn = LocalDateTime.ofInstant(d.toInstant(), ZoneId.systemDefault());
			LocalDateTime dnn = LocalDateTime.ofInstant(DateUtils.dateAdd(d, userDB.getLendNum()).toInstant(), ZoneId.systemDefault());
			/**
			 * historyDB.setBeginTime(d);
			 * historyDB.setEndTime(DateUtils.dateAdd(d, userDB.getLendNum()));
			 */
			
			historyDB.setBeginTime(dn);
			historyDB.setEndTime(dnn);//return time = begin_time + lend_num
			historyDB.setStatus(1);
			historyDao.addhistory(historyDB,conn);
			
			
			
			//t_book change book.num--
			//change book.times++
			Integer num = bookDB.getNum();
			//check inventory
			if (num <= 0) {
				throw new MyException("inventory not enough");
			}
			
			bookDB.setNum(--num);
			Integer times = bookDB.getTimes();
			bookDB.setTimes(++times);
			bookDao.changeNum(bookDB,conn);
			
			//t_user change user.times++ user.max_num--
			userDB.setTimes(userDB.getTimes()+1);
			//check maxNum
			if (userDB.getMaxNum()<=0) {
				throw new MyException("borrow time full");
			}
			
			userDB.setMaxNum(userDB.getMaxNum()-1);
			userDao.updNum(userDB,conn);
			
			//submit
			conn.commit();
			
		}catch(Exception e){
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//check myException
			if (e instanceof MyException) {
				throw new MyException(e.getMessage());
			}else {
				e.printStackTrace();
				throw new MyException("fail to borrow");
			}
			
		}
		
	}
	
	/**
	 * return book
	 * @param userDB
	 * @param bid
	 * @throws SQLException
	 */
	public void backBook(String hid) {
		//get connection
		Connection conn = C3p0Tool.getConnection();
		try {
			//set not auto submit
			conn.setAutoCommit(false);
			
			//get historyDB based on hid, change status to 2
			HistoryDB historyDB = historyDao.list(hid).get(0);
			historyDB.setStatus(2);
			historyDao.updHistory(historyDB,conn);
			
			//get historyDB based on bid
			Integer bid = historyDB.getBid();
			
			//get book info based on bid, change num+1
			BookDB bookDB = bookDao.list(historyDB.getBookName(), bid+"").get(0);
			bookDB.setNum(bookDB.getNum()+1);
			bookDao.changeNum(bookDB,conn);
			
			//get account based on historyDB
			String account = historyDB.getAccount();
			
			
			//get userDB based on account, change max_num +1
			UserDB userDB = new UserDB();
			userDB.setAccount(account);
			userDB = userDao.getList(userDB).get(0);
			userDB.setMaxNum(userDB.getMaxNum()+1);
			userDao.updNum(userDB, conn);
			
			//submit
			conn.commit();
			
		}catch(Exception e){
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//check myException
			if (e instanceof MyException) {
				throw new MyException(e.getMessage());
			}else {
				e.printStackTrace();
				throw new MyException("fail to return");
			}
			
		}
		
	}
}
