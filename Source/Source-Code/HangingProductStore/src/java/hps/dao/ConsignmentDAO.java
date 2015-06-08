package hps.dao;

import hps.dto.ConsignmentDTO;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public interface ConsignmentDAO {
    void save(ConsignmentDTO consignment);
    ConsignmentDTO get(long id);
    void delete(long id);
    List<ConsignmentDTO> getConsigmentsByStore(long storeId);
    List<ConsignmentDTO> getConsigmentsByCustomer(long customerId);
}
