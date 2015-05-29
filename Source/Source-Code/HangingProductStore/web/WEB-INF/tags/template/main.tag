<%@tag description="top level template"
       pageEncoding="UTF-8" body-content="scriptless"%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="headContent" fragment="true" required="false"%>
<%@attribute name="bottomContent" fragment="true" required="false"%>
<%@attribute name="navigationContent" fragment="true" required="true"%>
<%@include file="/WEB-INF/jsp/base.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>HPS :: <c:out value="${fn:trim(htmlTitle)}" /></title>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Global styles START -->          
        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet">
        <!-- Global styles END --> 

        <!-- Page level plugin styles START -->
        <link href="assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
        <link href="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.css" rel="stylesheet">
        <link href="assets/global/plugins/slider-layer-slider/css/layerslider.css" rel="stylesheet">
        <!-- Page level plugin styles END -->

        <jsp:invoke fragment="headContent" />
    </head>
    <!-- Head END -->

    <!-- Body BEGIN -->
    <body class="ecommerce">

        <!-- Header BEGIN -->
        <div id= "nav">
            <div class="container">
                <div class="row" >
                    <a href="home.html" class="brand-logo">Hanging Product Store</a>
                    <!-- Top-bar-menu BEGIN -->
                    <ul class="list-unstyled list-inline pull-right navhover">
                        <jsp:invoke fragment="navigationContent" />
                    </ul>
                    <!-- Top-bar-menu END -->
                </div>
            </div>        
        </div>
        <!-- Header END -->

        <!-- Main BEGIN -->
        <div class="main">
            <div id="wrapper">
                <h2><c:out value="${fn:trim(bodyTitle)}" /></h2>
                <jsp:doBody />
            </div>
        </div>
        <!-- Main END -->

        <!-- Footer BEGIN -->
        <footer class="page-footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-lg-6 col-sm-12">
                        <p class="footerTitle">Hanging Product Store</p>
                        <p class="grey-text text-lighten-4">Information here.</p>
                    </div>
                    <div class="col-lg-4 col-lg-offset-2 col-md-4 col-md-offset-2 col-sm-12">
                        <p class="footerTitle">Follow Us</p>
                        <ul>
                            <li><a style="color: white;text-decoration: none" href="#!">Facebook</a></li>
                            <li><a style="color: white;text-decoration: none" href="#!">Twitter</a></li>
                            <li><a style="color: white;text-decoration: none" href="#!">Google+</a></li>
                            <li><a style="color: white;text-decoration: none" href="#!">Instagram</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="footer-copyright">
                <div class="container">
                    © 2015 Group8
                </div>
            </div>
        </footer>
        <!-- Footer END -->

        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->

        <jsp:invoke fragment="bottomContent" />
    </body>
    <!-- Body END -->
</html>