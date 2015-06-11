<template:shopbasic htmlTitle="Consignment Search" bodyTitle="Consignment Search">
    <!-- BEGIN SIDEBAR & CONTENT -->
    <div class="row margin-bottom-40 ">
            <!-- BEGIN SIDEBAR -->
            <div class="sidebar col-md-3 col-sm-5">
                <ul class="list-group margin-bottom-25 sidebar-menu">
                    <li class="list-group-item clearfix dropdown active open">
                        <a><i class="fa fa-angle-right"></i>Quản lý yêu cầu kí gửi</a>
                        <ul class="dropdown-menu">
                            <li class="list-group-item clearfix active">
                                <a href="./consignment?advand-search"><i class="fa fa-angle-right"></i> Tìm kiếm nâng cao</a>
                            </li>
                            <li class="list-group-item clearfix">
                                <a href="./consignment?request"><i class="fa fa-angle-right"></i> Yêu cầu kí gửi</a>
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
                                <a href=""><i class="fa fa-angle-right"></i>Hàng kí gửi</a>
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
            <h4>Advance Search</h4>
            <form class="form-horizontal" role="form">
                <div class="form-body">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Product Serial No.</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Product Name</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Request Date</label>
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
                        <label class="col-md-3 control-label">Consign Price</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Transfer Date</label>
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
                        <label class="col-md-3 control-label">Customer Name</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Customer Address</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Customer Phone</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Customer Email</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control">
                        </div>
                    </div>


                </div>
                <div class="form-action">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <button type="reset" class="btn btn-link">Reset</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- END SIDEBAR & CONTENT -->
</template:shopbasic>