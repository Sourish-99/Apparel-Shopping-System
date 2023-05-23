<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <!-- Importing all ui libs -->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet" />
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/qc.slider.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="js/qcslider.jquery.js"></script>
        <script src="js/simpleCart.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <script src="js/jquery.easing.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function ($) {
                $("#slider").QCslider({duration: 7000});
            });
        </script>
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
                                    <li class="active menu__item menu__item--current"><a class="menu__link" href="index.jsp">Home</a></li>
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

        <section class="slide">
            <div class="slider-container">
                <ul class="slider-wrapper" id="slider">
                    <li class="slide-current"> <img src="images/ba1.jpg"/> </li>
                    <li class="slide-current"> <img src="images/ba2.jpg"/> </li>
                    <li class="slide-current"> <img src="images/ba3.jpg"/> </li>
                </ul>
                <div class="drt-control control-left" id="lft-control"><</div>
                <div class="drt-control control-right" id="rht-control">></div>
                <ul class="slider-controls" id="slider-controls"></ul>
                <div class="tempo-bar" id="barra"></div>
            </div>
        </section> 

        <div class="clearfix"></div>
        <div class="clearfix"></div>
        <br/>

        <div class="product-easy">
            <div class="container">
                <div class="container">
                    <h2 style="margin-bottom: 30px;">
                        <span><center>Our Products</center></span>
                    </h2>
                </div>
                <%
                    ResultSet retriveProduct = DatabaseConnection.getResultFromSqlQuery("select * from tblproduct");
                    while (retriveProduct.next()) {
                %>
                <form action="AddToCart" method="post">
                    <div class="single-pro">
                        <div class="col-md-3 product-men" style="padding-bottom: 15px; padding-top: 15px;">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <input type="hidden" name="productId" value="<%=retriveProduct.getInt("id")%>"> 
                                    <img src="uploads/<%=retriveProduct.getString("image_name")%>" alt="" class="pro-image-front"> 
                                    <img src="uploads/<%=retriveProduct.getString("image_name")%>" alt="" class="pro-image-back"> 
                                    <span class="product-new-top">New</span>
                                </div>
                                <div class="item-info-product ">
                                    <h4>
                                        <a href=""><%=retriveProduct.getString("name")%></a>
                                    </h4>
                                    <h5>
                                        Category: <%=retriveProduct.getString("product_category")%>
                                    </h5>
                                    <div class="info-product-price">
                                        <input type="hidden" name="price" value="<%=retriveProduct.getString("price")%>">
                                        <input type="hidden" name="mrp_price" value="<%=retriveProduct.getString("mrp_price")%>">
                                        <span class="item_price">Rs. <%=retriveProduct.getString("price")%></span>
                                        <del>Rs. <%=retriveProduct.getString("mrp_price")%></del>
                                    </div>
                                    <%
                                        String availstat = retriveProduct.getString("active");
                                        if (availstat.matches("Active")) {
                                    %>
                                    <input type="submit" value="Add to cart" class="btn btn-warning" onclick="return confirm('Do you want to add this item to cart?');">
                                    <%
                                    } else {
                                    %>
                                    <input type="submit" value="Out of Stock" class="btn btn-danger" disabled>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <%
                    }
                %>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>