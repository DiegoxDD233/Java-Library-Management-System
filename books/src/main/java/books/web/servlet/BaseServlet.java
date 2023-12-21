package books.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import books.web.utils.MyException;

/**
 * all servlet needs to inherit this class
 */
public class BaseServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//set request code
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset = utf-8");
			
			//get method name
			String m = request.getParameter("method");
			//get class
			Class<? extends BaseServlet> clazz = this.getClass();
			//get function
			Method method = clazz.getDeclaredMethod(m, HttpServletRequest.class,HttpServletResponse.class);
			method.setAccessible(true);
			method.invoke(this,request,response);
		} catch (InvocationTargetException e) {
			if (e.getTargetException() instanceof MyException) {
				//it is myException
				request.setAttribute("msg", e.getTargetException().getMessage());
			}else {
				request.setAttribute("msg", "network error");
				e.printStackTrace();
			}
			request.getRequestDispatcher("error.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("baseServelet error");
			request.setAttribute("msg", "network fluctuation");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		
		}
		
		
		
	
	}
	
	
	
	
}
