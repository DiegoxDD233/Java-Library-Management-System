package service;

import java.util.List;

import books.web.utils.PageTool;
import dao.UserDao;
import entity.UserDB;

/**
 * user service layer
 */
public class UserService {
	
	private UserDao userDao = new UserDao();
	
	/**
	 * login
	 * @param account
	 * @param password
	 * @return
	 */
	public UserDB login(String account,String password) {
		return userDao.login(account,password);
	}
	
	
	/**
	 * add user
	 * @param userDB
	 * @return
	 */
	public Integer addUser(UserDB userDB) {
		return userDao.addUser(userDB);
	}
	
	
	public PageTool<UserDB> list(String currentPage, String pageSize,Integer order){
		return userDao.list(currentPage,pageSize,order );
	}
	
	public List<UserDB> getList(UserDB userDB){
		return userDao.getList(userDB);
	}
	
	/**
	 * manager update user data
	 * @param userDB
	 * @return
	 */
	public Integer updUser(UserDB userDB) {
		return userDao.updUser(userDB);
	}
	
	/**
	 * delete user
	 * @param uid
	 * @return
	 */
	public Integer delUser(Integer uid) {
		return userDao.delUser(uid);
	}
	
}
