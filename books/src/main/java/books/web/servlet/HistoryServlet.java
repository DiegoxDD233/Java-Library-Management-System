package books.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import books.web.utils.PageTool;
import books.web.utils.PaginationUtils;
import entity.HistoryDB;
import entity.UserDB;
import service.HistoryService;

/**
 * book borrow history
 */
@WebServlet("/history")
public class HistoryServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private HistoryService historyService = new HistoryService();
	
	/**
	 * check current borrow data
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		//get role 
		Integer role = userDB.getRole();
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		//normal user can only check himself, manager check all
		PageTool<HistoryDB> pageTool = null;
		if(role == 1) {
			//normal user
			pageTool = historyService.listByPage(currentPage, pageSize, userDB.getUid(), 1);
		}else {
			//manager
			pageTool = historyService.listByPage(currentPage, pageSize, null, 1);
		}
		
		String path = "history?method=list";
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(),path );
		request.setAttribute("pagation", pagation);
		request.setAttribute("hList", pageTool.getRows());
		//choose target page based on role
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/borrow.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_borrow.jsp").forward(request, response);
		}
		
	}
	
	/**
	 * check current return data
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void backList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		//get role 
		Integer role = userDB.getRole();
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		//normal user can only check himself, manager check all
		PageTool<HistoryDB> pageTool = null;
		if(role == 1) {
			//normal user
			pageTool = historyService.listByPage(currentPage, pageSize, userDB.getUid(), 2);
		}else {
			//manager
			pageTool = historyService.listByPage(currentPage, pageSize, null, 2);
		}
		
		String path = "history?method=backList";
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(),path );
		request.setAttribute("pagation", pagation);
		request.setAttribute("hList", pageTool.getRows());
		//choose target page based on role
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/history.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_history.jsp").forward(request, response);
		}
		
	}
	
	
	/**
	 * return books delay
	 * @param request
	 * @param response
	 * @throws SQLException
	 * @throws ServletException
	 * @throws IOException
	 */
	public void delay(HttpServletRequest request,HttpServletResponse response) throws SQLException, ServletException, IOException {
		String hid = request.getParameter("hid");
		String endTime = request.getParameter("endtime");
		HistoryDB historyDB = new HistoryDB();
		historyDB.setHid(Integer.parseInt(hid));
		// 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        // 将字符串转换为 LocalDateTime
        LocalDateTime localDateTime = LocalDateTime.parse(endTime, formatter);
		historyDB.setEndTime(localDateTime);
		historyService.updHistory(historyDB);
		request.getRequestDispatcher("history?method=list").forward(request, response);
		
	}
	
}
