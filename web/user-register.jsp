<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Register</title>
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
                                    <li class="menu__item"><a class="menu__link" href="user-login.jsp">User Login</a></li>
                                    <li class="active menu__item menu__item--current"><a class="menu__link" href="user-register.jsp">User Register</a></li>
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

        <div class="modal-dialog" role="document">
            <div class="modal-content modal-info">
                <div class="modal-header">
                    <button type="reset" form="regform" class="close" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body modal-spa">
                    <div class="login-grids">
                        <div class="login">
                            <div class="login-bottom">
                                <h3>Sign up for free</h3>
                                <%
                                    String exist = (String) session.getAttribute("exists-message");
                                    if (exist != null) {
                                        session.removeAttribute("exists-message");
                                %>
                                <div class='alert alert-warning' id='warning' style="width: 680px;"><%=exist%></div>
                                <%
                                    }
                                    String success = (String) session.getAttribute("success-message");
                                    if (success != null) {
                                        session.removeAttribute("success-message");
                                %>
                                <div class='alert alert-success' id='success' style="width: 680px;"><%=success%></div>
                                <%
                                    }
                                    String fail = (String) session.getAttribute("fail-message");
                                    if (fail != null) {
                                        session.removeAttribute("fail-message");
                                %>
                                <div class="alert alert-danger" id='danger' style="width: 680px;"><%=fail%></div>
                                <%
                                    }
                                %>
                                <form id="regform" action="AddUser" method="post">
                                    <div class="sign-up">
                                        <h4>Your Name :</h4>
                                        <input type="text" placeholder="Your Name" required="" style="width: 680px;" name="name">
                                    </div>
                                    <div>
                                        <h4>Email :</h4>
                                        <input type="text" placeholder="Your email" required="" style="width: 680px;" name="email">
                                    </div>
                                    <div>
                                        <h4>Password :</h4>
                                        <input type="password" placeholder="Password" required="" style="width: 680px;" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters">
                                    </div>
                                    <div>
                                        <h4>Phone :</h4>
                                        <input type="text" placeholder="Your phone" required="" style="width: 680px;" name="mobile" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                    </div>
                                    <div>
                                        <h4>Gender :</h4>
                                        <br> <select class="form-control" style="width: 680px;" name="gender">
                                            <option>Male</option>
                                            <option>Female</option>
                                        </select>
                                    </div>
                                    <br>
                                    <div>
                                        <h4>Address :</h4>
                                        <input type="text" placeholder="Your Address" required="" style="min-height: 100px; width: 680px;" name="address">
                                    </div>
                                    <div>
                                        <h4>Pin Code :</h4>
                                        <input type="text" placeholder="Pin" required="" style="width: 680px;" name="pincode">
                                    </div>
                                    <div>
                                        <input type="submit" value="REGISTER NOW" style="width: 680px;">
                                    </div>
                                </form>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <p>
                            <a href="user-login.jsp">Existing Customer? Log In</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>