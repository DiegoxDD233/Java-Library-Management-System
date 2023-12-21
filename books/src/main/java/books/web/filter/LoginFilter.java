package books.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class LoginFilter implements Filter{

	
	@Override
		public void init(FilterConfig arg0) throws ServletException {
			// TODO Auto-generated method stub
			
		}
	

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//trans request and response
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		//get request path
		String uri = req.getRequestURI();
		//check path, choose to stop or not to stop
		if (uri.contains("/login") || uri.contains("/static")) {
			//let pass
			chain.doFilter(req, res);
		}else {
			//check if user login
			Object userDB = req.getSession().getAttribute("userDB");
			if (userDB != null) {
				//user has login, let pass
				chain.doFilter(request, response);
			}else {
				//has not login
				res.sendRedirect("login.jsp");
			}
		}
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	
	
}
