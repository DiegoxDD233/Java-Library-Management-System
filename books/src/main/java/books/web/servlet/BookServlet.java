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

import books.web.utils.PageTool;
import books.web.utils.PaginationUtils;
import books.web.utils.ResBean;
import entity.BookDB;
import entity.TypeDB;
import entity.UserDB;
import service.BookService;
import service.TypeService;

@WebServlet("/book")
public class BookServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private BookService bookService = new BookService();
	
	private TypeService typeService = new TypeService();
	
	/**
	 * book list
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	public void listByPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		//get role 
		Integer role = userDB.getRole();
		String word = request.getParameter("word");
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<BookDB> pageTool = bookService.listByPage(currentPage,pageSize,word,null);
		String path = "book?method=listByPage";
		if (word != null && word != "") {
			path += "&word=" + word;
		}
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(),path );
		List<TypeDB>typeList = typeService.list(null, null);
		request.setAttribute("pagation", pagation);
		request.setAttribute("typeList", typeList);
		request.setAttribute("word", word);
		request.setAttribute("bList", pageTool.getRows());
		//choose target page based on role
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/select.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_book.jsp").forward(request, response);
		}
		
	}
	
	/**
	 * book name check
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void checkBook(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//String tid = request.getParameter("tid");
		String bookName = request.getParameter("bookName");
		List<BookDB> list = bookService.list(bookName);
		ResBean resBean = new ResBean();
		if (list != null && list.size()>0) {
			resBean.setCode(400);
			resBean.setMsg("book name exist");
		}else {
			resBean.setCode(200);
			resBean.setMsg("book name available");
		}
		//set resBean into json string
		Gson gson = new Gson();
		String json = gson.toJson(resBean);
		response.getWriter().print(json);
	
	}
	
	/**
	 * add book
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public void addBook(HttpServletRequest request,HttpServletResponse response) throws Exception{
		BookDB bookDB = new BookDB();
		BeanUtils.populate(bookDB, request.getParameterMap());
		bookService.addBook(bookDB);
		response.sendRedirect("book?method=listByPage");
	}
	
	/**
	 * manager change book data
	 * @param userDB
	 * @return
	 */
	public void updBook(HttpServletRequest request,HttpServletResponse response) throws Exception {
		BookDB bookDB = new BookDB();
		BeanUtils.populate(bookDB, request.getParameterMap());
		bookService.updBook(bookDB);
		response.sendRedirect("book?method=listByPage");
	}
	
	/**
	 * delete book
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void delBook(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String bid = request.getParameter("bid");
		bookService.delBook(bid);
		request.getRequestDispatcher("book?method=listByPage").forward(request, response);
	}
	
	/**
	 * user borrow
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void borrowBook(HttpServletRequest request,HttpServletResponse response) throws Exception {
		//get book id
		String bid = request.getParameter("bid");
		//get user info
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		bookService.borrowBook(userDB,bid);
		response.sendRedirect("history?method=list");
	}
	
	/**
	 * return book
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void backBook(HttpServletRequest request,HttpServletResponse response) throws Exception {
		//get book return id
		String hid = request.getParameter("hid");
		//get user info
		bookService.backBook(hid);
		response.sendRedirect("history?method=backList");
	}
	
	/**
	 * popular book recommendation
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void rank(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserDB userDB = (UserDB) request.getSession().getAttribute("userDB");
		//get role 
		Integer role = userDB.getRole();
		
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<BookDB> pageTool = bookService.listByPage(currentPage,pageSize,null,1);
		String path = "book?method=rank";
		
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(),path );
		
		request.setAttribute("pagation", pagation);
		request.setAttribute("start", pageTool.getStartIndex());
		request.setAttribute("bList", pageTool.getRows());
		//choose target page based on role
		if (role == 1) {
			//normal user
			request.getRequestDispatcher("user/bdtimes.jsp").forward(request, response);
		}else {
			//manager
			request.getRequestDispatcher("admin/admin_bdtimes.jsp").forward(request, response);
		}
		
	}
	
}
