<%-- 
    Document   : home
    Created on : May 16, 2015, 4:00:20 PM
    Author     : HoangNHSE61007
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/materialize.css" />
        <link rel="stylesheet" type="text/css" href="css/myStyle.css" />
        <link rel="stylesheet" type="text/css" href="font-awesome-4.3.0/css/font-awesome.min.css">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/materialize.js"></script>
    </head>
    <body>
        <!-- navigation bar -->
        <nav style="background-color: #01579b">
            <div class="nav-wrapper">
                <a href="home.jsp" class="brand-logo">Logo</a>
                <a href="home.jsp" data-activates="mobile-demo" class="button-collapse"><i class="mdi-navigation-menu"></i></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="#">Consign</a></li>                  
                    <li><a href="#">Help & Contact</a></li>
                    <li><a href="#">Sign in</a></li>
                    <li><a href="#">Register</a></li>
                </ul>
                <ul class="side-nav" id="mobile-demo">
                    <li><a href="#">Consign</a></li>                  
                    <li><a href="#">Help & Contact</a></li>
                    <li><a href="#">Sign in</a></li>
                    <li><a href="#">Register</a></li>
                </ul>
            </div>
        </nav>
        <!-- parallax banner -->
        <div class="parallax-container">
            <div class="parallax"><img src="images/banner.jpg"></div>
        </div>
        <!-- Search bar -->
        <div style="background-color: white;" class="row">
            <div  id="search">
                <div class="col s12 grid-example ">
                    <div class=" col s6 m4 l4 offset-l3 offset-m3">
                        <select id="category" onchange="validateSearch()">
                            <option value="" disabled selected>all</option>
                            <option value="Women">Women</option>
                            <option value="Men">Men</option>
                            <option value="Girls">Girls</option>
                            <option value="Boys">Boys</option>
                        </select>
                    </div>

                    <div style="padding-top: 5px; text-align: center; margin-top: 5px " class="col s6 m2 l2">
                        <button id="btnSearch" class="waves-effect waves-light btn btn-large btn-fullwidth btn-flat disabled" ><i class="mdi-action-search right"></i>Search</button>
                    </div>

                </div>
            </div>
        </div> 
        <div id="wrapper">
            <div class="row">
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6 l4">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="images/current.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Card Title <i class="mdi-navigation-more-vert right"></i></span>
                            <p><a class="waves-effect waves-light btn" href="#">Add To Cart</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Card Title <i class="mdi-navigation-close right"></i></span>
                            <p>Here is some more information about this product that is only revealed once clicked on.</p>
                        </div>
                    </div>
                </div>
                
               
            </div>
        </div>
        <!-- footer -->
        <footer style="background-color: #01579b" class="page-footer">
            <div id="container">
                <div class="row">
                    <div class="col l6 s12">
                        <h5 class="white-text">Hanging Product Store</h5>
                        <p class="grey-text text-lighten-4">Address!</p>
                    </div>
                    <div class="col l4 offset-l2 s12">
                        <h5 class="white-text">Follow Us</h5>
                        <ul>
                            <li><a class="grey-text text-lighten-3" href="#!">Facebook</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Twitter</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Google+</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Instagram</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="footer-copyright">
                <div class="container">
                    © 2015 Group 8
                    <a class="grey-text text-lighten-4 right" href="#!">Designed by Hoang Nguyen</a>
                </div>
            </div>
        </footer>
        <script>
            $(document).ready(function () {
                //nav bar
                $(".button-collapse").sideNav();
                //Date time picker
                $('.datepicker').pickadate({
                    selectMonths: false, // Creates a dropdown to control month
                    selectYears: 15 // Creates a dropdown of 15 years to control year
                });
                //dropdown selection
                $('select').material_select();
                //validate Search
                validateSearch();
                // parallax 
                $('.parallax').parallax();

            });
            function validateSearch() {
                var temp = false;
                if ($('#category').val() !== null) {
                    temp = true;
                }
                ;
                if (temp) {
                    $('#btnSearch').removeClass('btn-flat disabled');
                    $('#btnSearch').addClass('myButton');
                } else {
                    $('#btnSearch').addClass('btn-flat disabled');
                }
                ;
            }


        </script>
    </body>
</html>

