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
import entity.ProblemDB;

public class ProblemDao {

	QueryRunner queryRunner = new QueryRunner(C3p0Tool.getDataSource());
	//set auto translation
	BeanProcessor bean = new GenerousBeanProcessor();
	RowProcessor processor = new BasicRowProcessor(bean);
	
	public PageTool<ProblemDB> list(String currentPage, String pageSize, String word, Integer order, Integer uid){
		
		try {
			StringBuffer listSql = new StringBuffer("select p.*,name,account ");
			StringBuffer countSql = new StringBuffer("select count(*) ");
			StringBuffer sql = new StringBuffer("from t_problem p LEFT JOIN t_user t ON p.uid = u.uid where 1 = 1");
			List<Object> params = new ArrayList<>();
			if (word != null && !word.isEmpty()) {
				sql.append(" or title like '%" + word + "%'");
				sql.append(" or page like '%" + word + "%'");
				sql.append(" or content like '%" + word + "%'");
				sql.append(" or name like '%" + word + "%'");
				sql.append(" or account like '%" + word + "%'");
				
			}
			if(uid != null) {
				sql.append(" and p.uid = ?");
				params.add(uid);
			}
			if(order != null && order == 1) {
				sql.append(" order by times desc");
			}
			
			//get total count
			Long total = queryRunner.query(countSql.append(sql).toString(), new ScalarHandler<Long>(),params.toArray());
			//initialize
			PageTool<ProblemDB> pageTools = new PageTool<ProblemDB>(total.intValue(),currentPage,pageSize);
			sql.append(" limit ?,?");
			params.add(pageTools.getStartIndex());
			params.add(pageTools.getPageSize());
			//get current page data
			
			List<ProblemDB> list = queryRunner.query(listSql.append(sql).toString(),new BeanListHandler<ProblemDB>(ProblemDB.class,processor),params.toArray());
			pageTools.setRows(list);
			System.out.println(pageTools);
			return pageTools;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new PageTool<ProblemDB>(0,currentPage,pageSize);
	}
	
	public Integer addProblem(ProblemDB problemDB) {
		String sql = "insert into t_problem (uid,title,page,content,link,status,time) values (?,?,?,?,?,?,?)";
		Object[] params = {problemDB.getUid(),problemDB.getTitle(),problemDB.getContent(),problemDB.getLink(),problemDB.getStatus(),problemDB.getTime()};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public Integer updProblem(ProblemDB problemDB) {
		String sql = "update t_problem set status = ? where pid = ?";
		Object[] params = {problemDB.getStatus(),problemDB.getPid()};
		try {
			return queryRunner.update(sql,params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	public Integer delProblem(String pid) {
		String sql = "delete from t_problem where pid = ?";
		Object[] params = {pid};
		try {
			return queryRunner.update(sql,params);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
}
