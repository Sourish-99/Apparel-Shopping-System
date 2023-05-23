<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Login</title>
        <!-- Importing all ui libs -->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet" />
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script src="js/simpleCart.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <script src="js/jquery.easing.min.js"></script>
    </head>
    <body>
        <div class="ban-top">
            <div class="container">
                <div class="top_nav_left">
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed"
                                        data-toggle="collapse"
                                        data-target="#bs-example-navbar-collapse-1"
                                        aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="collapse navbar-collapse menu--shylock" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav menu__list">
                                    <li class="menu__item"><a class="menu__link" href="index.jsp">Home</a></li>
                                    <li class="menu__item"><a class="menu__link" href="products.jsp">Products</a></li>
                                        <%
                                            if ((String) session.getAttribute("name") != null) {
                                        %>
                                    <li class="menu__item"><a class="menu__link" href="my-orders.jsp">My Orders</a></li>
                                    <li class="menu__item"><a class="menu__link" href="logout.jsp">Logout</a></li>
                                        <%
                                        } else {
                                        %>
                                    <li class="active menu__item menu__item--current"><a class="menu__link" href="user-login.jsp">User Login</a></li>
                                    <li class="menu__item"><a class="menu__link" href="user-register.jsp">User Register</a></li>
                                    <li class="menu__item"><a class="menu__link" href="admin-login.jsp">Admin Login</a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="top_nav_right">
                    <div class="cart box_1">
                        <a href="checkout.jsp"> 
                            <%
                                //Getting all cart details of the customer
                                ResultSet resultCount = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                                resultCount.next();
                                int count = resultCount.getInt(1);
                            %>
                            <h3>
                                <div class="total">
                                    <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
                                    [
                                    <%=count%>
                                    ] Cart
                                </div>
                            </h3>
                        </a>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <br>
        <% boolean forgPass = false; %>

        <div class="modal-dialog" role="document">
            <div class="modal-content modal-info">
                <div class="modal-header">
                    <button type="reset" form="logform" class="close" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body modal-spa">
                    <div class="login-grids">
                        <div class="login">
                            <div class="login-right">
                                <h3>Sign in with your account</h3>
                                <%
                                    String credential1 = (String) session.getAttribute("password-success");
                                    if (credential1 != null) {
                                        session.removeAttribute("password-success");
                                %>
                                <div class='alert alert-success' id='success' style="width: 680px;"><%=credential1%></div>
                                <%
                                    }
                                    String credential2 = (String) session.getAttribute("cred-login");
                                    if (credential2 != null) {
                                        session.removeAttribute("cred-login");
                                        forgPass = true;
                                %>
                                <div class="alert alert-danger" id="danger" style="width: 680px;"><%=credential2%></div>
                                <%
                                    }
                                %>
                                <form id="logform" action="UserLogin" method="post">
                                    <div>
                                        <h4>Email :</h4>
                                        <input type="text" placeholder="User email" style="width: 680px;" required="" name="email">
                                    </div>
                                    <div>
                                        <h4>Password :</h4>
                                        <input type="password" placeholder="User password" style="width: 680px;" required="" name="password">
                                    </div>
                                    <%
                                        if (forgPass) {
                                    %>
                                    <div style="width: 680px;">
                                        <p style="margin: 0 0 15px 0; text-align:right;"><a href="forgot-password.jsp">Trouble Logging in?</a></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <div>
                                        <input type="submit" value="SIGN IN" style="width: 680px;">
                                    </div>
                                </form>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <p>
                            <a href="user-register.jsp">New to Rags And Tags? Create an account</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>