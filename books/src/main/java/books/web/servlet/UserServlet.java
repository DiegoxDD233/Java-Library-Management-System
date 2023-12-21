package books.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import books.web.utils.MD5;
import books.web.utils.PageTool;
import books.web.utils.PaginationUtils;
import books.web.utils.ResBean;
import entity.UserDB;
import service.UserService;

/**
 * user
 */
@WebServlet("/user")
public class UserServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private UserService userService = new UserService();

	
	/**
	 * user list
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<UserDB> pageTool = userService.list(currentPage,pageSize,null);
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(), "user?method=list");
		request.setAttribute("pagation", pagation);
		
		request.setAttribute("uList", pageTool.getRows());
		request.getRequestDispatcher("admin/admin_user.jsp").forward(request, response);
	}
	
	
	
	
	/**
	 * add user
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public void addUser(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException, IllegalAccessException, InvocationTargetException {
		/*
		 * String account = request.getParameter("account"); String password =
		 * request.getParameter("password"); String name = request.getParameter("name");
		 * String phone = request.getParameter("phone"); String maxNum =
		 * request.getParameter("maxNum"); String lendNum =
		 * request.getParameter("lendNum"); String role = request.getParameter("role");
		 * UserDB userDB = new UserDB(); userDB.setAccount(account);
		 * userDB.setPassword(password); userDB.setName(name); userDB.setPhone(phone);
		 * userDB.setMaxNum(Integer.parseInt(maxNum));
		 * userDB.setLendNum(Integer.parseInt(lendNum));
		 * userDB.setRole(Integer.parseInt(role)); System.out.println(userDB);
		 */
		UserDB userDB = new UserDB();
		BeanUtils.populate(userDB, request.getParameterMap());
		userDB.setTimes(0);
		userDB.setPassword(MD5.valueOf(userDB.getPassword()));
		System.out.println(userDB);
		userService.addUser(userDB);
		response.sendRedirect("user?method=list");
	}
	
	
	/**
	 * manager change user data
	 * @param userDB
	 * @return
	 */
	public void updUser(HttpServletRequest request,HttpServletResponse response) throws Exception {
		UserDB userDB = new UserDB();
		BeanUtils.populate(userDB, request.getParameterMap());
		userService.updUser(userDB);
		response.sendRedirect("user?method=list");
	}
	
	/**
	 * delete user info
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void delUser(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String uid = request.getParameter("uid");
		userService.delUser(Integer.parseInt(uid));
		response.sendRedirect("user?method=list");
	}
	
	/**
	 * check if account exist
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	public void checkUser(HttpServletRequest request,HttpServletResponse response) throws IOException  {
		String account = request.getParameter("account");
		UserDB userDB = new UserDB();
		userDB.setAccount(account);
		List<UserDB> list = userService.getList(userDB);
		ResBean resBean = new ResBean();
		if (list != null && list.size()>0) {
			//request.setAttribute("msg", "账号已被占用");
			resBean.setCode(400);
			resBean.setMsg("account exist");
		}else {
			resBean.setCode(200);
			resBean.setMsg("account available");
		}
		//set resBean into json string
		Gson gson = new Gson();
		String json = gson.toJson(resBean);
		response.getWriter().print(json);
		
		
		
	}
	
	/**
	 * best reader rank
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void rank(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		Integer role = userDB.getRole();
		
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<UserDB> pageTool = userService.list(currentPage,pageSize,1);
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(), "user?method=rank");
		request.setAttribute("pagation", pagation);
		request.setAttribute("start", pageTool.getStartIndex());
		request.setAttribute("uList", pageTool.getRows());
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/brtimes.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_brtimes.jsp").forward(request, response);
		}
	}
	
	
}
