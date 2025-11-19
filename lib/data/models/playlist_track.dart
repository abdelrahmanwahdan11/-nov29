class PlaylistTrack {
  final String id;
  final String title;
  final String artist;
  final int durationSec;
  final String coverImageUrl;
  final bool isPlaying;

  const PlaylistTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.durationSec,
    required this.coverImageUrl,
    this.isPlaying = false,
  });

  PlaylistTrack copyWith({bool? isPlaying}) {
    return PlaylistTrack(
      id: id,
      title: title,
      artist: artist,
      durationSec: durationSec,
      coverImageUrl: coverImageUrl,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
