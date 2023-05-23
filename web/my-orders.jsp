<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>My Orders</title>
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
        <script src="jquery-3.2.1.min.js"></script>
        <script src='../../../../../../ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
        <script src="../../../../../../m.servedby-buysellads.com/monetization.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            //Checking whether customer in session or not
            if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
        %>
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
                                    <li class="active menu__item menu__item--current"><a class="menu__link" href="my-orders.jsp">My Orders</a></li>
                                    <li class="menu__item"><a class="menu__link" href="logout.jsp">Logout</a></li>
                                        <%
                                        } else {
                                        %>
                                    <li class="menu__item"><a class="menu__link" href="user-login.jsp">User Login</a></li>
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

        <div class="page-head"></div>

        <div class="checkout">
            <div class="container">
                <h3>My Orders</h3> 
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>SR.No</th>
                                <th>Order No</th>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>MRP</th>
                                <th>Selling Price</th>
                                <th>Total Price</th>
                                <th>Order Date and Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <%
                            int index = 0;
                            //Getting all products
                            ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("select * from tblorders where customer_name='" + session.getAttribute("name") + "' ");
                            while (totalProduct.next()) {
                                index++;
                        %>
                        <tr class="rem1">
                            <td class="invert"><%=index%></td>
                            <td class="invert"><%=totalProduct.getInt(18)%></td>
                            <td class="invert"><img src=uploads/<%=totalProduct.getString(9)%> style="width: 100px; height: auto; display: block; margin-left: auto; margin-right: auto;"><br><center><b><%=totalProduct.getString(10)%></b></center></td>
                        <td class="invert"><%=totalProduct.getString(11)%></td>
                        <td class="invert"><del><%=totalProduct.getString(12)%></del></td>
                        <td class="invert"><%=totalProduct.getString(13)%></td>
                        <td class="invert"><%=totalProduct.getString(14)%></td>
                        <td class="invert"><%=totalProduct.getString(16)%></td>
                        <%
                            //If order is delivered
                            if (totalProduct.getString(15).equals("Deliver")) {
                        %>
                        <td><span class="label label-success"><strong>Delivered</strong></span></td>
                        <%
                        } else {
                        %>
                        <td><span class="label label-danger"><strong>Pending</strong></span></td>
                        <%
                            }
                        %>
                        </tr>
                        <%
                            }
                        %>
                        <script>
                            $('.value-plus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) + 1;
                                divUpd.text(newVal);
                            });

                            $('.value-minus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) - 1;
                                if (newVal >= 1)
                                    divUpd.text(newVal);
                            });
                        </script>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
        <%
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>