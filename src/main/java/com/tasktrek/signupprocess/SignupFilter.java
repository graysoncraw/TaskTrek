package com.tasktrek.signupprocess;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;

/**
 * Servlet Filter implementation class SignupFilter
 */
@WebFilter("/SignupFilter")
public class SignupFilter extends HttpFilter implements Filter {
    public SignupFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// Get the IP address of client machine.
		HttpServletRequest req = (HttpServletRequest)request;
		String ipAddress = request.getRemoteAddr();
		// Log the IP address and current timestamp.
		System.out.println("IP "+ ipAddress + ", Time "+ new Date().toString());
		// Pass request back down the filter chain
		chain.doFilter(request,response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {

	}

}
