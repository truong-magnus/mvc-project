<%-- 
    Document   : search
    Created on : Oct 3, 2022, 8:01:00 AM
    Author     : Chau Nhat Truong
--%>

<%--<%@page import="truongcn.registration.RegistrationDTO"%>--%>
<%--<%@page import="java.util.List"%>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <font color="red">  

        <%--<%
            Cookie[] cookie = request.getCookies();
            if (cookie != null) {
                String username = "";
                Cookie lastCookie = cookie[cookie.length - 1];
                //String username = lastCookie.getName();
                String temp = lastCookie.getName();
                if (!username.equals("JSESSIONID")) {
                    username = temp;
                }
        %>
        
        <%
            String url = "DispatchController"
                    + "?btAction=Logout";
        %>
        
        Welcome, <%= username%> <a href="<%= url %>">Logout</a>

        <%
            }//end cookies has existed
        %>--%>  
        <%--<%
            String url = "DispatchController"
                    + "?btAction=Logout";
        %>--%>

        Welcome, ${sessionScope.USER.fullname}<br/>
        <a href="LogoutServlet">Logout</a>
        </font> 
        <h1>Search Page</h1>

        <%--<form action="DispatchController">
        Search Value <input type="text" name="txtSearchValue" 
        value="<%= request.getParameter("txtSearchValue")%>" /><br/>
        value="${param.txtSearchValue}"/><br/>
        <input type="submit" value="Search" name="btAction" />
        </form><br/>--%>

        <form action="searchLastnameController">
            Search Value <input type="text" name="txtSearchValue" 
                                value="${param.txtSearchValue}" /><br/>
            <input type="submit" value="Search" name="btAction" />
        </form><br/>

        <%--<%
            String searchValue = request.getParameter("txtSearchValue");
            if (searchValue != null) {
                List<RegistrationDTO> result
                        = (List<RegistrationDTO>) request.getAttribute("SEARCH_RESULT");
                                //get Attribute phải ép kiểu tường minh
                if (result != null) {
        %>--%>

        <c:set var="searchValue" value="${param.txtSearchValue}" />
        <c:if test="${not empty searchValue}">
            <c:set var="result" value="${requestScope.SEARCH_RESULT}"/>
            <c:if test="${not empty result}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Full name</th>
                            <th>Role</th>
                            <th>Delete</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%--<%
                    int count = 0;
                    for (RegistrationDTO dto : result) {
                        String urlWriting = "DispatchController"
                                + "?btAction=delete"
                                + "&pk=" + dto.getUsername()
                                + "&lastSearchValue=" + searchValue;
                        %>--%>

                        <c:forEach var="dto" items="${result}" varStatus="counter">
                        <form action="updateAccountController" method="POST">
                            <tr>
                                <td>
                                    ${counter.count}
                                    .</td>
                                <td>
                                    ${dto.username}
                                    <input type="hidden" name="txtUsername" 
                                           value="${dto.username}" />
                                </td>
                                <td>
                                    <%--${dto.password}--%>
                                    <input type="text" name="txtPassword" 
                                           value="${dto.password}" />
                                </td>
                                <td>
                                    ${dto.fullname}
                                </td>
                                <td>
                                    <input type="checkbox" name="chkAdmin" value="ON" 
                                           <c:if test="${dto.role}">
                                               checked="checked"
                                           </c:if>
                                           />
                                </td>
                                <td>
                                    <c:url var="urlRewriting" value="deleteAccountController">
                                        <c:param name="btAction" value="delete"/>
                                        <c:param name="pk" value="${dto.username}"/>
                                        <c:param name="lastSearchValue" value="${searchValue}"/>
                                    </c:url>
                                    <a href="${urlRewriting}">Delete</a>
                                </td>
                                <td>
                                    <input type="submit" value="Update" name="btAction" />
                                    <input type="hidden" name="lastSearchValue" 
                                           value="${searchValue}" />
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                </tbody>
            </table>
                        
            <c:set var="errorUpdate" value="${requestScope.UPDATE_ERROR}"/>
            <c:if test="${not empty errorUpdate.passwordLengthError}">
                <font color="red">
                <h2>${errorUpdate.passwordLengthError}</h2>
                </font>
            </c:if>
            
            <c:set var="errorDelete" value="${requestScope.DELETE_ERROR}"/>
            <c:if test="${not empty errorDelete.deleteCurrentAccount}">
                <font color="red">
                <h2>${errorDelete.deleteCurrentAccount}</h2>
                </font>
            </c:if>
        </c:if>

        <c:if test="${empty result}">
            <h2>No record is matched!!!!</h2>
        </c:if>
    </c:if>

    <%--<%
    } else {// no record is matched
    %>
    <h2>
    No record is matched!!!
    </h2>
    <%
    }
    }//search Value is not existed
    %>--%>

</body>
</html>
