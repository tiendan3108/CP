/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.ultils;

/**
 *
 * @author HoangNHSE61007
 */
public class MessageString {
    
    public static final String orderFail = "Đặt hàng không thành công. Món hàng của bạn đã được người khác đặt trước, "
            + "xin vui lòng đặt món hàng khác.";
    public static final String confirmOrder = "Xác nhận đơn hàng";

    public static final String orderSuccessSMS(String orderID) {
        return "Ban da dat hang thanh cong, ma don hang cua ban la " 
                + orderID + ". Chu cua hang se lien lac lai voi ban. Sau 3 ngay neu khong toi lay hang, don hang cua ban se bi huy";
    }

    public static final String orderSuccessEmail(String orderID) {
        return "<h3>Chúc Mừng Bạn</h3> Bạn đã đặt hàng thành công, mã đơn hàng của bạn là " 
                + orderID + "<br/>" + "Cửa hàng sẽ liên lạc lại với bạn "
                +"<br/> Sau 3 ngày nếu không tới lấy hàng, đơn hàng của bạn sẽ bị hủy";
    }
    public static final String loginFail = "Tên đăng nhập hoặc mật khẩu không đúng";
    public static final String warningOrdered = "Món hàng này đã có người đặt trước bạn, "
            + "có thể bạn sẽ không mua được món hàng, vui lòng liên hệ với chủ cửa hàng để biêt thêm.";
}
