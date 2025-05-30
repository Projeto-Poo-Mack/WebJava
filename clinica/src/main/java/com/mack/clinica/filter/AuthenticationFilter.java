package com.mack.clinica.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // URLs que não precisam de autenticação
        String[] publicUrls = {
            "/index.jsp",
            "/loginAction",
            "/css/",
            "/js/",
            "/images/",
            "/logout"
        };
        
        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Verifica se a URL é pública
        boolean isPublicUrl = false;
        for (String url : publicUrls) {
            if (requestPath.startsWith(url)) {
                isPublicUrl = true;
                break;
            }
        }
        
        if (isPublicUrl) {
            chain.doFilter(request, response);
            return;
        }
        
        // Verifica a sessão
        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
            return;
        }
        
        // Configura o timeout da sessão para 30 minutos
        session.setMaxInactiveInterval(30 * 60);
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
} 