package hps.blo;

import hps.dao.InMemoryConsignmentDAO;
import hps.dao.InMemoryCustomerDAO;
import hps.dao.InMemoryStoreDAO;
import hps.dto.Consignment;
import hps.dto.Customer;
import hps.dto.ProductDTO;
import hps.dto.Store;
import java.util.Date;

/**
 *
 * @author Phuc Tran
 */
public class ConsignmentBLOFactory {

    public static ConsignmentBLO getDemoInstance() {
        ConsignmentBLO blo = new DefaultConsignmentBLO(
                new InMemoryCustomerDAO(),
                new InMemoryConsignmentDAO(),
                new InMemoryStoreDAO());

        populate(blo);

        return blo;
    }

    private static void populate(ConsignmentBLO blo) {
        // Store
        Store krStore = new Store();
        krStore.setName("KR Store");
        krStore.setAddress("26, Quang Trung Go Vap");

        // Consignment 1
        Customer c1 = new Customer();
        c1.setName("Yến");
        c1.setAddress("130 Trần Quang Khải, P. Tân Định, Quận 1, TPHCM ");
        c1.setPhone("0903409192");

        ProductDTO p1 = new ProductDTO();
        p1.setName("Casio Watch");
        p1.setDescription("Molestias excepturi sint occaecati cupiditate non"
                + " provident, similique sunt in culpa quis tempor incididunt"
                + " ut et dolore et dolorum fuga. Ut non libero consectetur"
                + " adipiscing elit magna. Sed et quam lacus."
                + " Lorem ipsum dolor sit amet, dolore eiusmod quis tempor"
                + " incididunt ut et dolore Ut veniam unde nostrudlaboris."
                + " Sed unde omnis iste natus error sit voluptatem.");

        Consignment con1 = new Consignment();
        con1.setRequestDate(new Date(2015, 4, 21));
        con1.setConsignPrice(12000D);
        con1.setTransferDate(new Date(2015, 4, 25));

        blo.saveConsignment(c1, p1, krStore, con1);

        // Consignment 2
        Customer c2 = new Customer();
        c2.setName("Lê Thị Minh Luân");
        c2.setAddress("424 Hùng Vương, Hội An ");
        c2.setPhone("0905223659");

        ProductDTO p2 = new ProductDTO();
        p2.setName("Casio Watch Gold ");

        Consignment con2 = new Consignment();
        con2.setRequestDate(new Date(2015, 4, 11));
        con2.setConsignPrice(14000D);
        con2.setTransferDate(new Date(2015, 4, 22));

        blo.saveConsignment(c2, p2, krStore, con2);

        // Consignment 3
        Customer c3 = new Customer();
        c3.setName("Hùng");
        c3.setAddress("TP.HCM");
        c3.setPhone("08123456");

        ProductDTO p3 = new ProductDTO();
        p3.setName("Channel Handbag");

        Consignment con3 = new Consignment();
        con3.setRequestDate(new Date(2015, 4, 10));
        con3.setTransferDate(new Date(2015, 4, 15));

        blo.saveConsignment(c3, p3, krStore, con3);

        // Consignment 4
        ProductDTO p4 = new ProductDTO();
        p4.setName("Calvin Klein Belt");

        Consignment con4 = new Consignment();
        con4.setRequestDate(new Date(2015, 4, 9));
        con4.setConsignPrice(13000D);
        con4.setCustomerName("Quang Thong");
        con4.setCustomerPhone("0933678686");

        blo.saveConsignment(null, p4, krStore, con4);

        // Consignment 5
        ProductDTO p5 = new ProductDTO();
        p5.setName("Nike Shoes");

        Consignment con5 = new Consignment();
        con5.setRequestDate(new Date(2015, 4, 9));
        con5.setConsignPrice(22000D);
        con5.setCustomerName("Hương");
        con5.setCustomerPhone("12395222");

        blo.saveConsignment(null, p5, krStore, con5);

        // Consignment 6
        ProductDTO p6 = new ProductDTO();
        p6.setName("Gucci Sunglasses");

        Consignment con6 = new Consignment();
        con6.setRequestDate(new Date(2015, 4, 9));
        con6.setCustomerName("An");
        con6.setCustomerPhone("098445334");

        blo.saveConsignment(null, p6, krStore, con6);
    }
}
