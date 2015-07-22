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

    public static final String sendPriceSMS(String orderID, float price, String storeOwner) {
        return "Don hang voi ma " + orderID + " co gia la : " + price + ". Vui long lien he voi chu cua hang " + storeOwner + " de biet them chi tiet";
    }

    public static final String cancelOrderSMS(String orderID, String storeOwner) {
        return "Don hang voi ma " + orderID + " cua ban da bi huy. Vui long lien he voi " + storeOwner + " de biet them chi tiet";
    }

    public static final String cancelOrderEmail(String orderID, String storeOwner, String consignorName) {
        return "Xin chào " + consignorName + "</br>Đơn hàng với mã đơn hàng "
                + orderID + " đã bị hủy. Vui lòng liên hệ với chủ cửa hàng " + storeOwner
                + " để biết thêm chi tiết.</br> Trân trọng</br> HPS System";
    }

    public static final String Subject() {
        return "[HPS] Quản lý hàng kí gửi";
    }

    public static final String soldProductSMS(String consignmentID, String storeOwner) {
        return "Mon hang voi ma ki gui " + consignmentID + " da duoc ban. Vui long lien he voi chu cua hang " + storeOwner + " de biet them chi tiet.";
    }

    public static final String soldProductEmail(String consignorName, String consignmentID, String storeOwner) {
        return "Xin chào " + consignorName + "</br>Món hàng với mã kí gửi "
                + consignmentID + " đã được bán. Vui lòng liên hệ với chủ cửa hàng " + storeOwner
                + " để biết thêm chi tiết.</br> Trân trọng</br> HPS System";
    }
    public static final String orderFail = "Đặt hàng không thành công. Món hàng của bạn đã được người khác đặt trước, "
            + "xin vui lòng đặt món hàng khác.";
    public static final String confirmOrder = "Xác nhận đơn hàng";

    public static final String orderSuccessSMS(String orderID) {
        return "Ban da dat hang thanh cong, ma don hang cua ban la "
                + orderID + ". Chu cua hang se lien lac lai voi ban. Sau 3 ngay neu khong toi lay hang, don hang cua ban se bi huy";
    }

    public static final String orderSuccessEmail(String orderID) {
        return "<h3>Chúc Mừng Bạn</h3> Bạn đã đặt hàng thành công, mã đơn hàng của bạn là "
                + orderID + "<br/>" + "Cửa hàng sẽ liên lạc lại với bạn."
                + "<br/> Đơn đặt hàng của bạn chỉ có giá trị trong vòng 3 ngày";
    }
    public static final String loginFail = "Tên đăng nhập hoặc mật khẩu không đúng";

    public static final String warningOrdered(long num) {
        return "Món hàng này đã có " + num + " người đặt, "
                + "có thể bạn sẽ không mua được món hàng, vui lòng liên hệ với chủ cửa hàng để biêt thêm.";
    }

    public static final String orderSuccess(String orderID) {
        return "Bạn đã đặt hàng thành công. Mã đơn hàng của bạn là " + orderID + "."
                + "<br/> <br/>Chủ cửa hàng sẽ liên lạc giá sản phẩm cho bạn sau.";
    }
    public static final String titleNofitication = "Hệ thống HPS";
    public static final String contenNofitication(int num){
        return "Hôm nay có "+num +" món hàng cần lấy";
    }
}
