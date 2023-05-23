<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<%

    //Check and clear cart
    ResultSet getCart = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
    getCart.next();
    int CartCount = getCart.getInt(1);

    if (CartCount > 0) {
        DatabaseConnection.insertUpdateFromSqlQuery("delete from tblcart where customer_id='" + session.getAttribute("id") + "'");
    }

    //Invalidating the session and sending response back to the customer index page
    session.invalidate();
    response.sendRedirect("index.jsp");
%>