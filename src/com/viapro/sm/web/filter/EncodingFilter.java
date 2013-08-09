package com.viapro.sm.web.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class EncodingFilter implements Filter {
	private static String charset = null;

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(charset);
		response.setCharacterEncoding(charset);
		EncodeHttpServletRequest enRequest = new EncodeHttpServletRequest(request);
		chain.doFilter(enRequest, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		charset = config.getInitParameter("charset");
	}
	
	/**
	 * Inner Class, set the way of CharacterEncoding.
	 */
	class EncodeHttpServletRequest extends HttpServletRequestWrapper {
		private HttpServletRequest request;
		private EncodeHttpServletRequest(ServletRequest request) {
			super((HttpServletRequest) request);
			this.request = (HttpServletRequest) request;
		}
		@Override
		public String getParameter(String name) {
			try {
				String value = request.getParameter(name);
				if (value == null)
					return null;
				if (!request.getMethod().equalsIgnoreCase("get")){
					return value;
				}
				value = new String(value.getBytes("ISO-8859-1"), charset);
				return value;
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
		}
	}
}
