/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package truongcn.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import truongcn.registration.RegistrationDAO;
import truongcn.registration.RegistrationDTO;
import truongcn.utils.MyApplicationConstants;

/**
 *
 * @author Chau Nhat Truong
 */
@WebServlet(name = "FisrtTimeRequestServlet", urlPatterns = {"/FisrtTimeRequestServlet"})
public class FisrtTimeRequestServlet extends HttpServlet {

//    private final String LOGIN_PAGE = "login.html";
////    private final String SEARCH_PAGE = "search.html";
//    private final String SEARCH_PAGE = "search.jsp";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        String url = LOGIN_PAGE;
        ServletContext context = this.getServletContext();
        Properties siteMaps = (Properties) context.getAttribute("SITE_MAP");
        String url = siteMaps.getProperty(
                MyApplicationConstants.FirstTimeRequestServlet.LOGIN_PAGE);
        try {
            //1. Get cookies
            Cookie[] cookies = request.getCookies();
            //2. Read last cookies
            if (cookies != null) {
                Cookie lastCookies = cookies[cookies.length - 1];
                String username = lastCookies.getName();
                String password = lastCookies.getValue();
                //3. Call DAO to checkLogin
                RegistrationDAO dao = new RegistrationDAO();
//                boolean result = dao.checkLogin(username, password);
                RegistrationDTO result = dao.checkLogin(username, password);
                HttpSession session = request.getSession();
                session.setAttribute("USER", result);
                //4. process
                if (result != null) {
//                    url = SEARCH_PAGE;
                    url = siteMaps.getProperty(
                            MyApplicationConstants.FirstTimeRequestServlet.SEARCH_PAGE);
                }//end user has existed
            }//end cookies has existed
        } catch (SQLException ex) {
//            ex.printStackTrace();
            log("FirstTimeRequestServlet _ SQL _ " + ex.getMessage());
        } catch (NamingException ex) {
//            ex.printStackTrace();
            log("FirstTimeRequestServlet _ Naming _ " + ex.getMessage());
        } finally {
//            RequestDispatcher rd = request.getRequestDispatcher(url);
//            rd.forward(request, response);
            response.sendRedirect(url);
            //cái nào cũng được vì trình duyệt hỗ trợ hàm lưu cookie nên send Redirect 
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
