package dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import books.web.utils.C3p0Tool;
import books.web.utils.PageTool;
import entity.UserDB;



/**
 * user's data connection layer
 * 
 */

public class UserDao {
	
	QueryRunner queryRunner = new QueryRunner(C3p0Tool.getDataSource());
	//set auto translation
	BeanProcessor bean = new GenerousBeanProcessor();
	RowProcessor processor = new BasicRowProcessor(bean);
	
	/**
	 * user login 
	 * @param account
	 * @param password
	 * @return
	 */
	
	
	public UserDB login(String account, String password) {
		String sql = "select * from t_user where account = ? and password = ?";
		Object[] params = {account,password};//{account,password};
		try {
			
			return queryRunner.query(sql, new BeanHandler<UserDB>(UserDB.class,processor),params);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * user list
	 * separate page
	 * @return
	 */
	public PageTool<UserDB> list(String currentPage, String pageSize,Integer order){
		
		try {
			StringBuffer listSql = new StringBuffer("select * ");
			StringBuffer countSql = new StringBuffer("select count(*) ");
			StringBuffer sql = new StringBuffer("from t_user");
			if(order != null && order == 1) {
				sql.append(" where role = 1 order by times desc");
			}
			
			//get total count
			Long total = queryRunner.query(countSql.append(sql).toString(), new ScalarHandler<Long>());
			//initialize
			PageTool<UserDB> pageTools = new PageTool<UserDB>(total.intValue(),currentPage,pageSize);
			sql.append(" limit ?,?");
			//get current page data
			
			List<UserDB> list = queryRunner.query(listSql.append(sql).toString(),new BeanListHandler<UserDB>(UserDB.class,processor),pageTools.getStartIndex(),pageTools.getPageSize());
			pageTools.setRows(list);
			System.out.println(pageTools);
			return pageTools;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new PageTool<UserDB>(0,currentPage,pageSize);
	}
	
	/**
	 * add user
	 * @param userDB
	 * @return
	 */
	public Integer addUser(UserDB userDB) {
		String sql = "insert into t_user (account,password,name,phone,times,lend_num,max_num,role) values (?,?,?,?,?,?,?,?)";
		Object[] params = {userDB.getAccount(),userDB.getPassword(),userDB.getName(),userDB.getPhone(),userDB.getTimes(),userDB.getLendNum(),userDB.getMaxNum(),userDB.getRole()};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	public List<UserDB> getList(UserDB userDB){
		String sql = "select * from t_user where account = ?";
		Object[] params = {userDB.getAccount()};
		try {
			return queryRunner.query(sql,new BeanListHandler<UserDB>(UserDB.class,processor),params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
	
	/**
	 * manager change user data
	 * @param userDB
	 * @return
	 */
	public Integer updUser(UserDB userDB) {
		String sql = "update t_user set phone = ?, lend_num = ?, max_num = ? where uid = ?";
		Object[] params = {userDB.getPhone(),userDB.getLendNum(),userDB.getMaxNum(),userDB.getUid()};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	/**
	 * change book borrow info
	 * @param userDB
	 * @return
	 * @throws SQLException
	 */
	public Integer updNum(UserDB userDB, Connection conn) throws SQLException {
		QueryRunner qr = new QueryRunner();
		String sql = "update t_user set times = ?, max_num = ? where uid = ?";
		Object[] params = {userDB.getTimes(),userDB.getMaxNum(),userDB.getUid()};
		return qr.update(C3p0Tool.getConnection(), sql, params);
		
	}
	
	/**
	 * delete user
	 * @param uid
	 */
	public int delUser(Integer uid) {
		String sql = "delete from t_user where uid = ?";
		Object[] params = {uid};
		try {
			int i = queryRunner.update(sql,params);
			return i;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
