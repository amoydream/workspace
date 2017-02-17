package messenger;


import java.rmi.RemoteException;

public class MessengerImpl implements MessengerRemote {
	@Override
	public boolean checkTime(String sendTime) throws RemoteException {
		return false;
	}

	@Override
	public boolean flushHost() throws RemoteException {
		return false;
	}

	@Override
	public int init(String dbIp, String dbName, String dbPort, String user, String pwd)
		throws RemoteException {
		return -3;
	}

	@Override
	public Object invoke(String shell) throws RemoteException {
		return null;
	}

	@Override
	public void main(String[] args) throws RemoteException {
	}

	@Override
	public String recvMo(String apiCode, String loginName, String loginPwd)
		throws RemoteException {
		return null;
	}

	@Override
	public String recvRPT(String apiCode, String loginName, String loginPwd)
		throws RemoteException {
		return null;
	}

	@Override
	public int release() throws RemoteException {
		return -3;
	}

	@Override
	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, long srcID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url, String sendTime)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, String url)
		throws RemoteException {
		return -3;
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, String sendTime, long smID, long srcID)
		throws RemoteException {
		return -3;
	}
}
