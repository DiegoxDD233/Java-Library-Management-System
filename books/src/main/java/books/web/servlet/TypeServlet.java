package books.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import books.web.utils.PageTool;
import books.web.utils.PaginationUtils;
import books.web.utils.ResBean;
import entity.TypeDB;
import service.TypeService;

/**
 * book classification
 */
@WebServlet("/type")
public class TypeServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private TypeService typeService = new TypeService();
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void listByPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String currentPage = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		PageTool<TypeDB> pageTool = typeService.listByPage(currentPage,pageSize);
		//generate frontend separate button
		String pagation = PaginationUtils.getPagation(pageTool.getTotalCount(), pageTool.getCurrentPage(), pageTool.getPageSize(), "type?method=listByPage");
		request.setAttribute("pagation", pagation);
		
		request.setAttribute("tList", pageTool.getRows());
		request.getRequestDispatcher("admin/admin_booktype.jsp").forward(request, response);
	}
	
	/**
	 * type name check
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void checkType(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//String tid = request.getParameter("tid");
		String typeName = request.getParameter("typeName");
		List<TypeDB> list = typeService.list(null, typeName);
		ResBean resBean = new ResBean();
		if (list != null && list.size()>0) {
			resBean.setCode(400);
			resBean.setMsg("book type exist");
		}else {
			resBean.setCode(200);
			resBean.setMsg("book type available");
		}
		//set resBean into json string
		Gson gson = new Gson();
		String json = gson.toJson(resBean);
		response.getWriter().print(json);
	
	}
	
	/**
	 * add type
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void addType(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String typeName = request.getParameter("typeName");
		typeService.addType(typeName);
		request.getRequestDispatcher("type?method=listByPage").forward(request, response);
	}
	
	/**
	 * change type
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void updType(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String tid = request.getParameter("tid");
		String typeName = request.getParameter("typeName");
		TypeDB typeDB = new TypeDB();
		typeDB.setTid(Integer.parseInt(tid));
		typeDB.setTypeName(typeName);
		typeService.updType(typeDB);
		request.getRequestDispatcher("type?method=listByPage").forward(request, response);
	}
	
	/**
	 * delete type
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void delType(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String tid = request.getParameter("tid");
		typeService.delType(Integer.parseInt(tid));
		request.getRequestDispatcher("type?method=listByPage").forward(request, response);
	}
	
}
