package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.BasicRowProcessor;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.GenerousBeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.RowProcessor;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import books.web.utils.C3p0Tool;
import books.web.utils.PageTool;
import entity.TypeDB;



/**
 * book types
 * 
 */
public class TypeDao {

	QueryRunner queryRunner = new QueryRunner(C3p0Tool.getDataSource());
	//set auto translation
	BeanProcessor bean = new GenerousBeanProcessor();
	RowProcessor processor = new BasicRowProcessor(bean);
	
	/**
	 * user list
	 * separate page
	 * @return
	 */
	public PageTool<TypeDB> listByPage(String currentPage, String pageSize){
		
		try {
			StringBuffer listSql = new StringBuffer("select * ");
			StringBuffer countSql = new StringBuffer("select count(*) ");
			StringBuffer sql = new StringBuffer("from t_type");
			//get total count
			Long total = queryRunner.query(countSql.append(sql).toString(), new ScalarHandler<Long>());
			//initialize
			PageTool<TypeDB> pageTools = new PageTool<TypeDB>(total.intValue(),currentPage,pageSize);
			sql.append(" limit ?,?");
			//get current page data
			
			List<TypeDB> list = queryRunner.query(listSql.append(sql).toString(),new BeanListHandler<TypeDB>(TypeDB.class,processor),pageTools.getStartIndex(),pageTools.getPageSize());
			pageTools.setRows(list);
			System.out.println(pageTools);
			return pageTools;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new PageTool<TypeDB>(0,currentPage,pageSize);
	}
	
	/**
	 * multi-search
	 * @param tid
	 * @param typeName
	 * @return
	 */
	public List<TypeDB> list(String tid, String typeName){
		StringBuffer sql = new StringBuffer("select * from t_type where 1 = 1 ");
		List<Object> params = new ArrayList<Object>();
		if(tid != null && tid != "") {
			sql.append("and tid = ?");
			params.add(tid);
		}
		if(typeName != null && typeName != "") {
			sql.append("and type_name = ?");
			params.add(typeName);
		}
		try {
			return queryRunner.query(sql.toString(), new BeanListHandler<TypeDB>(TypeDB.class,processor),params.toArray());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * add type
	 * @param 
	 * @return
	 */
	public Integer addType(String typeName) {
		String sql = "insert into t_type (type_name) values (?)";
		Object[] params = {typeName};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * manager change book type data
	 * @param userDB
	 * @return
	 */
	public Integer updType(TypeDB typeDB) {
		String sql = "update t_type set type_name = ? where tid = ?";
		Object[] params = {typeDB.getTypeName(),typeDB.getTid()};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	/**
	 * delete type
	 * @param uid
	 */
	public int delType(Integer tid) {
		String sql = "delete from t_type where tid = ?";
		Object[] params = {tid};
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
