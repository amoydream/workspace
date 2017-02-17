package jason.ss.tao.syntax;

public class BreakTest {

	public static void main(String[] args) {
		ok : for(int i = 0; i < 100; i++) {
			System.out.println("i = " + i);
			for(int j = 0; j < 100; j++) {
				if(j == 10) {
					System.out.println("j = " + j);
					break ok;
				}
			}
		}
	}
}
