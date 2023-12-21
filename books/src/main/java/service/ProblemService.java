package service;

import books.web.utils.PageTool;
import dao.ProblemDao;
import entity.ProblemDB;

public class ProblemService {

	private ProblemDao problemDao = new ProblemDao();
	
	public PageTool<ProblemDB> list(String currentPage, String pageSize, String word, Integer order, Integer uid){
		return problemDao.list(currentPage, pageSize, word, order, uid);
	}
	
	public Integer addProblem(ProblemDB problemDB) {
		return problemDao.addProblem(problemDB);
	}
	
	public Integer updProblem(ProblemDB problemDB) {
		return problemDao.updProblem(problemDB);
	}
	
	public Integer delProblem(String pid) {
		return problemDao.delProblem(pid);
	}
	
}
