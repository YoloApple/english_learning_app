import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/listening_item.dart';

class ListeningDetailPage extends StatefulWidget {
  final ListeningItem item;

  const ListeningDetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ListeningDetailPageState createState() => _ListeningDetailPageState();
}

class _ListeningDetailPageState extends State<ListeningDetailPage> with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Setup animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // Setup audio player
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    // Listen for state changes
    _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Listen for duration changes
    _player.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    // Listen for position changes
    _player.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    // Auto-load the audio
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      final asset = widget.item.assetPath.replaceFirst('assets/', '');
      await _player.setSource(AssetSource(asset));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load audio: $e')),
      );
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  Future<void> _seekTo(Duration position) async {
    await _player.seek(position);
  }

  Future<void> _setPlaybackSpeed(double speed) async {
    await _player.setPlaybackRate(speed);
    setState(() {
      _playbackSpeed = speed;
    });
  }

  void _skipBackward() {
    _seekTo(Duration(seconds: _position.inSeconds - 10));
  }

  void _skipForward() {
    _seekTo(Duration(seconds: _position.inSeconds + 10));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _player.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallDevice = screenSize.width < 360;

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 180, // Fixed height to avoid skewing
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Center the title
              title: Text(
                widget.item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, // Center text alignment
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'audioIcon-${widget.item.id}',
                    child: Icon(
                      Icons.headphones,
                      size: 64, // Fixed size to avoid skewing
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(_animation),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Fixed padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Center all content
                    children: [
                      // Audio Player Controls
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16), // Fixed padding
                          child: Column(
                            children: [
                              // Slider for seeking
                              Slider(
                                value: _position.inSeconds.toDouble(),
                                min: 0,
                                max: _duration.inSeconds.toDouble() > 0
                                    ? _duration.inSeconds.toDouble()
                                    : 1,
                                onChanged: (value) {
                                  _seekTo(Duration(seconds: value.toInt()));
                                },
                                activeColor: Theme.of(context).colorScheme.primary,
                              ),

                              // Duration display
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_formatDuration(_position)),
                                    Text(_formatDuration(_duration)),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Control buttons - Made responsive
                              isSmallDevice
                                  ? _buildCompactControls()
                                  : _buildRegularControls(),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Transcript section
                      Container(
                        width: double.infinity, // Full width container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Only align text within this container
                          children: [
                            Text(
                              'Transcript',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            widget.item.transcript,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // For smaller screens - stacked controls layout
  Widget _buildCompactControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
      children: [
        // First row - Speed and Skip backward
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center align horizontally
          children: [
            _buildSpeedButton(),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.replay_10),
              iconSize: 30,
              onPressed: _skipBackward,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Second row - Play/pause and Skip forward
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center align horizontally
          children: [
            // Play/pause button
            // Nút chính giữa (Play/Pause)
            Container(
              width: 48, // Giảm từ 60
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    key: ValueKey<bool>(_isPlaying),
                    color: Colors.white,
                  ),
                ),
                iconSize: 24, // Giảm từ 32
                onPressed: _togglePlayPause,
                padding: EdgeInsets.zero,
              ),
            ),

            const SizedBox(width: 16),

            IconButton(
              icon: const Icon(Icons.replay_10),
              iconSize: 24, // Giảm từ 30 hoặc 34
              onPressed: _skipBackward,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Third row - Repeat button
        IconButton(
          icon: const Icon(Icons.repeat),
          iconSize: 26,
          color: Colors.grey,
          onPressed: () async {
            await _seekTo(Duration.zero);
            await _player.resume();
          },
        ),
      ],
    );
  }

  // For medium to large screens - row-based controls layout
  Widget _buildRegularControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSpeedButton(),

        const SizedBox(width: 8),

        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 22,
          padding: EdgeInsets.zero,
          onPressed: _skipBackward,
        ),

        const SizedBox(width: 6),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                key: ValueKey<bool>(_isPlaying),
                color: Colors.white,
              ),
            ),
            iconSize: 22,
            padding: EdgeInsets.zero,
            onPressed: _togglePlayPause,
          ),
        ),

        const SizedBox(width: 6),

        IconButton(
          icon: const Icon(Icons.forward_10),
          iconSize: 22,
          padding: EdgeInsets.zero,
          onPressed: _skipForward,
        ),

        const SizedBox(width: 6),

        IconButton(
          icon: const Icon(Icons.repeat),
          iconSize: 20,
          padding: EdgeInsets.zero,
          onPressed: () async {
            await _seekTo(Duration.zero);
            await _player.resume();
          },
        ),
      ],
    );
  }

  Widget _buildSpeedButton() {
    final List<double> speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

    return PopupMenuButton<double>(
      initialValue: _playbackSpeed,
      onSelected: _setPlaybackSpeed,
      itemBuilder: (context) {
        return speedOptions.map((speed) {
          return PopupMenuItem<double>(
            value: speed,
            child: Text('${speed}x'),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _playbackSpeed != 1.0
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '${_playbackSpeed}x',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _playbackSpeed != 1.0
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}