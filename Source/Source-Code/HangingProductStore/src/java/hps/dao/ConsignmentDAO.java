package hps.dao;

import hps.dto.Consignment;
import hps.dto.ConsignmentStatus;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public interface ConsignmentDAO {
    void save(Consignment consignment);
    Consignment get(long id);
    void delete(long id);
    int getNonViewRequest(long storeId);
    List<Consignment> getConsigmentsByStore(long storeId);
    List<Consignment> getConsigmentsByCustomer(long customerId);
    List<Consignment> getConsignmentByStatus(long storeId, ConsignmentStatus status);
    void makeConsignmentAsStatus(long id, ConsignmentStatus status);
}
