<%@tag description="2nd level template for shop frontend" pageEncoding="UTF-8"
       body-content="scriptless"%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true"
             required="true"%>
<%@attribute name="extraHeadContent" fragment="true" required="false"%>
<%@attribute name="extraBottomContent" fragment="true" required="false"%>
<%@attribute name="extraNavigationContent" fragment="true" required="false"%>
<%@include file="/WEB-INF/jsp/base.jspf" %>
<template:main htmlTitle="${htmlTitle}" bodyTitle="${bodyTitle}">
    <jsp:attribute name="headContent">
        <!-- Theme styles START -->
        <link href="assets/style/myStyle.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style.css" rel="stylesheet">
        <link href="assets/frontend/pages/css/style-shop.css" rel="stylesheet" type="text/css">
        <link href="assets/frontend/pages/css/style-layer-slider.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/style-responsive.css" rel="stylesheet">
        <link href="assets/frontend/layout/css/themes/red.css" rel="stylesheet" id="style-color">
        <link href="assets/frontend/layout/css/custom.css" rel="stylesheet">
        <!-- Theme styles END -->        
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>
    <jsp:attribute name="bottomContent">
        <!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
        <script src="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.min.js" type="text/javascript"></script><!-- slider for products -->
        <script src="assets/global/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script><!-- Quantity -->

        <!-- BEGIN LayerSlider -->
        <script src="assets/global/plugins/slider-layer-slider/js/greensock.js" type="text/javascript"></script><!-- External libraries: GreenSock -->
        <script src="assets/global/plugins/slider-layer-slider/js/layerslider.transitions.js" type="text/javascript"></script><!-- LayerSlider script files -->
        <script src="assets/global/plugins/slider-layer-slider/js/layerslider.kreaturamedia.jquery.js" type="text/javascript"></script><!-- LayerSlider script files -->
        <script src="assets/frontend/pages/scripts/layerslider-init.js" type="text/javascript"></script>
        <!-- END LayerSlider -->

        <script src="assets/frontend/layout/scripts/layout.js" type="text/javascript"></script>
        <script type="text/javascript">
            jQuery(document).ready(function () {
                Layout.init();
                Layout.initOWL();
                LayersliderInit.initLayerSlider();
                Layout.initTouchspin();
            });
        </script>
        <!-- END PAGE LEVEL JAVASCRIPTS -->

        <jsp:invoke fragment="extraBottomContent" />
    </jsp:attribute>
    <jsp:attribute name="navigationContent">
        <li><a href="shop-account.html">My Account</a></li>
        <li><a href="shop-wishlist.html">My Wishlist</a></li>
        <li><a href="shop-checkout.html">Checkout</a></li>
        <li><a href="page-login.html">Log In</a></li>
        <jsp:invoke fragment="extraNavigationContent" />
    </jsp:attribute>
    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</template:main>