package messenger;



import java.net.URL;

import javax.xml.rpc.Service;
import javax.xml.rpc.ServiceException;

public interface MessengerService extends Service {
	public MessengerRemote getSMsg() throws ServiceException;

	public MessengerRemote getSMsg(URL portAddress) throws ServiceException;

	public String getSMsgAddress();
}
