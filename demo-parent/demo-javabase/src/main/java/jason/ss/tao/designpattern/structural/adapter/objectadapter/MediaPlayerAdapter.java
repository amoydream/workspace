package jason.ss.tao.designpattern.structural.adapter.objectadapter;

public class MediaPlayerAdapter implements VedioPlayer {
	private MusicPlayer musicPlayer = new MusicPlayer();

	public void playMusic(String uri) {
		musicPlayer.playMusic(uri);
	}

	@Override
	public void playVedio(String uri) {
		System.out.println("Playing " + uri);
	}
}
