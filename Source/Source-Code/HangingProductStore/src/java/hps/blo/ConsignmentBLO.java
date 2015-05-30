package hps.blo;

import hps.dto.Consignment;
import hps.dto.Customer;
import hps.dto.ProductDTO;
import hps.dto.Store;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public interface ConsignmentBLO {
    void saveConsignment(Customer customer, ProductDTO product, Store store, Consignment consignment);
    Consignment getConsignment(long id);
    int getNonViewRequest(long storeId);
    List<Consignment> getConsigmentsByStore(long storeId);
    List<Consignment> getConsigmentsByCustomer(long customerId);
    void makeConsignmentAsViewed(long id);
    void makeConsignmentAsAccepted(long id);
    void makeConsignmentAsRefused(long id);
    void makeConsignmentAsTransfered(long id);
    void makeConsignmentAsCanceled(long id);
    List<Customer> getConsignorsByStore(long storeId);
}
