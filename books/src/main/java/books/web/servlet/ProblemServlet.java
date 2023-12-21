package books.web.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import books.web.utils.PageTool;
import books.web.utils.PaginationUtils;
import entity.ProblemDB;
import entity.UserDB;
import service.ProblemService;

@WebServlet("/problem")
public class ProblemServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ProblemService problemService = new ProblemService();
	
	public void listByPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		//get role 
		Integer role = userDB.getRole();
		String word = request.getParameter("word");
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<ProblemDB> pageTool = null;
		if (role == 1) {
			//normal user
			pageTool = problemService.list(currentPage, pageSize, word, 1, userDB.getUid());
		}else {
			//manager
			pageTool = problemService.list(currentPage, pageSize, word, 1, null);
		}
		String path = "problem?method=listByPage";
		if (word != null && word != "") {
			path += "&word=" + word;
		}
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(),path );
		request.setAttribute("pagation", pagation);
		request.setAttribute("bList", pageTool.getStartIndex());
		request.setAttribute("bList", pageTool.getRows());
		//choose target page based on role
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/feedback.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_feedback.jsp").forward(request, response);
		}
		
	}
	
	public void addProblem(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ProblemDB problemDB = new ProblemDB();
		BeanUtils.populate(problemDB, request.getParameterMap());
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		problemDB.setUid(userDB.getUid());
		problemDB.setStatus(0);
		problemDB.setTime(LocalDateTime.now());
		problemService.addProblem(problemDB);
		response.sendRedirect("problem?method=listByPage");
	}
	
	public void updProblem(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ProblemDB problemDB = new ProblemDB();
		BeanUtils.populate(problemDB, request.getParameterMap());
		problemService.updProblem(problemDB);
		response.sendRedirect("problem?method=listByPage");
	}
	
	
	public void delProblem(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String pid = request.getParameter("pid");
		problemService.delProblem(pid);
		response.sendRedirect("problem?method=listByPage");
	}
}
