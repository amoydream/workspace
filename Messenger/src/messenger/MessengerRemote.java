package messenger;



import java.rmi.Remote;
import java.rmi.RemoteException;

public interface MessengerRemote extends Remote {
	public boolean checkTime(String sendTime) throws RemoteException;

	public boolean flushHost() throws RemoteException;

	public int init(String dbIp, String dbName, String dbPort, String user, String pwd)
		throws RemoteException;

	public Object invoke(String shell) throws RemoteException;

	public void main(String[] args) throws RemoteException;

	public String recvMo(String apiCode, String loginName, String loginPwd)
		throws RemoteException;

	public String recvRPT(String apiCode, String loginName, String loginPwd)
		throws RemoteException;

	public int release() throws RemoteException;

	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException;

	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, long srcID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url, String sendTime)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, String url)
		throws RemoteException;

	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, String sendTime, long smID, long srcID)
		throws RemoteException;
}
