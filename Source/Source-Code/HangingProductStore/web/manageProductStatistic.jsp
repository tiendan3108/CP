<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta charset="utf-8"/>
        <title>Quản lí yêu cầu ký gửi</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <meta content="" name="description"/>
        <meta content="" name="author"/>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME STYLES -->
        <link href="assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
        <link href="assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
        <link id="style_color" href="assets/admin/layout/css/themes/blue.css" rel="stylesheet" type="text/css"/>
        <link href="assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/select2/select2.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
        <!-- BEGIN SET PARAMETER -->
        <c:if test="${empty sessionScope.ACCOUNT}">
            <c:redirect url="./HomeServlet"/>
        </c:if>
        <c:if test="${sessionScope.ACCOUNT.role != 'storeOwner'}">
            <c:redirect url="./HomeServlet"/>
        </c:if>
        <input type="hidden" id="currentTab" value="${requestScope.currentTab}">
        <c:set var="account" value="${sessionScope.ACCOUNT}"></c:set>
            <!-- END SET PARAMETER -->
            <!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <!-- BEGIN HEADER INNER -->
                <div class="page-header-inner">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a style="text-decoration: none;color:white;font-size: 18px;line-height: 25px;margin-top: 6px" href="#">
                            Hanging Product Store
                        </a>
                    </div>

                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                    <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">${sessionScope.ACCOUNT.fullName}</span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="extra_profile.html">
                                        <i class="icon-user"></i> My Profile </a>
                                </li>
                            </ul>                           
                        </li>
                        <li class="dropdown dropdown-user">
                            <a href="LogoutServlet" class="dropdown-toggle">
                                <span style="color:white;font-size: 15px" class="username username-hide-on-mobile">Đăng xuất</span>
                            </a>                      
                        </li>
                    </ul>
                </div>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END HEADER INNER -->
        </div>
        <!-- END HEADER -->
        <div class="clearfix">
        </div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <div class="page-sidebar navbar-collapse collapse">
                    <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                        <li class="sidebar-toggler-wrapper" class="sidebar-toggler-wrapper">
                            <div class="sidebar-toggler">
                            </div>
                        </li>
                        <li class="start">
                            <a href="javascript:;">
                                <i class="icon-rocket"></i>
                                <span class="title">Quản lí yêu cầu</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li id="request">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=request">Chưa duyệt</a>
                                </li>
                                <li id="accepted">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=accepted">Đã duyệt</a>
                                </li>
                                <li id="refuse">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=refuse">Từ chối</a>
                                </li>
                                <li id="cancel">
                                    <a href="ConsignmentRequestReceive?btnAction=changeTab&tab=cancel">Đã hủy</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:;">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lí hàng kí gửi</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li id="available">
                                    <a href="ManageProduct?currentTab=available">Chờ duyệt</a>
                                </li>
                                <li id="onWeb">
                                    <a href="ManageProduct?currentTab=onWeb">Trên web</a>
                                </li>
                                <li id="ordered">
                                    <a href="ManageProduct?currentTab=ordered">Đã được đặt</a>
                                </li>
                                <li id="sold">
                                    <a href="ManageProduct?currentTab=sold">Đã bán</a>
                                </li>
                                <li id="canceled">
                                    <a href="ManageProduct?currentTab=canceled">Đăng kí hủy kí gửi</a>
                                </li>
                                <li id="expired">
                                    <a href="ManageProduct?currentTab=expired">Hết hạn kí gửi</a>
                                </li>
                            </ul>
                        </li>
                        <li class="last active open">
                            <a href="javascript:;">
                                <i class="icon-bar-chart"></i>
                                <span class="title">Thống kê</span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu open">
                                <li id="consignment">
                                    <a href="Statistics?currentTab=consignment">Yêu cầu kí gửi</a>
                                </li>
                                <li id="product">
                                    <a href="Statistics?currentTab=product">Sản phẩm ký gửi</a>
                                </li>
                            </ul>
                        </li>								
                    </ul>
                    <!-- END SIDEBAR MENU -->
                </div>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET HERE we Go-->
                            <div class="portlet box blue">
                                <div class="portlet-title">
                                    <input type="hidden" id="fromDate" value="">
                                    <input type="hidden" id="toDate" value="">
                                    <div class="caption" style="font-weight: bold">
                                        <i class="fa fa-globe"></i>Thống kê 
                                    </div>
                                </div>

                                <div class="portlet-body" id="consignment">
                                    <div class="row" >
                                        <div class="col-md-4 col-sm-4 input-daterange">
                                            Yêu cầu từ ngày &nbsp;&nbsp;
                                            <input type="text" id="daterangeConsignment">
                                        </div>
                                        <div class="col-md-8 col-sm-8">
                                            <select id="consignmentOption" style="float: right">
                                                <option value="all" selected="selected">Tất cả</option>
                                                <option value="Chờ duyệt yêu cầu">Chờ duyệt yêu cầu</option>
                                                <option value="Từ chối khi duyệt yêu cầu">Từ chối khi duyệt yêu cầu</option>
                                                <option value="Từ chối khi đến nhận hàng">Từ chối khi đến nhận hàng</option>
                                                <option value="Đồng ý nhận kí gửi">Đồng ý nhận kí gửi</option>
                                                <option value="Đã nhận hàng">Đã nhận hàng</option>
                                                <option value="Đang trên web">Đang trên web</option>
                                                <option value="Đã được đặt hàng">Đã được đặt hàng</option>
                                                <option value="Đã bán">Đã bán</option>
                                                <option value="Đã hết hạn">Đã hết hạn</option>
                                                <option value="Đã hủy ký gửi">Đã hủy ký gửi</option>
                                                <option value="Đăng ký hủy ký gửi">Đăng ký hủy ký gửi</option>
                                                <option value="Hoàn tất">Hoàn tất</option>
                                                <option value="Khác">Khác</option>
                                            </select>
                                            <label style="float: right">Trạng thái : </label>
                                        </div>
                                    </div>
                                    <br/>
                                    <table class="table table-striped table-hover" id="consignmentTable">
                                        <thead>
                                            <tr role="row" class="heading">
                                                <th>STT</th>
                                                <th>Mã kí gửi</th>
                                                <th>Tên khách hàng</th>
                                                <th id="actionDate">Ngày tạo kí gửi</th>
                                                <th>Trạng thái</th>
                                                <th>Chi tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.resultC}" varStatus="counter">
                                                <tr>
                                                    <td style="font-weight: bold">${counter.count}</td>
                                                    <td>${item.consigmentID}</td>
                                                    <td>${item.name}</td>
                                                    <td>${item.createdDate}</td>

                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.product.productStatusID == 6}">
                                                                <c:choose>
                                                                    <c:when test="${item.consignmentStatusID == 7}">Đã hủy ký gửi</c:when>
                                                                    <c:otherwise>Đăng ký hủy ký gửi</c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${item.consignmentStatusID == 1}">Chờ duyệt yêu cầu</c:when>
                                                                    <c:when test="${item.consignmentStatusID == 2}">
                                                                        <c:choose>
                                                                            <c:when test="${not empty item.reviewProductDate}">Từ chối khi đến nhận hàng</c:when>
                                                                            <c:when test="${not empty item.reviewRequestDate}">Từ chối khi duyệt yêu cầu</c:when>
                                                                        </c:choose>
                                                                    </c:when>

                                                                    <c:when test="${item.consignmentStatusID == 3 && not empty item.reviewRequestDate}">Đồng ý nhận ký gửi</c:when>

                                                                    <c:when test="${item.consignmentStatusID == 5}">
                                                                        <c:choose>
                                                                            <c:when test="${item.product.productStatusID == 2}">Đã nhận hàng</c:when>
                                                                            <c:when test="${item.product.productStatusID == 3}">Đang trên web</c:when>
                                                                            <c:when test="${item.product.productStatusID == 4}">Đã được đặt hàng</c:when>
                                                                            <c:when test="${item.product.productStatusID == 5}">Đã bán</c:when>
                                                                            <c:when test="${item.product.productStatusID == 7}">Hoàn tất</c:when>
                                                                        </c:choose>
                                                                    </c:when>
                                                                    <c:when test="${item.consignmentStatusID == 4}">Hoàn tất</c:when>
                                                                    <c:when test="${item.consignmentStatusID == 6}">Đã hết hạn</c:when>

                                                                    <c:otherwise>Khác</c:otherwise>
                                                                </c:choose>
                                                            </c:otherwise>

                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-info detailModal" style="width: 70px; height: 30px" data-toggle="modal" data-id="${item.consigmentID}">Xem</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="modal fade bs-example-modal-lg" id="detailModal" aria-hidden="true">
                        <div class="modal-dialog modal-scrollable modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin chi tiết</h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">


                                        <!-- BEGIN LEFT TAB -->
                                        <div class="col-lg-6 col-md-6">

                                            <!--table-striped-->
                                            <div class="form-horizontal">
                                                <!--                                        <table class="table table-hover" style="border: none">-->
                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                    <div class="col-md-8 col-sm-8" id="c_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>


                                            </div>

                                        </div>
                                        <!-- END LEFT TAB -->

                                        <!-- BEGIN RIGHT TAB -->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Người ký gửi</label>
                                                    <div class="col-md-8 col-sm-8" id="c_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại</label>
                                                    <div class="col-md-8 col-sm-8" id="c_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email:</label>
                                                    <div class="col-md-8 col-sm-8" id="c_email"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tài khoản Paypal</label>
                                                    <div class="col-md-8 col-sm-8" id="c_paypalAccount"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>


                                            </div>


                                        </div>
                                        <!-- END RIGHT TAB -->


                                    </div>
                                    <hr/>
                                    <div class="row">
                                        <!--BEGIN LEFT TAB -->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="form-horizontal">

                                                <div class="form-group" id="div_c_createdDate">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày ký gửi</label>
                                                    <div class="col-md-8 col-sm-8" id="c_createdDate"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>


                                            </div>
                                        </div>
                                        <!--END LEFT TAB -->
                                        
                                        <!--BEGIN RIGHT TAB -->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="form-horizontal">
                                                <div class="form-group" id="div_c_cancelDate">
                                                    <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày hủy</label>
                                                    <div class="col-md-8 col-sm-8" id="c_cancelDate"  style="padding-top: 8px; font-size: 110%"></div>
                                                </div>

                                            </div>

                                        </div>
                                        <!--END RIGHT TAB -->
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer">
            <div class="page-footer-inner">
                2015 &copy; Group 8 Capstone Project
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
        <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
        <script src="assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>

        <!-- END CORE PLUGINS -->
        <script src="assets/global/scripts/metronic.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
        <script src="assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
        <script src="assets/admin/pages/scripts/table-managed.js"></script>

        <!--BEGIN PAGE CSS -->
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>

        <script type="text/javascript" src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
        <!--END PAGE CSS -->
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/clockface/css/clockface.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datepicker/css/datepicker3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"/>
        <link rel="stylesheet" type="text/css" href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>

        <script type="text/javascript" src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/clockface/js/clockface.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/moment.min.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
        <script type="text/javascript" src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/admin/pages/scripts/components-form-tools.js"></script>
        <script src="assets/admin/pages/scripts/components-pickers.js"></script>
        <script>
            jQuery(document).ready(function () {
                // initiate layout and plugins
                // initiate layout and plugins
                Metronic.init(); // init metronic core components
                Layout.init(); // init current layout
                QuickSidebar.init(); // init quick sidebar
                Demo.init(); // init demo features
                TableManaged.init();
            })
        </script>
        <script>

            $(document).ready(function () {
                //script switch tab
                var currentTab = window.location.hash.substring(1);
                if (currentTab == "") {
                    currentTab = $('#currentTab').val();
                }
                $('div#' + currentTab).fadeIn(400).siblings().hide();
                $('div.portlet-title').show();
                $('li#' + currentTab).addClass('open').siblings().removeClass('open');
                $('html,body').scrollTop(0);
//                var table = $('#consignmentTable').DataTable();
//                table.draw();
            });


            $(document).ready(function () {
                $('#daterangeConsignment').daterangepicker({
                    format: "DD/MM/YYYY",
                    maxDate: moment(),
                    startDate: moment(),
                    endDate: moment(),
                    locale: {cancelLabel: 'Đóng', applyLabel: 'Lọc', fromLabel: 'Từ ngày', toLabel: 'Đến ngày'}
                });
            });
            $('#daterangeConsignment').on('apply.daterangepicker', function (ev, picker) {
                var table = $('#consignmentTable').DataTable();
                var startDate = $('#daterangeConsignment').data('daterangepicker').startDate.format('DD-MM-YYYY');
                var endDate = $('#daterangeConsignment').data('daterangepicker').endDate.format('DD-MM-YYYY');
                $('#fromDate').val(startDate);
                $('#toDate').val(endDate);
                table.draw();
            });
            $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var startDate = $('#fromDate').val();
                        var endDate = $('#toDate').val();
                        var option = $('#consignmentOption').val();
                        var date = data[3]; // use data for the 'Ngày' column
                        var status = data[4];
                        if (startDate.length == 0 || endDate.length == 0) {

                            if (option == "all") {
                                return true;
                            } else {
                                var i = option.localeCompare(status);
                                if (i == 0)
                                {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                        } else {
                            if (option == 'all' && compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0) {
                                return true;
                            } else {
                                var i = option.localeCompare(status);
                                if (i == 0 && compareDate(date, startDate) >= 0 && compareDate(date, endDate) <= 0)
                                {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                        }

                    }
            );

            $("#consignmentOption").change(function () {
                var table = $('#consignmentTable').DataTable();
//                var option = $('#consignmentOption').val();
////                var actionDateName = "";
//                switch (option) {
//                    case "Chờ duyệt yêu cầu":
////                        actionDateName = "Ngày tạo yêu cầu";
//                        break;
//                    case "Từ chối khi duyệt yêu cầu":
////                        actionDateName = "Ngày từ chối";
//                        break;
//                    case "Từ chối khi đến nhận hàng":
////                        actionDateName = "Ngày từ chối";
//                        break;
//                    case "Đồng ý nhận ký gửi":
////                        actionDateName = "Ngày duyệt yêu cầu";
//                        break;
//                    case "Đã nhận hàng":
////                        actionDateName = "Ngày nhận hàng";
//                        break;
//                    case "Hoàn tất":
////                        actionDateName = "Ngày hoàn tất";
//                        break;
//                }
                //$("#actionDate").text(actionDateName);
                table.draw();
            })



            //date picker product

            $(document).on("click", ".detailModal", function () {
                var consignmentID = $(this).data('id');
                $.get('LoadDetailConsignment', {consignmentID: consignmentID}, function (respone) {
                    $('#c_fullName').text(respone.name);
                    $('#c_productName').text(respone.product.name);
                    $('#c_image').attr("src", respone.product.image.replace(/\\/g, '/'));

                    $('#c_phone').text(respone.phone);
                    if (respone.email != null) {
                        $('#c_email').text(respone.email);
                    } else {
                        $('#c_email').text("Không có");
                    }

                    if (respone.paypalAccount != null) {
                        $('#c_paypalAccount').text(respone.paypalAccount);
                    } else {
                        $('#c_paypalAccount').text("Không có");
                    }


                    $('#c_createdDate').text(respone.createdDate);
                    //$('#consignmentID').text(respone.consigmentID);

                    //$('#reviewRequestDate').text(respone.createdDate);
                    //$('#refuseReviewRequestDate').text(respone.name);
                    //$('#reviewProductDate').text(respone.reviewProductDate);
                    //$('#refuseReviewProductDate').text(respone.name);
                    //$('#soldDate').text(respone.name);
                    //$('#returnDate').text(respone.name);
                });
                $('#detailModal').modal('show');
            });
            //date picker consignment

            function compareDate(source, target) {//return -1 if source < target, 1 if source > target and 0 if source = target
                source = source.substring(8);
                if (source.substring(6, 10) > target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(3, 5) > target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(0, 2) > target.substring(0, 2) && source.substring(3, 5) >= target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                if (source == "all") {
                    return 0;
                }
                else if (source.localeCompare(target) == "0") {
                    return 0;
                }
                return -1;
            }
        </script>
    </body>
    <!-- END BODY -->
</html>