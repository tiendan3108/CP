<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta charset="utf-8"/>
        <title>Quản lý sản phẩm</title>
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
        <!-- END THEME STYLES -->
        <link href="assets/frontend/pages/css/style-manage-product.css" rel="stylesheet" type="text/css"/>
        <!-- END THEME STYLES -->
    </head>
    <body class="page-header-fixed page-quick-sidebar-over-content ">
        <!-- BEGIN SET PARAMETER -->
        <c:if test="${empty sessionScope.ACCOUNT}">
            <c:redirect url="./login.jsp"/>
        </c:if>
        <c:if test="${sessionScope.ACCOUNT.role != 'storeOwner'}">
            <c:redirect url="./login.jsp"/>
        </c:if>
        <c:set var="account" value="${sessionScope.ACCOUNT}"></c:set>
            <input type="hidden" class="currentTab" name="currentTab" value="">
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
                            <a href="ConsignmentRequestReceive">
                                <i class="icon-tag"></i>
                                <span class="title">Quản lý yêu cầu</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="LoadProductPage">
                                <i class="icon-handbag"></i>
                                <span class="title">Quản lý sản phẩm</span>
                            </a>
                        </li>
                        <li class="start">
                            <a href="LoadSalesPage">
                                <i class="icon-basket"></i>
                                <span class="title">Quản lý bán hàng</span>
                            </a>
                        </li>
                    </ul>
                    <!-- END SIDEBAR MENU -->
                </div>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="row" style="background-color: #01579b; height: 40px" >
                        <div class="col-lg-8 col-md-8" style="font-weight: bold; color: white; font-size: 150%; margin-top: 5px">
                            <i class="icon-handbag icon-lg"></i> Quản lý sản phẩm
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN ALL TAB-->
                            <div class="row">
                                <div class="col-md-9 col-sm-9 col-md-offset-3 col-sm-offset-3">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4  control-label">Trạng thái:</label>
                                            <div class="col-md-5 col-sm-5">
                                                <select class="form-control" id="consignmentOption">
                                                    <option value="all" selected="selected">Tất cả</option>
                                                    <option value="Chờ duyệt">Chờ duyệt lên web</option>
                                                    <option value="Trên web">Đang trên web</option>
                                                    <option value="Hủy kí gửi">Đăng kí hủy kí gửi</option>
                                                    <option value="Chờ nhận hàng">Chờ nhận hàng</option>
                                                    <option value="Hết hạn">Đã hết hạn kí gửi</option>
                                                    <option value="Hoàn tất">Hoàn tất</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" id="productTable" style="display:none">
                                <thead>
                                    <tr class="heading">
                                        <th>STT</th>
                                        <th>Tên khách hàng</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Trạng thái</th>
                                        <th style="width: 110px">Chi Tiết</th>
                                        <th style="display: none"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${requestScope.result}" varStatus="counter">
                                        <tr class="odd gradeX">
                                            <td class="center" style="font-weight: bold">${counter.count}</td>
                                            <td>${item.name}</td>
                                            <td>${item.product.name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.consignmentStatusID == 5 && item.product.productStatusID == 2}">
                                                        <font style="color: #7fcc7f; font-weight: bold">Chờ duyệt</font>
                                                    </c:when>
                                                    <c:when test="${item.consignmentStatusID == 5 && item.product.productStatusID == 3}">
                                                        <font style="color: #2175d9; font-weight: bold">Trên web</font>
                                                    </c:when>
                                                    <c:when test="${item.consignmentStatusID == 5 && item.product.productStatusID == 6}">
                                                        <font style="color: #ffd700; font-weight: bold">Hủy kí gửi</font>
                                                    </c:when>
                                                    <c:when test="${item.consignmentStatusID == 6 && item.product.productStatusID == 2}">
                                                        <font style="color: #ee0930; font-weight: bold">Hết hạn</font>
                                                    </c:when>
                                                    <c:when test="${item.consignmentStatusID == 7 && item.product.productStatusID == 8}">
                                                        <font style="color: #ff9900; font-weight: bold">Chờ nhận hàng</font>
                                                    </c:when>
                                                    <c:when test="${(item.consignmentStatusID == 4 && item.product.productStatusID == 7) || 
                                                                    (item.consignmentStatusID == 4 && item.product.productStatusID == 1) || (item.consignmentStatusID == 7 && item.product.productStatusID == 1 && item.reviewProductDate !='')}">
                                                            <font style="color: #006633; font-weight: bold">Hoàn tất</font>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${(item.consignmentStatusID == 4 && item.product.productStatusID == 7) || 
                                                                    (item.consignmentStatusID == 4 && item.product.productStatusID == 1) || (item.consignmentStatusID == 7 && item.product.productStatusID == 1 && item.reviewProductDate !='')}">
                                                            <button style="margin-right: 0px;width: 100%" class="btn yellow btn-detail-modal" data-toggle="modal" data-id="${item.consigmentID}"><i class="fa fa-history"></i></button>
                                                            </c:when>
                                                            <c:otherwise>
                                                            <button style="width: 60px;margin-right: 0px; color: black" class="btn btn-info btn-open-modal" data-toggle="modal" data-id="${item.consigmentID}"><i class="fa fa-eye"></i></button>
                                                            <button style="margin-right: 0px;" class="btn yellow btn-detail-modal" data-toggle="modal" data-id="${item.consigmentID}"><i class="fa fa-history"></i></button>
                                                            </c:otherwise>
                                                    </c:choose>
                                            </td>
                                            <td style="display: none">${item.consigmentID}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- END ALL TAB-->
                        </div>
                    </div>
                </div>
            </div>
            <!-- BEGIN ALL MODALS -->
            <div id="modal">
                <!-- CANCEL MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="cancelModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4 ">
                                <h3 class="modal-title" style="font-weight: bold">Thông tin hủy kí gửi - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>        
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin người kí gửi</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Họ tên</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="d_cancel_address">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Địa chỉ</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_address"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="d_cancel_email">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_email"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin hàng kí gửi</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Mã hàng kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_consignmentID"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày nhận hàng</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_consignedDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày hủy kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="cancel_canceledDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="row">
                                    <div style="float: right; margin-right: 25px">
                                        <form action="CancelProduct" method="POST">
                                            <input type="hidden" name="txtConsignmentID" id="cancel_ID" value="">
                                            <input type="hidden" class="currentTab" name="currentTab" value="">
                                            <button id="btnDecline" class="btn red" name="btnAction" type="submit" value="notCancel" style="display: none">Không đồng ý hủy</button>
                                            <button id="btnRefuse" class="btn red" name="btnAction" type="submit" value="refuse" style="display: none">Từ chối nhận hàng</button>
                                            <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                        </form>
                                    </div>
                                    <div style="float: right; margin: 0px 5px;">
                                        <button id="btnAgree" class="btn blue agreeCancelProductModal" style="display: none">Đồng ý hủy</button>
                                        <button id="btnReturn" class="btn blue receiveProductModal" data-toggle="modal" style="display: none">Trả hàng</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- CANCEL MODAL END-->
                <div class="modal fade bs-example-modal-sm" id="agreeCancelProductModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content" style="width: 500px">
                            <form action="CancelProduct" method="POST" onsubmit="ret
                                    urn
                                    validateCancelPrice4();">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Hủy kí gửi</h3>
                                </div>
                                <div class="modal-body">
                                    <h4>Bạn có chắc chắn muốn hủy kí gửi sản phẩm này ?</h4>
                                    <h4>Tiền phạt (Ngàn đồng):  <font color="red">*</font><input id="agreeCancelFee" name="txtCancelFee"></h4>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" value="" name="txtConsignmentID" id="agreeCancel_consignmentID2">
                                    <button class="btn blue" name="btnAction" type="submit" value="cancel">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- AVAILABLE MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="availableModal" aria-hidden="true">
                    <form action="PublishProduct" method="POST" enctype="multipart/form-data" onsubmit="return getSeasonAvai();">
                        <input type="hidden" value="available" name="btnAction">
                        <input type="hidden" id="avai_ProductID" value="" name="txtProductID">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #89C4F4 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin sản phẩm - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>        
                                </div>
                                <div class="modal-body">
                                    <div class="tab-content">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="txtProductName" class="col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <textarea cols="2" id="avai_ProductName" type="text" class="form-control" maxlength="100" name="txtProductName"></textarea>
                                                            <p class="help-block" id="er_avai_ProductName" style="color: red">  </p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txtSerial" class="col-sm-4 control-label" style="font-weight: bold">Số seri </label>
                                                        <div class="col-sm-8">
                                                            <input id="avai_SerialNumber" type="text" class="form-control" maxlength="20" name="txtSerialNumber"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Độ mới <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group">
                                                                <input id="avai_NewRatio" type="text" class="form-control" name="txtNewRatio">
                                                                <p class="help-block" id="er_avai_NewRatio" style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Loại sản phẩm <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <c:set var="parentCat" value="${requestScope.parentCat}"/>
                                                            <c:set var="allCat" value="${requestScope.allCat}"/>
                                                            <select class="form-control" id="avai_Category" name="txtCategory"style="width: 120px">
                                                                <c:forEach var="parent" items="${parentCat}">
                                                                    <optgroup label="${parent.categoryName}">
                                                                        <c:forEach var="item" items="${allCat}">
                                                                            <c:if test="${item.parentId == parent.categoryId}">
                                                                                <option id="${item.categoryId}" value="${item.categoryId}">${item.categoryName}</option>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </optgroup>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Hãng <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <input id="avai_Brand" type="text" class="form-control" maxlength="26" name="txtBrand"/>
                                                            <p class="help-block" id="er_avai_Brand"style="color: red">  </p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-4 control-label" style="font-weight: bold">Mùa </label>
                                                        <div class="col-sm-8">
                                                            <c:forEach var="item" items="${requestScope.season}">
                                                                <div class="col-sm-3 seasonDiv">
                                                                    <label>
                                                                        <input style="width: 8%" id="chkSeason${item.seasonID}"type="checkbox" name="chkSeason" value="${item.seasonID}"/>${item.seasonName}
                                                                    </label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Tự động gửi giá</label>
                                                        <div class="col-sm-8 radio-list">
                                                            <label class="radio-inline">
                                                                <input type="radio" name="rdSendPrice_1" id="rdIsSpecial1" value="isSpecial"> Có </label>
                                                            <label class="radio-inline">
                                                                <input type="radio" name="rdSendPrice_1" id="rdNotSpecial1" value="notSpecial" checked> Không </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-4 col-sm-4" style="font-weight: bold">Ảnh sản phẩm <font color="red">*</font></label>
                                                        <div class="col-md-8 col-sm-8" align="center">
                                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                <div class="thumbnail">
                                                                    <img src="" id="avai_Image" style="max-height: 200px"/>
                                                                </div>
                                                                <br/>
                                                                <div >
                                                                    <span class="btn btn-info btn-file">
                                                                        <span class="fileinput-new btn " >
                                                                            CHỌN ẢNH </span>
                                                                        <span class="fileinput-exists btn">
                                                                            CHỌN ẢNH </span>
                                                                        <input type="file" accept="image/*" name="avai_txtImage" onchange="readURL1(this);" style="max-width: "/>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-4 control-label" style="font-weight: bold">Mô tả </label>
                                                        <div class="col-sm-8">
                                                            <textarea id="avai_Description" class="form-control" maxlength="225" rows="6" placeholder="" name="txtDescription"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn blue" type="submit">Duyệt</button>
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" name="txtSeasonList" id="avai_seasonID">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- AVAILABLE MODAL END-->
                <!-- EXPIRED MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="expiredModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4 ">
                                <h3 class="modal-title" style="font-weight: bold">Thông tin sản phẩm - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>        
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin người kí gửi</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Họ tên</label>
                                                <div class="col-md-8 col-sm-8" id="expired_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Địa chỉ</label>
                                                <div class="col-md-8 col-sm-8" id="expired_address"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-8 col-sm-8" id="expired_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Email</label>
                                                <div class="col-md-8 col-sm-8" id="expired_email"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-horizontal">
                                            <h4 align="center"><span><b><u>Thông tin hàng kí gửi</u></b></span></h4>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-8 col-sm-8" id="expired_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Mã hàng kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="expired_consignmentID"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Ngày kí gửi</label>
                                                <div class="col-md-8 col-sm-8" id="expired_consignedDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-8 col-sm-8" id="expired_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 col-sm-4 control-label" style="font-weight: bold">Số ngày quá hạn</label>
                                                <div class="col-md-8 col-sm-8" id="expired_days"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <form>
                                    <input class="btn blue confirmExtendModal" type="button" data-togle="modal" value="Gia hạn">
                                    <input class="btn red confirmReceiveModal" type="button" data-togle="modal" value="Nhận hàng">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- EXPIRED MODAL END-->
                <!-- CONFIRM EXTEND MODAL BEGIN-->
                <div class="modal fade bs-example-modal-md" id="confirmExtendModal" aria-hidden="true">
                    <div class="modal-dialog modal-md">
                        <form action="ExtendProduct" method="POST" onsubmit="return checkNegotiatedPrice()">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thời hạn kí gửi</h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-10 col-sm-10 col-md-offset-1 col-sm-offset-1 form-horizontal">
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Số ngày quá hạn</label>
                                                <div class="col-md-7 col-sm-7" id="expired_period"  style="padding-top: 8px; font-size: 120%; color: red"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Tiền lưu kho <br>(Ngàn đồng) <font color="red">*</font></label>
                                                <div class="col-md-7 col-sm-7">
                                                    <input class="form-control" type="text" name="txtExpiredFee" id="expired_fees_1" value="" style="width: 130px">
                                                    <p class="help-block" id="er_expired_expiredFee"style="color: red">  </p>
                                                </div>
                                            </div>
                                            <div class="form-group" id="amazon_div">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Giá tham khảo trên Amazon (Ngàn đồng) </label>
                                                <div class="col-md-7 col-sm-7" id="amazonPrice" style="padding-top: 8px; font-size: 120%;">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Giá thỏa thuận mới (Ngàn đồng) <font color="red">*</font></label>
                                                <div class="col-md-7 col-sm-7">
                                                    <input class="form-control" id="new_negotiatedPrice"type="text" name="txtNegotiatedPrice" value="" style="width: 130px">
                                                    <p class="help-block" id="er_expired_NegotiatedPrice"style="color: red">  </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <h4>Đơn hàng sẽ được gia hạn thêm 30 ngày kể từ ngày hôm nay.</h4> 
                                                <h4>Bạn có chắc chắn muốn gia hạn đơn hàng này?</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" name="txtConsignmentID" id="expired_extendConsignmentID" value="">
                                    <button class="btn blue" name="btnAction" type="submit" value="extend">Gia hạn</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- CONFIRM EXTEND MODAL END-->
                <!-- CONFIRM RECEIVE MODAL BEGIN-->
                <div class="modal fade bs-example-modal-sm" id="confirmReceiveModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <form action="ExtendProduct" method="POST" onsubmit="return validationPrice();">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin tiền phạt</h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-10 col-md-10 col-sm-offset-1 col-md-offset-1" align="center">
                                            <label  class="control-label">Tiền phạt (Ngàn đồng) <font color="red">*</font></label>
                                            <input class="form-control" type="text" id="expired_fee" value="" name="txtExpiredFee">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" align="center">
                                    <input type="hidden" name="txtConsignmentID" id="expired_receiveConsignmentID" value="">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <button class="btn blue" name="btnAction" type="submit" value="receive">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- CONFIRM RECEIVE MODAL END-->
                <!-- CANCEL PRODUCT ONWEB MODAL BEGIN-->
                <div class="modal fade bs-example-modal-lg" id="onWebModal" aria-hidden="true">
                    <form action="PublishProduct" method="POST" enctype="multipart/form-data" onsubmit="return getSeasonOnWeb();">
                        <input type="hidden" value="onWeb" name="btnAction">
                        <input type="hidden" id="onWeb_ProductID" value="" name="txtProductID">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #89C4F4 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin sản phẩm - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>        
                                </div>
                                <div class="modal-body">
                                    <div class="tab-content">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="txtProductName" class="col-sm-4 control-label" style="font-weight: bold">Tên sản phẩm <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <textarea cols="2" id="onWeb_ProductName" type="text" class="form-control" maxlength="50" name="txtProductName"></textarea>
                                                            <p class="help-block" id="er_OnWeb_ProductName"style="color: red">  </p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="txtSerial" class="col-sm-4 control-label" style="font-weight: bold">Số seri </label>
                                                        <div class="col-sm-8">
                                                            <input id="onWeb_SerialNumber" type="text" class="form-control" name="txtSerialNumber"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Độ mới <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group">
                                                                <input id="onWeb_NewRatio" type="text" class="form-control" name="txtNewRatio" >
                                                                <p class="help-block" id="er_onWeb_NewRatio"style="color: red">  </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Loại sản phẩm <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <c:set var="parentCat" value="${requestScope.parentCat}"/>
                                                            <c:set var="allCat" value="${requestScope.allCat}"/>
                                                            <select class="form-control" id="onWeb_Category" name="txtCategory"style="width: 120px">
                                                                <c:forEach var="parent" items="${parentCat}">
                                                                    <optgroup label="${parent.categoryName}">
                                                                        <c:forEach var="item" items="${allCat}">
                                                                            <c:if test="${item.parentId == parent.categoryId}">
                                                                                <option id="onWeb_${item.categoryId}" value="${item.categoryId}">${item.categoryName}</option>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </optgroup>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Hãng <font color="red">*</font></label>
                                                        <div class="col-sm-8">
                                                            <input id="onWeb_Brand" type="text" class="form-control" maxlength="26" name="txtBrand"/>
                                                            <p class="help-block" id="er_OnWeb_Brand"style="color: red">  </p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-4 control-label" style="font-weight: bold">Mùa</label>
                                                        <div class="col-sm-8">
                                                            <c:forEach var="item" items="${requestScope.season}">
                                                                <div class="col-sm-3 seasonDiv">
                                                                    <label>
                                                                        <input style="width: 8%" id="onWeb_chkSeason${item.seasonID}" type="checkbox" name="chkSeason" value="${item.seasonID}"/>${item.seasonName}
                                                                    </label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-sm-4" style="font-weight: bold">Tự động gửi giá</label>
                                                        <div class="col-sm-8 radio-list">
                                                            <label class="radio-inline">
                                                                <input type="radio" name="rdSendPrice_2" id="sendPriceTrue_2" value="isSpecial"> Có </label>
                                                            <label class="radio-inline">
                                                                <input type="radio" name="rdSendPrice_2" id="sendPriceFalse_2" value="notSpecial"> Không </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-4 col-sm-4" style="font-weight: bold">Ảnh sản phẩm <font color="red">*</font></label>
                                                        <div class="col-md-8 col-sm-8" align="center">
                                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                <div class="thumbnail">
                                                                    <img src="" id="onWeb_Image" style="max-height: 200px"/>
                                                                </div>
                                                                <div >
                                                                    <span class="btn btn-info btn-file">
                                                                        <span class="fileinput-new btn " >
                                                                            CHỌN ẢNH </span>
                                                                        <span class="fileinput-exists btn">
                                                                            CHỌN ẢNH </span>
                                                                        <input type="file" accept="image/*" name="onweb_txtImage" onchange="readURL2(this);" style="max-width: "/>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-4 control-label" style="font-weight: bold">Mô tả </label>
                                                        <div class="col-sm-8">
                                                            <textarea id="onWeb_Description" class="form-control" maxlength="225" rows="6" placeholder="" name="txtDescription"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input class="btn green confirmOrderedModal" type="button" data-togle="modal" value="Bán hàng">
                                    <input class="btn red confirmOnWebModal" type="button" data-togle="modal" value="Hủy kí gửi">
                                    <button class="btn blue" type="submit">Cập nhật</button>
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" name="txtSeasonList" id="onWeb_seasonID">
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- CANCEL PRODUCT ONWEB MODAL END-->
                <!-- CONFIRM CANCEL PRODUCT ONWEB MODAL BEGIN-->
                <div class="modal fade bs-example-modal-sm" id="confirmOnWebModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content" style="width: 500px">
                            <form action="CancelProductOnWeb" method="POST" onsubmit="return validateCancelPrice2();">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Hủy kí gửi</h3>
                                </div>
                                <div class="modal-body">
                                    <h4>Bạn có chắc chắn muốn hủy kí gửi sản phẩm với mã kí gửi <label style="font-weight: bold" id="confirmCancel_ConsignmentID1"></label>?</h4>
                                    <h4>Tiền phạt (Ngàn đồng):  <font color="red">*</font><input id="confirmCancel_Fee" name="txtCancelFee"></h4>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" value="" name="txtConsignmentID" id="confirmCancel_ConsignmentID2">
                                    <button class="btn blue" type="submit" name="btnAction" value="receive">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- CONFIRM CANCEL PRODUCT ONWEB MODAL END-->
                <!-- RETURN PRODUCT MODAL BEGIN-->
                <div class="modal fade bs-example-modal-sm" id="receiveProductModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content" style="width: 500px">
                            <form action="CancelProductOnWeb" method="POST" onsubmit="ret
                                    urn
                                    validateCancelPrice1();">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Trả hàng kí gửi</h3>
                                </div>
                                <div class="modal-body">
                                    <h4>Bạn có chắc chắn muốn trả sản phẩm với mã kí gửi <label id="returnProduct_ConsignmentID"></label>?</h4>
                                    <h4>Tiền phạt (Ngàn đồng):  <font color="red">*</font><input id="returnProduct_Fee" name="txtCancelFee"></h4>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" value="canceled" name="txtcurrentTab">
                                    <input type="hidden" class="currentTab" name="currentTab" value="">
                                    <input type="hidden" value="" name="txtConsignmentID" id="returnProduct_ConsignmentID1">
                                    <button class="btn blue" type="submit" name="btnAction" value="receive">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="modalAlert" data-backdrop="static" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #dfba49">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="modal-title" style="font-weight: bold">Thông báo</h3>
                            </div>
                            <div class="modal-body" align="center">
                                <h3 id="alert_content"></h3>
                            </div>
                            <div class="modal-footer">

                                <button id="btnOK" data-dismiss="modal" class="btn btn-warning">OK</button> 
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
                <!-- RETURN PRODUCT MODAL END-->
                <div class="modal fade bs-example-modal-lg" id="detailModal" aria-hidden="true">
                    <div class="modal-dialog modal-scrollable modal-lg">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #89C4F4 ">
                                <h3 class="modal-title" style="font-weight: bold">Thông tin chi tiết  - <font class="consignmentIDHeader" style="color: #080b3b"></font></h3>
                            </div>
                            <div class="modal-body">
                                <div class="row">


                                    <!-- BEGIN LEFT TAB -->
                                    <div class="col-lg-6 col-md-6">

                                        <!--table-striped-->
                                        <div class="form-horizontal">
                                            <!--                                        <table class="table table-hover" style="border: none">-->
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Tên sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_productName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Loại sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_productCategory"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Hãng</label>
                                                <div class="col-md-7 col-sm-7" id="c_productBrand"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Giá thỏa thuận</label>
                                                <div class="col-md-7 col-sm-7" id="c_negotiatedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>

                                        </div>

                                    </div>
                                    <!-- END LEFT TAB -->
                                    <!-- BEGIN RIGHT TAB -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Người ký gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_fullName"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Điện thoại</label>
                                                <div class="col-md-7 col-sm-7" id="c_phone"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Cách thức thanh toán</label>
                                                <div class="col-md-7 col-sm-7" id="c_paypalAccount"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Thời gian kí gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_period"  style="padding-top: 8px; font-size: 110%"></div>
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
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày tạo ký gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_createdDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_refuseProductDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày từ chối sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_refuseProductDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_reviewProductDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày nhận sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_reviewProductDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_returnDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày trả tiền khách hàng</label>
                                                <div class="col-md-7 col-sm-7" id="c_returnDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_cancelDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày hủy kí gửi</label>
                                                <div class="col-md-7 col-sm-7" id="c_cancelDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--END LEFT TAB -->

                                    <!--BEGIN RIGHT TAB -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_reviewRequestDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày duyệt yêu cầu</label>
                                                <div class="col-md-7 col-sm-7" id="c_reviewRequestDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_refuseRequestDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày từ chối yêu cầu</label>
                                                <div class="col-md-7 col-sm-7" id="c_refuseRequestDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_publishOnWebDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày đăng lên web</label>
                                                <div class="col-md-7 col-sm-7" id="c_publishOnWebDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_receivedDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày hoàn trả sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_receivedDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                            <div class="form-group" id="div_c_sellDate">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Ngày bán sản phẩm</label>
                                                <div class="col-md-7 col-sm-7" id="c_sellDate"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--END RIGHT TAB -->
                                </div>
                                <div class="row" id="bonus_infor">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_returnedPrice">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Tiền trả khách hàng</label>
                                                <div class="col-md-7 col-sm-7" id="c_returnedPrice"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                        <div class="form-horizontal">
                                            <div class="form-group" id="div_c_reason">
                                                <label class="col-md-5 col-sm-5 control-label" style="font-weight: bold">Lý do từ chối</label>
                                                <div class="col-md-7 col-sm-7" id="c_reason"  style="padding-top: 8px; font-size: 110%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-horizontal">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade bs-example-modal-sm" id="confirmOrderedModal" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <form action="OrderProduct" method="POST">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #dfba49 ">
                                    <h3 class="modal-title" style="font-weight: bold">Thông tin giá bán</h3>        
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-10 col-sm-offset-1" align="center">
                                            <label class="control-label">Giá bán (ngàn đồng): <font color="red">*</font></label>
                                            <input class="form-control" id="sellingPrice" type="text" name="txtSellingPrice" value ="">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input name="btnAction" type="hidden" value="onweb">
                                    <input type="hidden" id="onweb_consignmentID" name="txtProductID">
                                    <button class="btn blue" name="btnAction" type="submit" value="order" onclick="return validateSellingPrice();">Đồng ý</button>
                                    <input class="btn btn-default" type="button" data-dismiss="modal" value="Đóng" style="width: 80px">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- END ALL MODALS -->
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
        <!-- END FOOTER -->
        <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
        <!-- BEGIN CORE PLUGINS -->
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
        <link rel="stylesheet" href="js/jquery-ui.css">
        <script src="js/jquery-2.1.1.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <!--END PAGE CSS -->
        <script>
                                        jQuery(document).ready(function () {
                                            // initiate layout and plugins
                                            // initiate layout and plugins
                                            Metronic.init(); // init metronic core components
                                            Layout.init(); // init current layout
                                            QuickSidebar.init(); // init quick sidebar
                                            Demo.init(); // init demo features
                                            TableManaged.init();
                                        });
        </script>
        <script>
            function validateSellingPrice() {
                var fee = $('#sellingPrice').val().trim();
                if (fee.length == 0) {
                    alert('Vui lòng nhập giá bán.');
                    return false;
                }
                if (isNaN(fee) || fee < 0) {
                    alert('Tiền bán phải là số dương');
                    return false;
                } else {
                    return true;
                }
            }
            // main script
            $(document).on("click", ".btn-detail-modal", function () {
                var consignmentID = $(this).data('id');
                $("font.consignmentIDHeader").each(function () {
                    $(this).text(consignmentID);
                })
                loadCompletedProduct(consignmentID);
            })
            $(document).on("click", ".btn-open-modal", function () {
                var consignmentID = $(this).data('id');
                $("font.consignmentIDHeader").each(function () {
                    $(this).text(consignmentID);
                })
                $.get('CheckPopupModal', {consignmentID: consignmentID}, function (response) {
                    if (response == 1) {
                        loadAvailableProduct(consignmentID);
                    }
                    if (response == 2) {
                        loadOnWebProduct(consignmentID);
                    }
                    if (response == 3) {
                        loadCancelProduct(consignmentID);
                    }
                    if (response == 4) {
                        loadExpiredProduct(consignmentID);
                    }
                    if (response == -1) {
                        loadCompletedProduct(consignmentID);
                    }
                });
            });
            function loadCancelProduct(consignmentID) {
                $.get('LoadCancelProduct', {consignmentID: consignmentID}, function (response) {
                    var product = response.product;
                    $("#cancel_fullName").text(response.name);
                    $("#cancel_address").text(response.address);
                    $("#cancel_phone").text(response.phone);
                    $("#cancel_email").text(response.email);
                    $("#cancel_productName").text(product.name);
                    $("#cancel_consignmentID").text(product.consignmentID);
                    $("#cancel_negotiatedPrice").text(product.negotiatedPrice.toMoney(0) + " (ngàn đồng)");
                    $("#cancel_consignedDate").text(product.receivedDate);
                    $("#cancel_canceledDate").text(product.cancelDate);
                    $("#cancel_ID").val(product.consignmentID);
                    $("#returnProduct_ConsignmentID").text(product.consignmentID);
                    $("#returnProduct_ConsignmentID1").val(product.consignmentID);
                    $("#agreeCancel_consignmentID1").val(product.consignmentID);
                    $("#agreeCancel_consignmentID2").val(product.consignmentID);
                    $("#returnProduct_Fee").val(response.maxPrice);
                    if (typeof response.email === "undefined" || response.email == '') {
                        $("#d_cancel_email").hide();
                    } else {
                        $("#d_cancel_email").show();
                    }
                    if (typeof response.address === "undefined" || response.address == '') {
                        $("#d_cancel_address").hide();
                    } else {
                        $("#d_cancel_address").show();
                    }
                    if (response.product.productStatusID < 8) {
                        $("#btnAgree").removeAttr("style");
                        $("#btnDecline").removeAttr("style");
                        $("#btnReturn").removeAttr("style");
                        $("#btnReturn").attr("style", "display:none;");
                        $("#btnRefuse").removeAttr("style");
                        $("#btnRefuse").attr("style", "display:none;");
                    } else {
                        $("#btnReturn").removeAttr("style");
                        $("#btnRefuse").removeAttr("style");
                        $("#btnDecline").removeAttr("style");
                        $("#btnDecline").attr("style", "display:none;");
                        $("#btnAgree").removeAttr("style");
                        $("#btnAgree").attr("style", "display:none;");
                    }
                });
                $('#cancelModal').modal('show');
            }
            function loadAvailableProduct(consignmentID) {
                setSeason();
                $("#er_avai_ProductName").html('');
                $("#er_avai_NewRatio").html('');
                $("#er_avai_Brand").html('');
                $.get('LoadAvailableProduct', {consignmentID: consignmentID}, function (response) {
                    $("#avai_ProductName").val(response.name);
                    $("#avai_ProductID").val(response.productID);
                    $("#avai_SerialNumber").val(response.serialNumber);
                    $("#avai_NewRatio").val(response.newStatus);
                    $("#avai_Brand").val(response.brand);
                    $("#avai_Description").val(response.description);
                    $("#avai_Image").attr("src", response.image);
                    //$("#avai_Image2").attr("src", response.image);
                    var option = "option#" + response.categoryID;
                    $(option).attr("selected", "selected");
                    if (response.isSpecial < 1) {
                        $('#rdIsSpecial1').parent('span').addClass('checked');
                        $('#rdNotSpecial1').parent('span').removeClass('checked');
                    } else {
                        $('#rdIsSpecial1').parent('span').removeClass('checked');
                        $('#rdNotSpecial1').parent('span').addClass('checked');
                    }
                });
                $('#availableModal').modal('show');
            }
            function readURL1(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#avai_Image').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function readURL2(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#onWeb_Image').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function loadExpiredProduct(consignmentID) {
                $("#expired_fullName").text('');
                $("#expired_address").text('');
                $("#expired_phone").text('');
                $("#expired_email").text('');
                $("#expired_productName").text('');
                $("#expired_consignmentID").text(consignmentID);
                $("#expired_extendConsignmentID").val(consignmentID);
                $("#expired_receiveConsignmentID").val(consignmentID);
                $("#expired_consignedDate").text('');
                $("#expired_negotiatedPrice").text('');
                $("#expired_days").text('');
                $("#amazonPrice").text('');
                $.get('LoadExpiredProduct', {consignmentID: consignmentID}, function (response) {
                    $("#expired_fullName").text(response.name);
                    $("#expired_address").text(response.address);
                    $("#expired_phone").text(response.phone);
                    $("#expired_email").text(response.email);
                    $("#expired_productName").text(response.product.name);
                    $("#expired_consignmentID").text(consignmentID);
                    $("#expired_extendConsignmentID").val(consignmentID);
                    $("#expired_receiveConsignmentID").val(consignmentID);
                    $("#expired_consignedDate").text(response.reviewProductDate);
                    $("#expired_negotiatedPrice").text(response.negotiatedPrice.toMoney(0) + " (ngàn đồng)");
                    $("#expired_days").text(response.expiredDays + ' ngày');
                    $("#amazonPrice").text(response.minPrice.toMoney(0) + ' ~ ' + response.maxPrice.toMoney(0) + " (ngàn đồng)");
                    if (response.minPrice == 0) {
                        $("#amazon_div").hide();
                    } else {
                        $("#amazon_div").show();
                    }
                    $("#expired_fee").val(response.expiredFee + response.remainExtendFee);
                });
                $('#expiredModal').modal('show');
            }
            $(document).on("click", ".confirmExtendModal", function () {
                $("#expired_period").text($("#expired_days").text());
                $("#expired_fees").text($("#expired_fee").val());
                $("#expired_fees_1").val($("#expired_fee").val());
                $('#confirmExtendModal').modal('show');
            });
            $(document).on("click", ".confirmReceiveModal", function () {
                $('#confirmReceiveModal').modal('show');
            });
            function loadOnWebProduct(consignmentID) {
                $("#er_OnWeb_ProductName").html('');
                $("#er_OnWeb_Brand").html('');
                $.get('LoadOnWebProduct', {consignmentID: consignmentID}, function (response) {
                    var season = [];
                    season = response.product.seasonList;
                    for (var i = 1, max = 4; i <= max; i++) {
                        $("input#onWeb_chkSeason" + i).parent("span").removeClass("checked");
                    }
                    for (var i = 0; i < season.length; i++) {
                        $("input#onWeb_chkSeason" + season[i]).parent("span").addClass("checked");
                    }
                    var price = (response.negotiatedPrice * 15 / 100).toFixed(0);
                    $("#confirmCancel_ConsignmentID2").val(consignmentID);
                    $("#confirmCancel_Fee").val(price);
                });
                $.get('LoadAvailableProduct', {consignmentID: consignmentID}, function (response) {
                    $("#onweb_consignmentID").val(response.productID);
                    $("#onWeb_ProductName").val(response.name);
                    $("#onWeb_ProductID").val(response.productID);
                    $("#onWeb_SerialNumber").val(response.serialNumber);
                    $("#onWeb_NewRatio").val(response.newStatus);
                    $("#onWeb_Brand").val(response.brand);
                    $("#onWeb_Description").val(response.description);
                    $("#onWeb_Image").attr("src", response.image);
                    $("#confirmCancel_ConsignmentID1").text(consignmentID);
                    var option = "option#onWeb_" + response.categoryID;
                    $(option).attr("selected", "selected");
                    if (response.isSpecial < 1) {
                        $('#sendPriceTrue_2').parent('span').addClass('checked');
                        $('#sendPriceFalse_2').parent('span').removeClass('checked')
                    } else {
                        $('#sendPriceTrue_2').parent('span').removeClass('checked')
                        $('#sendPriceFalse_2').parent('span').addClass('checked')
                    }
                });
                $('#onWebModal').modal('show');
            }
            function loadCompletedProduct(consignmentID) {
                $.get('LoadDetailConsignment', {consignmentID: consignmentID}, function (respone) {
                    $('#c_fullName').text(respone.name);
                    $('#c_productName').text(respone.product.name);
                    $('#c_productCategory').text(respone.product.categoryName);
                    $('#c_productBrand').text(respone.product.brand);
                    $('#c_phone').text(respone.phone);

                    if (typeof respone.paypalAccount === "undefined" || respone.paypalAccount === '') {
                        $('#c_paypalAccount').text("Tiền mặt");
                    } else {
                        $('#c_paypalAccount').text("Chuyển tiền qua tài khoản " + respone.paypalAccount);
                    }
                    $('#c_period').text(respone.period + ' ngày');
                    $('#c_negotiatedPrice').text(respone.negotiatedPrice.toMoney(0) + ' (ngàn đồng)');
                    $('#c_createdDate').text(respone.createdDate);

                    $('#div_c_refuseProductDate').hide();
                    $('#div_c_reviewProductDate').hide();
                    $('#div_c_returnDate').hide();
                    $('#div_c_cancelDate').hide();
                    $('#div_c_receivedDate').hide();
                    $('#div_c_reviewRequestDate').hide();
                    $('#div_c_refuseRequestDate').hide();
                    $('#div_c_publishOnWebDate').hide();
                    $('#div_c_sellDate').hide();
                    $('#div_c_reason').hide();
                    $('#div_c_returnedPrice').hide();

                    $('#c_reviewRequestDate').text(respone.reviewRequestDate);
                    $('#c_reviewProductDate').text(respone.reviewProductDate);
                    $('#c_refuseRequestDate').text(respone.reviewRequestDate);
                    $('#c_refuseProductDate').text(respone.reviewProductDate);
                    $('#c_returnDate').text(respone.returnDate);
                    $('#c_cancelDate').text(respone.cancelDate);
                    $('#c_receivedDate').text(respone.agreeCancelDate);
                    $('#c_sellDate').text(respone.product.sellDate);
                    $('#c_publishOnWebDate').text(respone.raiseWebDate);
                    $('#c_reason').text(respone.reason);
                    $('#c_returnedPrice').text(respone.returnPrice.toMoney(0) + ' (ngàn đồng)');

                    if (respone.consignmentStatusID == 2 && respone.reviewProductDate != "") {//refuse request
                        $('#div_c_refuseProductDate').show();
                        $('#div_c_reviewRequestDate').show();
                    }
                    if (respone.consignmentStatusID == 2 && respone.reviewProductDate == "") {//retuse product
                        $('#div_c_refuseRequestDate').show();
                    }
                    if (respone.consignmentStatusID == 3) {
                        $('#div_c_reviewRequestDate').show();
                        if (respone.product.productStatusID == 6) {
                            if (respone.reviewProductDate != "") {
                                $('#div_c_reviewProductDate').show();
                            }
                            $('#div_c_cancelDate').show();
                        }
                    }
                    if (respone.consignmentStatusID == 5) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        if (respone.product.productStatusID == 3 || respone.product.productStatusID == 4) {
                            $('#div_c_publishOnWebDate').show();
                        }
                        if (respone.product.productStatusID == 5) {
                            $('#div_c_publishOnWebDate').show();
                            $('#div_c_sellDate').show();
                        }
                        if (respone.product.productStatusID == 6) {
                            $('#div_c_cancelDate').show();
                            $('#div_c_publishOnWebDate').show();
                        }
                    }
                    if (respone.consignmentStatusID == 6) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        $('#div_c_publishOnWebDate').show();
                    }
                    if (respone.consignmentStatusID == 7) {
                        $('#div_c_reviewRequestDate').show();
                        if (respone.reviewProductDate != "") {
                            $('#div_c_reviewProductDate').show();
                        }
                        if (respone.raiseWebDate != "") {
                            $('#div_c_publishOnWebDate').show();
                        }
                        $('#div_c_cancelDate').show();
                    }
                    if (respone.consignmentStatusID == 4) {
                        $('#div_c_reviewRequestDate').show();
                        $('#div_c_reviewProductDate').show();
                        $('#div_c_publishOnWebDate').show();
                        if (respone.product.productStatusID == 7) {
                            $('#div_c_sellDate').show();
                            $('#div_c_returnedPrice').show();
                            $('#div_c_returnDate').show();
                        }
                    }
                    if (respone.reason != "") {
                        $('#div_c_reason').show();
                    }
                });
                $('#detailModal').modal('show');
            }
            $(document).on("click", ".confirmOnWebModal", function () {
                $('#confirmOnWebModal').modal('show');
            });
            $(document).on("click", ".receiveProductModal", function () {
                $('#receiveProductModal').modal('show');
            });
            $(document).on("click", ".agreeCancelProductModal", function () {
                $('#agreeCancelProductModal').modal('show');
            });
            $(document).on("click", ".confirmOrderedModal", function () {
                $('#confirmOrderedModal').modal('show');
            });
            function validationPrice() {
                var fee = $('#expired_fee').val().trim();
                if (fee.length == 0) {
                    alert('Vui lòng nhập tiền phạt.');
                    return false;
                }
                if (isNaN(fee) || fee < 0) {
                    alert('Tiền phạt phải là số dương');
                    return false;
                } else {
                    return true;
                }
            }
            function validateCancelPrice1() {
                var fee = $('#returnProduct_Fee').val().trim();
                if (fee.length == 0) {
                    alert('Vui lòng nhập tiền phạt.');
                    return false;
                }
                if (fee < 0) {
                    alert('Tiền phạt phải là số dương');
                    return false;
                }
                if (isNaN(fee)) {
                    alert('Tiền phạt phải là số');
                    return false;
                } else {
                    return true;
                }
            }
            function validateCancelPrice2() {
                var fee = $('#confirmCancel_Fee').val().trim();
                if (fee.length == 0) {
                    alert('Vui lòng nhập tiền phạt.');
                    return false;
                }
                if (fee < 0) {
                    alert('Tiền phạt phải là số dương');
                    return false;
                }
                if (isNaN(fee)) {
                    alert('Tiền phạt phải là số');
                    return false;
                } else {
                    return true;
                }
            }
            function validateCancelPrice4() {
                var fee = $('#agreeCancelFee').val().trim();
                if (fee.length == 0) {
                    alert('Vui lòng nhập tiền phạt.');
                    return false;
                }
                if (fee < 0) {
                    alert('Tiền phạt phải là số dương');
                    return false;
                }
                if (isNaN(fee)) {
                    alert('Tiền phạt phải là số');
                    return false;
                } else {
                    return true;
                }
            }
            //set season by time
            function setSeason() {
                $("div.seasonDiv").siblings().children('label').children('div').children('span').removeClass("checked");
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd;
                }
                if (mm < 10) {
                    mm = '0' + mm;
                }
                today = dd + '-' + mm + '-' + yyyy;
                if (compareDate(today, '23-01-' + yyyy) >= 0 && compareDate(today, '21-06-' + yyyy) < 0) {
                    $("input#chkSeason1").parent("span").addClass("checked");
                } else if (compareDate(today, '21-06-' + yyyy) >= 0 && compareDate(today, '23-09-' + yyyy) < 0) {
                    $("input#chkSeason2").parent("span").addClass("checked");
                } else if (compareDate(today, '23-09-' + yyyy) >= 0 && compareDate(today, '22-12-' + yyyy) < 0) {
                    $("input#chkSeason3").parent("span").addClass("checked");
                } else
                {
                    $("input#chkSeason4").parent("span").addClass("checked");
                }
            }
            function compareDate(source, target) {//return -1 if source < target, 1 if source > target and 0 if source = target
                if (source.substring(6, 10) > target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(3, 5) > target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                if (source.substring(0, 2) > target.substring(0, 2) && source.substring(3, 5) >= target.substring(3, 5) && source.substring(6, 10) >= target.substring(6, 10)) {
                    return 1;
                }
                if (source.localeCompare(target) == 0) {
                    return 0;
                }
                return -1;
            }
            //get season checkbox
            function getSeasonAvai() {
                var flag = true;
                var name = $("#avai_ProductName").val();
                var brand = $("#avai_Brand").val();
                var newRatio = $("#avai_NewRatio").val();
                if (isNaN(newRatio) || newRatio <= 0 || newRatio > 100 || newRatio.indexOf(".") != -1 || newRatio.indexOf(",") != -1) {
                    flag = false;
                    $("#er_avai_NewRatio").html('Vui lòng nhập độ mới của sản phẩm');
                } else {
                    $("#er_avai_NewRatio").html('');
                }
                if (name.length < 5) {
                    flag = false;
                    $("#er_avai_ProductName").html('Vui lòng nhập tên sản phẩm');
                } else {
                    $("#er_avai_ProductName").html('');
                }
                if (brand.length <= 0) {
                    flag = false;
                    $("#er_avai_Brand").html('Vui lòng nhập hãng sản phẩm');
                } else {
                    $("#er_avai_Brand").html('');
                }
                var selected = [];
                $('#chkSeason1').parent('span').parent('div').parent('label').parent('div').siblings().addBack().each(function () {
                    if ($(this).children('label').children('div').children('span').hasClass('checked')) {
                        selected += ($(this).children('label').children('div').children('span').children('input').attr('value'));
                    }
                });
                $('#avai_seasonID').val(selected);
                return flag;
            }
            function getSeasonOnWeb() {
                var flag = true;
                var name = $("#onWeb_ProductName").val();
                var brand = $("#onWeb_Brand").val();
                var newRatio = $("#onWeb_NewRatio").val();
                if (isNaN(newRatio) || newRatio <= 0 || newRatio > 100 || newRatio.indexOf(".") != -1 || newRatio.indexOf(",") != -1) {
                    flag = false;
                    $("#er_onWeb_NewRatio").html('Vui lòng nhập độ mới của sản phẩm');
                } else {
                    $("#er_onWeb_NewRatio").html('');
                }
                if (name.length < 5) {
                    flag = false;
                    $("#er_OnWeb_ProductName").html('Vui lòng nhập tên sản phẩm');
                } else {
                    $("#er_OnWeb_ProductName").html('');
                }
                if (brand.length <= 0) {
                    flag = false;
                    $("#er_OnWeb_Brand").html('Vui lòng nhập tên sản phẩm');
                } else {
                    $("#er_OnWeb_Brand").html('');
                }
                var selected = [];
                $('#onWeb_chkSeason1').parent('span').parent('div').parent('label').parent('div').siblings().addBack().each(function () {
                    if ($(this).children('label').children('div').children('span').hasClass('checked')) {
                        selected += ($(this).children('label').children('div').children('span').children('input').attr('value'));
                    }
                });
                $('#onWeb_seasonID').val(selected);
                return flag;
            }
            $("#consignmentOption").change(function () {
                var currentTab = $("#consignmentOption").val();
                $(".currentTab").each(function () {
                    $(this).val(currentTab)
                })
                if (currentTab == "all") {
                    window.location.hash = "all";
                } else if (currentTab == "Chờ duyệt") {
                    window.location.hash = "available";
                } else if (currentTab == "Trên web") {
                    window.location.hash = "onweb";
                } else if (currentTab == "Hủy kí gửi") {
                    window.location.hash = "requestCancel";
                } else if (currentTab == "Chờ nhận hàng") {
                    window.location.hash = "agreeCancel";
                } else if (currentTab == "Hết hạn") {
                    window.location.hash = "expired";
                } else if (currentTab == "Hoàn tất") {
                    window.location.hash = "completed";
                }
                var table = $("#productTable").DataTable();
                table.draw();
            })
            $(document).ready(function () {
                var currentTab = window.location.hash.substring(1);
                if (currentTab.length > 0) {
                    if (currentTab == "all") {
                        $('#consignmentOption').val("all").change();
                    } else if (currentTab == "available") {
                        $('#consignmentOption').val("Chờ duyệt").change();
                    } else if (currentTab == "onweb") {
                        $('#consignmentOption').val("Trên web").change();
                    } else if (currentTab == "requestCancel") {
                        $('#consignmentOption').val("Hủy kí gửi").change();
                    } else if (currentTab == "agreeCancel") {
                        $('#consignmentOption').val("Chờ nhận hàng").change();
                    } else if (currentTab == "expired") {
                        $('#consignmentOption').val("Hết hạn").change();
                    } else if (currentTab == "completed") {
                        $('#consignmentOption').val("Hoàn tất").change();
                    }
                    var table = $('#productTable').DataTable();
                    table.draw();
                } else {
                    $('#consignmentOption').val("all").change();
                    var table = $('#productTable').DataTable();
                    table.draw();
                }
                $('#productTable').show();
            });
            $.fn.dataTable.ext.search.push(
                    function (settings, data, dataIndex) {
                        var option = $('#consignmentOption').val();
                        var status = data[3];
                        if (option.localeCompare('all') == 0) {
                            return true;
                        } else if (option.localeCompare(status) == 0) {
                            return true
                        } else {
                            return false;
                        }
                    });
            Number.prototype.toMoney = function (decimals, decimal_sep, thousands_sep)
            {
                var n = this,
                        c = isNaN(decimals) ? 2 : Math.abs(decimals),
                        d = decimal_sep || '.',
                        t = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                        sign = (n < 0) ? '-' : '',
                        i = parseInt(n = Math.abs(n).toFixed(c)) + '',
                        j = ((j = i.length) > 3) ? j % 3 : 0;
                return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '');
            }
            function checkNegotiatedPrice() {
                var flag = true;
                var negotiatedPrice = $("#new_negotiatedPrice").val();
                var expiredFee = $("#expired_fees_1").val();
                if (isNaN(negotiatedPrice) || negotiatedPrice <= 0) {
                    flag = false;
                    $("#er_expired_NegotiatedPrice").html('Vui lòng nhập giá thỏa thuận mới');
                } else {
                    $("#er_expired_NegotiatedPrice").html('');
                }
                if (isNaN(expiredFee) || expiredFee <= 0) {
                    flag = false;
                    $("#er_expired_expiredFee").html('Vui lòng nhập tiền lưu kho');
                } else {
                    $("#er_expired_expiredFee").html('');
                }
                return flag;
            }
        </script>
    </body>
    <!-- END BODY -->
</html>