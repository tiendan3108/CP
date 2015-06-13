<template:shopbasic htmlTitle="Consignment Search" bodyTitle="Consignment Search">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-5">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown active open">
                        <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix active">
                                <a href="./consignment?advand-search"><i class="fa fa-angle-right"></i> Tìm kiếm</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="./consignment?accepted"><i class="fa fa-angle-right"></i> Yêu cầu đã duyệt</a>
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a><i class="fa fa-angle-right"></i>Quản lý hàng kí gửi</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="LoadManageProductPageServlet"><i class="fa fa-angle-right"></i>Hàng kí gửi</a>
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item clearfix dropdown">
                        <a><i class="fa fa-angle-right"></i>Thống kê</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Bán hàng</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="#"><i class="fa fa-angle-right"></i>Thanh toán</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR -->
        <div class="col-md-9">
            <h4>Tìm Kiếm</h4>
            <form class="form-horizontal" role="form">
                <div class="form-body">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Mã Sản Phẩm</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên Sản Phẩm</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ngày Gửi</label>
                        <div class="col-md-9">                                    
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control input-sm" readonly>
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Giá</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Ngày Giao</label>
                        <div class="col-md-9">                                    
                            <div class="input-group date date-picker" data-date-format="dd/mm/yyyy">
                                <input type="text" class="form-control input-sm" readonly>
                                <span class="input-group-btn">
                                    <button class="btn btn-sm default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Tên Khách Hàng</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Địa Chỉ</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Số Điện Thoại</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Email</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>


                </div>
                <div class="form-action">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="submit" class="btn btn-primary">Tìm</button>
                            <button type="reset" class="btn btn-info">Nhập Lại</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:shopbasic>